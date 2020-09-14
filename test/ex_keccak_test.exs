defmodule ExKeccakTest do
  use ExUnit.Case
  doctest ExKeccak

  describe "hash_256/1" do
    test "returns expected hash" do
      data =
        Base.decode64!(
          "5d1Ch4jboo9DcCWGj55ZT/tsW4nnG5+DlCFGddOfjTZmfQdzc4yBnodqszjYIaI+8Io41a789cV5rUwzvqxLzw=="
        )

      {:ok, hashed_data} = ExKeccak.hash_256(data)

      assert <<_::binary-12, address::binary-20>> = hashed_data

      assert Base.encode16(address, case: :lower) == "73bb50c828fd325c011d740fde78d02528826156"
    end

    test "fails to decode number" do
      assert {:error, :invalid_type} = ExKeccak.hash_256(11)
    end

    test "fails to decode nil" do
      assert {:error, :invalid_type} = ExKeccak.hash_256(nil)
    end

    test "fails to decode atom" do
      assert {:error, :invalid_type} = ExKeccak.hash_256(:atom)
    end

    @tag :perf
    @tag timeout: 300_000
    test "sequencial performance test" do
      data = :crypto.strong_rand_bytes(100)

      Benchee.run(
        %{
          "ex_keccak" => fn ->
            ExKeccak.hash_256(data)
          end
        },
        time: 100,
        memory_time: 100
      )
    end

    @tag :perf
    @tag timeout: 300_000
    test "parallel performance test" do
      data = :crypto.strong_rand_bytes(100)

      Benchee.run(
        %{
          "ex_keccak" => fn ->
            ExKeccak.hash_256(data)
          end
        },
        time: 100,
        memory_time: 100,
        parallel: 4
      )
    end
  end
end
