defmodule Genetic do
    @moduledoc false
    alias GenAgent, as: Agent
    alias GeneticView, as: View

    def init do
        start
        |> start_generation
        |> selection
        |> tournament
    end

    def start() do
        View.welcome
        View.ask_params([population_size: [type: "integer", label: "Population Size"],
                         crossover_tax: [type: "float", label: "Crossover Tax"],
                         mutation_tax: [type: "float", label: "Mutation Tax"]])
    end

    def start_generation(params) do
        create_generation(
                params[:population_size],
                params[:crossover_tax],
                params[:mutation_tax])
    end

    def selection(generation) do
        get_pairs(generation.population)
    end

    def tournament(population) do
        Enum.map(population, fn(x) -> GenAgent.compare(Enum.at(x, 0), Enum.at(x, 1)) end)
    end

    def fill_exist_population() do

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
