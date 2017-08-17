defmodule GeneticView do
    def welcome() do
        IO.puts "Welcome to Genetic program"
        IO.puts "Answer some questions and see the show"
    end

    def ask_params(params) do
        Enum.map(params,fn {key, param} ->
            {key, ask(param)}
        end)
    end


    def ask(question) do
        with [type: _, label: _] <- question
        do
            resp = IO.gets "#{question[:label]}\n"

            resp
            |> String.trim()
            |> validate_type_answer(question[:type])
        else
            _ -> :error
        end
    end

    def validate_type_answer(value, type) do
        case type do
            "integer" -> String.to_integer(value)
            "float" -> Float.parse(value)
            _ -> :error
        end
    end
end
