defmodule ExKeccak do
  @compile {:autoload, false}
  @on_load {:init, 0}

  def init() do
    case load_nif() do
      :ok ->
        :ok
      exp ->
        raise "failed to load NIF: #{inspect exp}"
    end
  end

  defp load_nif() do
    path = :filename.join(:code.priv_dir(:ex_keccak), 'keccak_nif')
    :erlang.load_nif(path, 0)
  end


  def hash_256(data), do: hash_calc(256, data)

  # NIF
  def hash_init(_bit_size), do: :erlang.nif_error(:nif_not_loaded)
  def hash_update(_context, _input), do: :erlang.nif_error(:nif_not_loaded)
  def hash_final(_context), do: :erlang.nif_error(:nif_not_loaded)

  def hash_calc(_bit_size, _input), do: :erlang.nif_error(:nif_not_loaded)

end
