defmodule Genetic do
  @moduledoc """
  Documentation for Genetic.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Genetic.hello
      :world

  """
  def init do

    genA = %Gen{sequence: "10100100"}
    genB = %Gen{sequence: "11100100"}
    genC = %Gen{sequence: "10111010"}

    chromossome = %Chromossome{ gens: [genA, genB, genC]}

    {:ok, genA.sequence}
  end
end
