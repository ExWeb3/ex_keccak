defmodule ExKeccak.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_keccak,
      version: "0.2.2",
      elixir: "~> 1.10",
      description: description(),
      compilers: Mix.compilers(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      source_url: "https://github.com/tzumby/ex_keccak",
      package: package(),
      deps: deps(),
      name: "ExKeccek"
    ]
  end

  defp package do
    [
      maintainers: ["tzumby"],
      name: "ex_keccak",
      licenses: ["Apache License 2.0"],
      links: %{"GitHub" => "https://github.com/tzumby/ex_keccak"},
      files: [
        "mix.exs",
        "native/exkeccak/src",
        "native/exkeccak/.cargo/config",
        "native/exkeccak/Cargo.toml",
        "native/exkeccak/Cargo.lock",
        "lib",
        "LICENSE",
        "README.md",
        "CHANGELOG.md"
      ]
    ]
  end

  defp description do
    "NIF library for computing Keccak SHA3-256 hashes using tiny-keccak Rust crate."
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.25", only: :dev, runtime: false},
      {:benchee, "~> 1.0.1", only: :test},
      {:rustler, "~> 0.22.0"}
    ]
  end
end
