# ExKeccak

[![Build Status](https://www.travis-ci.com/tzumby/ex_keccak.svg?branch=master)](https://www.travis-ci.com/tzumby/ex_keccak)

ExKeccak is a NIF that wraps the KECCAK-256 function from the [tiny-keccak](https://github.com/debris/tiny-keccak) Rust library. KECCAK-256 is used by Ethereum.

## Installation

`ex_keccak` requires Rust to be installed.

The package can be installed by adding `ex_keccak` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_keccak, "~> 0.2.0"}
  ]
end
```

## Usage

To calculate KECCAK-256 hash, use `ExKeccak.hash_256/1` function. It returns `result` on success:

```elixir
  <<28, 138, 255, 149, 6, 133, 194, 237, 75, 195, 23, 79, 52, 114, 40, 123, 86, 217, 81, 123, 156, 148, 129, 39, 49, 154, 9, 167, 163, 109, 234, 200>> = ExKeccak.hash_256("hello")
```

And it returns `ArgumentError` is provided data is not binary

## Contributing

1. [Fork it!](https://github.com/tzumby/ex_keccak)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

ExKeccak is released under the Apache-2.0 License.
