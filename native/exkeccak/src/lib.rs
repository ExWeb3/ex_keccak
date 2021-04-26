use rustler::types::binary::{Binary, OwnedBinary};
use rustler::types::Encoder;
use rustler::{Env, Term};
use tiny_keccak::{Hasher, Keccak};

mod atoms {
    rustler::rustler_atoms! {
        atom ok;
        atom error;
        atom invalid_type;
    }
}

rustler::rustler_export_nifs! {
    "Elixir.ExKeccak.Impl",
    [
        ("hash_256", 1, hash_256, rustler::SchedulerFlags::DirtyCpu)
    ],
    None
}

fn hash_256<'a>(env: Env<'a>, args: &[Term<'a>]) -> Term<'a> {
    let data: Binary = match args[0].decode() {
        Ok(binary) => binary,
        Err(_error) => return (atoms::error(), atoms::invalid_type()).encode(env),
    };
    let data_slice = data.as_slice();

    let mut keccak = Keccak::v256();

    keccak.update(data_slice);

    let mut result: [u8; 32] = [0; 32];
    keccak.finalize(&mut result);

    let mut erl_bin: OwnedBinary = OwnedBinary::new(32).unwrap();
    erl_bin.as_mut_slice().copy_from_slice(&result);

    (atoms::ok(), erl_bin.release(env)).encode(env)
}
