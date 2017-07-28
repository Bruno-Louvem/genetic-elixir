defmodule GenAgent do

    def generate_rand_sequence(limit \\ 128) do
        :rand.uniform(limit) |> Integer.to_string(2)
    end
end
