defmodule GenAgent do

    def generate_rand_sequence(limit \\ 128) do
        length = Integer.to_string(limit, 2) |> String.length
        :rand.uniform(limit) |> dtb(length)
    end

    def compare(genA, genB) do
        seqA = btd(genA.sequence)
        seqB = btd(genB.sequence)
        compare_gens(seqA, seqB, genA, genB)
    end

    def compare_gens(seqA, seqB, genA, genB) when seqA > seqB, do: genA
    def compare_gens(seqA, seqB, genA, genB) when seqA == seqB, do: genA
    def compare_gens(seqA, seqB, genA, genB) when seqA < seqB, do: genB

    def dtb(dec, left \\ 8) do
        Integer.to_string(dec, 2) |> String.rjust(left, ?0)
    end

    def btd(bin) do
        {dec, _} = Integer.parse(bin, 2)
        dec
    end

end
