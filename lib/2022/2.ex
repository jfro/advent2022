import AOC

aoc 2022, 2 do
  defp choice_type(input) do
    case input do
      "A" -> :rock
      "B" -> :paper
      "C" -> :scissors
      "X" -> :rock
      "Y" -> :paper
      "Z" -> :scissors
    end
  end

  defp expected_result(input) do
    case input do
      "X" -> :lose
      "Y" -> :draw
      "Z" -> :win
    end
  end

  defp match_type({opp, you}) do
    {choice_type(opp), choice_type(you)}
  end

  defp choice_score(choice) do
    case choice do
      :rock -> 1
      :paper -> 2
      :scissors -> 3
    end
  end

  defp result_score(result) do
    case result do
      :win -> 6
      :lose -> 0
      :draw -> 3
    end
  end

  defp match_result({opp, you}) do
    case {opp, you} do
      {:rock, :paper} -> :win
      {:rock, :scissors} -> :lose
      {:rock, :rock} -> :draw
      {:paper, :paper} -> :draw
      {:paper, :scissors} -> :win
      {:paper, :rock} -> :lose
      {:scissors, :paper} -> :lose
      {:scissors, :scissors} -> :draw
      {:scissors, :rock} -> :win
      _ -> raise "Invalid input"
    end
  end

  defp match_score({opp, you}) do
    our_choice_score = choice_score(you)

    our_choice_score + result_score(match_result({opp, you}))
  end

  defp match_tuples(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn row ->
      [opp, you] =
        row
        |> String.split(" ")

      {opp, you}
    end)
  end

  defp infer_match_score({opp, expected}) do
    our_choice =
      case {opp, expected} do
        {opp, :draw} ->
          opp

        {:rock, :win} ->
          :paper

        {:rock, :lose} ->
          :scissors

        {:paper, :win} ->
          :scissors

        {:paper, :lose} ->
          :rock

        {:scissors, :win} ->
          :rock

        {:scissors, :lose} ->
          :paper
      end

    choice_score(our_choice) + result_score(expected)
  end

  def p1(input) do
    match_tuples(input) |> Enum.map(&match_type/1) |> Enum.map(&match_score/1) |> Enum.sum()
  end

  def p2(input) do
    match_tuples(input)
    |> Enum.map(fn {opp, you} ->
      {choice_type(opp), expected_result(you)}
    end)
    |> Enum.map(&infer_match_score/1)
    |> Enum.sum()
  end
end
