import AOC

aoc 2022, 3 do
  defp priority(letter) do
    ascii = :binary.first(letter)

    cond do
      String.match?(letter, ~r/[A-Z]/) -> ascii - 38
      String.match?(letter, ~r/[a-z]/) -> ascii - 96
    end
  end

  def common_item({slot1, slot2}) do
    s1 = slot1 |> String.to_charlist() |> MapSet.new()
    s2 = slot2 |> String.to_charlist() |> MapSet.new()
    MapSet.intersection(s1, s2) |> MapSet.to_list() |> to_string()
  end

  defp split_contents(input) when is_binary(input) do
    len = input |> String.length()
    input |> String.split_at(div(len, 2))
  end

  defp rucksacks(input) when is_binary(input) do
    input |> String.split("\n") |> Enum.map(&split_contents/1)
  end

  defp elf_groups(input) when is_binary(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn x ->
      x |> to_charlist() |> MapSet.new()
    end)
    |> Enum.chunk_every(3)
  end

  def p1(input) do
    input |> rucksacks() |> Enum.map(&common_item/1) |> Enum.map(&priority/1) |> Enum.sum()
  end

  def p2(input) do
    input
    |> elf_groups()
    |> Enum.map(fn x ->
      s1 = MapSet.intersection(Enum.at(x, 0), Enum.at(x, 1))
      MapSet.intersection(s1, Enum.at(x, 2)) |> MapSet.to_list() |> to_string()
    end)
    |> Enum.map(&priority/1)
    |> Enum.sum()
  end
end
