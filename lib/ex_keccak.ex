defmodule ExKeccak do
  version = Mix.Project.config()[:version]

  @external_resource "README.md"
  @moduledoc "README.md"
             |> File.read!()

  use RustlerPrecompiled,
    otp_app: :ex_keccak,
    crate: "exkeccak",
    base_url: "https://github.com/tzumby/ex_keccak/releases/download/v#{version}",
    force_build: System.get_env("RUSTLER_PRECOMPILATION_EXAMPLE_BUILD") in ["1", "true"],
    targets:
      Enum.uniq(["aarch64-unknown-linux-musl" | RustlerPrecompiled.Config.default_targets()]),
    version: version

  def hash_256(_data), do: :erlang.nif_error(:nif_not_loaded)
end
