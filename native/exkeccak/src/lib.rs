use tiny_keccak::{Hasher, Keccak};
use rustler::types::binary::Binary;
use rustler::types::binary::OwnedBinary;

rustler::init!("Elixir.ExKeccak", [hash_256]);

#[rustler::nif]
fn hash_256<'a>(data: Binary) -> OwnedBinary {
    let mut keccak = Keccak::v256();

    keccak.update(data.as_slice());

    let mut result: [u8; 32] = [0; 32];
    keccak.finalize(&mut result);

    let mut erl_bin: OwnedBinary = OwnedBinary::new(32).unwrap();
    erl_bin.as_mut_slice().copy_from_slice(&result);

    erl_bin
}
