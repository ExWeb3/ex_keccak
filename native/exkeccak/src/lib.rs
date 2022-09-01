use rustler::Binary;
use rustler::Env;
use rustler::NewBinary;
use tiny_keccak::Hasher;
use tiny_keccak::Keccak;

rustler::init!("Elixir.ExKeccak", [hash_256]);

#[rustler::nif]
fn hash_256<'a>(env: Env<'a>, data: Binary) -> Binary<'a> {
    let mut keccak = Keccak::v256();

    keccak.update(data.as_slice());

    let mut result: [u8; 32] = [0; 32];
    keccak.finalize(&mut result);

    let mut erl_bin: NewBinary = NewBinary::new(env, 32);
    erl_bin.as_mut_slice().copy_from_slice(&result);

    erl_bin.into()
}
