defmodule ChromossomeAgent do

    alias GenAgent

    @chromossome_size_gen 4

    def new(quantity_gens \\ @chromossome_size_gen) do
        %Chromossome{quantity_gens: quantity_gens}
        |> fill_chromossome()
    end

    def fill_chromossome(chromossome) do
        chromossome |> Map.put(:gens, get_chain_gens([], chromossome.quantity_gens))
    end

    def get_chain_gens(chain, count) when count > 0 do
        count = count - 1
        case count > 0 do
            true ->
                List.insert_at(chain, 0, GenAgent.new)
                get_chain_gens(chain, count)
            false ->
                List.insert_at(chain, 0, GenAgent.new)
        end
    end

end
