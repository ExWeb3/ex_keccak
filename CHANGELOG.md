# Changelog

## 0.7.6

  * Update rusler Rust crate to 0.35

## 0.7.5

  * Update rusler Rust crate to 0.32
  * Fix problem with precompiled nil version missing 2.16

## 0.7.4

  * Update rusler Rust crate to 0.30

## 0.7.3

  * Add support for FreeBSD
  * Update rustler Rust crate to 0.29

## 0.7.2 (retired)

  * Add support for FreeBSD
  * Update rustler Rust crate to 0.29

## 0.7.1

  * Fix typo in README.md
  * Update rustler Rust crate to 0.27

## 0.7.0

  * Update rustler to 0.27.0
  * Use `rustler_precompiled` to ship with multiple platform re-compiled binaries

## 0.6.0

  * Update rustler to 0.26.0

## 0.5.0

  * Update rustler to 0.25.0

## 0.4.0

  * Update rustler to 0.24.0.

    this version improves performance a little bit

## 0.3.0

  * Update rustler to 0.23.0

## 0.2.2

  * Fixes a build issue with the included Cargo files

## 0.2.1

  * Adds `aarch64-apple-darwin` as a target to fix linking errors when compiling on Apple M1

## 0.2.0

  * Use stable version of rustler

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
