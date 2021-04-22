defmodule ExKeccak.Impl do
  @moduledoc false

  use Rustler, otp_app: :ex_keccak, crate: :exkeccak
  def hash_256(_data), do: :erlang.nif_error(:nif_not_loaded)
end
