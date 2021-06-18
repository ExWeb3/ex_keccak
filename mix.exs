defmodule ExKeccak.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_keccak,
      version: "0.2.0-rc.1",
      elixir: "~> 1.10",
      description: description(),
      compilers: Mix.compilers(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      rustler_crates: rustler_crates(),
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
        "native/exkeccak/Cargo.toml",
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

  defp rustler_crates do
    [
      exkeccak: [
        path: "native/exkeccak",
        mode: rustc_mode(Mix.env())
      ]
    ]
  end

  defp rustc_mode(:prod), do: :release
  defp rustc_mode(_), do: :debug

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:benchee, "~> 1.0.1", only: :test},
      {:rustler, "~> 0.22.0-rc.1"}
    ]
  end
end
