defmodule ExKeccak do
  use Rustler, otp_app: :ex_keccak, crate: :exkeccak, path: "native/exkeccak"

  def hash_256(_data), do: :erlang.nif_error(:nif_not_loaded)
end
