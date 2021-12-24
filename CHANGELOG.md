# Changelog

## 0.3.0

  * Update rustler to 0.23.0

## 0.2.2

  * Fixes a build issue with the included Cargo files

## 0.2.1

  * Adds `aarch64-apple-darwin` as a target to fix linking errors when compiling on Apple M1

## 0.2.0

  * Use stable version of ruslter

## 0.2.0-rc.2

  * Fix nif path configuration

## 0.2.0-rc.1

  * Update rustler to support OTP 24
  * Leave only throwing function

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
