# Changelog

## v1.0.0

  * Update rustler to support OTP 24

## v0.1.3

  * Move NIF interface to module `ExKeccak.Impl`, making `ExKeccak` a wrapper
    module (with the same API)
  * Add throwing variant API `ExKeccak.hash_256!/1` to wrapper module

## v0.1.2

  * Chore: remove /priv/native/*

## v0.1.1

  * Return `{:error, :invalid_type}` instead of raising an error when invalid data is provided


## v0.1.0

  * Initial release with Keccak 256 function
