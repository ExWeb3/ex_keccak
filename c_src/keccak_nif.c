#include "erl_nif.h"
#include "sha3.h"
#include <string.h>

typedef sha3_ctx_t context_t;

static ErlNifResourceType *CONTEXT_TYPE;
static ERL_NIF_TERM atom_ok;
static ERL_NIF_TERM atom_error;
static ERL_NIF_TERM atom_invalid_resource;
static ERL_NIF_TERM atom_out_of_memory;

static ERL_NIF_TERM keccak_init(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
    context_t *ctx = NULL;
    int bit_size = 0;
    ERL_NIF_TERM ret;
    if (argc != 1 || !enif_get_int(env, argv[0], &bit_size)) {
        return enif_make_badarg(env);
    }
    ctx = (context_t *) enif_alloc_resource(CONTEXT_TYPE, sizeof(context_t));
    if(ctx) {
        if(sha3_init(ctx, bit_size / 8)) {
            ret = enif_make_resource(env, ctx);
            // Let Elixir gc
            enif_release_resource(ctx);
            int *context_num = (int *) enif_priv_data(env);
            (*context_num)++;
            return enif_make_tuple2(env, atom_ok, ret);
        } else {
            enif_release_resource(ctx);
            return enif_make_badarg(env);
        }
    } else {
        return enif_make_tuple2(env, atom_error, atom_out_of_memory);
    }
}

static ERL_NIF_TERM keccak_update(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
    context_t *ctx = NULL;
    ErlNifBinary data;
    if (argc != 2) {
        return enif_make_badarg(env);
    }
    if (!enif_is_binary(env, argv[1])) {
        return enif_make_badarg(env);
    }
    if (!enif_inspect_binary(env, argv[1], &data)) {
        return enif_make_badarg(env);
    }
    if (!enif_get_resource(env, argv[0], CONTEXT_TYPE, (void **) &ctx) || ctx == NULL) {
        return enif_make_tuple2(env, atom_error, atom_invalid_resource);
    }
    sha3_update(ctx, (uint32_t*)data.data, data.size);
    return argv[0];
}

static ERL_NIF_TERM keccak_final(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
    context_t *ctx = NULL;
    ErlNifBinary output;
    ERL_NIF_TERM ret;
    if (argc != 1) {
        return enif_make_badarg(env);
    }
    if (!enif_get_resource(env, argv[0], CONTEXT_TYPE, (void **) &ctx) || ctx == NULL) {
        return enif_make_tuple2(env, atom_error, atom_invalid_resource);
    }
    if (!enif_alloc_binary(ctx->mdlen, &output)) {
        return enif_make_tuple2(env, atom_error, atom_out_of_memory);
    }
    sha3_final(output.data, ctx);
    ret = enif_make_binary(env, &output);
    enif_release_binary(&output);
    return ret;
}

static ERL_NIF_TERM keccak_hash(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
    int bit_size = 0;
    ErlNifBinary input;
    ErlNifBinary output;
    ERL_NIF_TERM ret;
    if (argc != 2) {
        return enif_make_badarg(env);
    }
    if (!enif_is_binary(env, argv[1]) || !enif_inspect_binary(env, argv[1], &input)) {
        return enif_make_badarg(env);
    }
    if (!enif_get_int(env, argv[0], &bit_size) || (bit_size != 256 && bit_size != 384 && bit_size != 512)) {
        return enif_make_badarg(env);
    }
    if (!enif_alloc_binary(bit_size / 8, &output)) {
        return enif_make_tuple2(env, atom_error, atom_out_of_memory);
    }
    if(sha3(input.data, input.size, output.data, output.size)) {
        ret = enif_make_binary(env, &output);
        enif_release_binary(&output);
        return ret;
    } else {
        enif_release_binary(&output);
        return enif_make_tuple2(env, atom_error, atom_error);
    }
}

static void free_context_resource(ErlNifEnv *env, void *obj) {
    int *context_num = (int *) enif_priv_data(env);
    (*context_num)--;
}

static inline int init_context_resource(ErlNifEnv *env) {
    const char *mod = "Elixir.ExKeccak";
    const char *name = "Context";
    int flags = ERL_NIF_RT_CREATE | ERL_NIF_RT_TAKEOVER;

    CONTEXT_TYPE = enif_open_resource_type(env, mod, name, free_context_resource, (ErlNifResourceFlags) flags, NULL);
    if (CONTEXT_TYPE == NULL) return -1;
    return 0;
}


static int init_nif(ErlNifEnv *env, void **priv_data, ERL_NIF_TERM load_info) {
    if (init_context_resource(env) == -1) {
        return -1;
    }
    int *context_num = (int *) enif_alloc(sizeof(int));
    (*context_num) = 0;
    *priv_data = (void *) context_num;
    atom_ok = enif_make_atom(env, "ok");
    atom_error = enif_make_atom(env, "error");
    atom_invalid_resource = enif_make_atom(env, "invalid_resource");
    atom_out_of_memory = enif_make_atom(env, "out_of_memory");
    return 0;
}

static void destroy_inf(ErlNifEnv *env, void *priv_data) {
    if (priv_data) {
        enif_free(priv_data);
    }
}

static ErlNifFunc ic_sec_nif_funcs[] =
{
    {"hash_init", 1, keccak_init},
    {"hash_update",    2, keccak_update,ERL_NIF_DIRTY_JOB_CPU_BOUND},
    {"hash_final", 1, keccak_final, ERL_NIF_DIRTY_JOB_CPU_BOUND},
    {"hash_calc",    2, keccak_hash,ERL_NIF_DIRTY_JOB_CPU_BOUND},
};

ERL_NIF_INIT(Elixir.ExKeccak, ic_sec_nif_funcs, init_nif, NULL, NULL, destroy_inf)
