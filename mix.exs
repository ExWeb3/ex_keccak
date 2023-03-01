defmodule ExKeccak.MixProject do
  use Mix.Project

  @version "0.7.1"
  @source_url "https://github.com/tzumby/ex_keccak"

  def project do
    [
      app: :ex_keccak,
      version: @version,
      elixir: "~> 1.10",
      description: description(),
      compilers: Mix.compilers(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      source_url: @source_url,
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
      links: %{"GitHub" => @source_url},
      files: [
        "mix.exs",
        "native",
        "checksum-*.exs",
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
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:benchee, "~> 1.0", only: :test},
      {:rustler, ">= 0.0.0", optional: true},
      {:rustler_precompiled, "~> 0.6.1"}
    ]
  end
end
