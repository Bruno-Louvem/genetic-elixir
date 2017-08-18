defmodule Genetic do
    @moduledoc false

    defstruct [
        generation_size: nil,
        generations: nil,
        population_size: nil,
        crossover_tax: nil,
        mutation_tax: nil
    ]

    import Integer
    alias GenAgent
    alias ChromossomeAgent
    alias GeneticView, as: View

    def init do
        build |> run #|> finish
    end

    def build() do
        View.welcome
        struct(Genetic, get_params)
    end

    def run(count, generation) when count > 0 do
        count = count - 1
        with true <- count > 0,
             new_generation <- tournament(generation) |> next_generation,
             false <- new_generation.winner
        do
            run(count, new_generation)
        else
            _ -> finish
        end
    end

    def run(genetic) do
        first_generation = create_generation(genetic.population_size,
                                             genetic.crossover_tax,
                                             genetic.mutation_tax)
        # run(genetic.generation_size, first_generation)
    end

    def finish() do
        View.results
    end

    def get_params() do
        View.ask_params([generation_size: [type: "integer", label: "How many generations"],
                         population_size: [type: "integer", label: "Population Size"],
                         crossover_tax: [type: "float", label: "Crossover Tax"],
                         mutation_tax: [type: "float", label: "Mutation Tax"]])
    end

    def selection(generation) do
        get_pairs(generation.population)
    end

    def tournament(generation) do
        population = selection(generation)
                     |> Enum.map(fn(x) ->
                            GenAgent.compare(Enum.at(x, 0),Enum.at(x, 1))
                        end)
        generation |> Map.put(:population, population) 
    end

    def next_generation(generation) do
        generation
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
            true -> List.insert_at(population, 0, ChromossomeAgent.new)
                    |> create_population(size)
            false -> List.insert_at(population, 0, ChromossomeAgent.new)
        end
    end

    defp create_generation(size, co_tax, mt_tax) do
        %Generation{
            population_size: size,
            population: to_even(size) |> create_population,
            crossover_tax: co_tax,
            mutation_tax: mt_tax,
        }
    end

    def to_even(number) do
        if Integer.is_even(number), do: number, else: number - 1
    end
end
