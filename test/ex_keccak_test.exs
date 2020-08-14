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
  end
end
