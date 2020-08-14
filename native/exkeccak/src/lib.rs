use rustler::{Env, Error, Term};
use rustler::types::binary::{Binary, OwnedBinary};
use rustler::types::Encoder;
use tiny_keccak::{Hasher, Keccak};

mod atoms {
    rustler::rustler_atoms! {
        atom ok;
        atom error;
    }
}

rustler::rustler_export_nifs! {
    "Elixir.ExKeccak",
    [
        ("hash_256", 1, hash_256, rustler::SchedulerFlags::DirtyCpu)
    ],
    None
}

fn hash_256<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let data: Binary = args[0].decode()?;
    let data_slice = data.as_slice();

    let mut keccak = Keccak::v256();

    keccak.update(data_slice);

    let mut result: [u8; 32] = [0; 32];
    keccak.finalize(&mut result);

    let mut erl_bin: OwnedBinary = OwnedBinary::new(32).unwrap();
    erl_bin.as_mut_slice().copy_from_slice(&result);

    Ok((atoms::ok(), erl_bin.release(env)).encode(env))
}
