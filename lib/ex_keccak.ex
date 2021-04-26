defmodule ExKeccak do
  defdelegate hash_256(data), to: ExKeccak.Impl

  def hash_256!(data) do
    case hash_256(data) do
      {:ok, hash} ->
        hash
      {:error, :invalid_type} ->
        raise ArgumentError, "#{inspect(data)} is not hashable"
    end
  end
end
