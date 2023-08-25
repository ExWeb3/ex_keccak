defmodule ExKeccak do
  version = Mix.Project.config()[:version]

  @external_resource "README.md"
  @moduledoc "README.md"
             |> File.read!()

  env_config = Application.compile_env(:rustler_precompiled, :force_build, [])

  use RustlerPrecompiled,
    otp_app: :ex_keccak,
    crate: "exkeccak",
    base_url: "https://github.com/tzumby/ex_keccak/releases/download/v#{version}",
    force_build: System.get_env("RUSTLER_BUILD") in ["1", true] or env_config[:ex_keccak],
    targets:
      Enum.uniq(["aarch64-unknown-linux-musl" | RustlerPrecompiled.Config.default_targets()]),
    version: version

  def hash_256(_data), do: :erlang.nif_error(:nif_not_loaded)
end
