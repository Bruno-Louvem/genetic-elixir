defmodule Genetic do
    alias GenAgent, as: Agent
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
        generation = create_generation(50, 0.5, 0.1)

        # chromossome = %Chromossome{ gens: [genA, genB, genC]}

        generation
    end

    def play_game(generation) do
        get_pairs(generation.population)
    end

    def finish(population) do
        Enum.map(population, fn(x) -> GenAgent.compare(Enum.at(x, 0), Enum.at(x, 1)) end)
    end

    defp get_pairs(population), do: length(population) |> get_pairs(population, [])

    defp get_pairs(count, population, new_population) when count == 0, do: new_population

    defp get_pairs(count, population, new_population) when count > 0 do
        pair =[Enum.at(population,count-1), Enum.at(population, count-2)]
        count = count - 2
        new_population = List.insert_at(new_population, 0, pair)
        get_pairs(count, population, new_population)
    end

    defp create_population(size), do: create_population([], size)

    defp create_population(population, size) when size > 0 do
        size = size - 1;
        case size > 0 do
            true -> List.insert_at(population, 0, %Gen{sequence: Agent.generate_rand_sequence})
                    |> create_population(size)
            false -> List.insert_at(population, 0, %Gen{sequence: Agent.generate_rand_sequence})
        end
    end

    defp create_generation(size, co_tax, mt_tax) do
        %Generation{
            population_size: size,
            population: create_population(size),
            crossover_tax: co_tax,
            mutation_tax: mt_tax,
        }
    end
end
