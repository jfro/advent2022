import AOC

aoc 2022, 4 do
  defp process_sections(entry) do
    sections =
      entry
      |> String.split("-")
      |> Enum.map(fn num ->
        {num, _} = Integer.parse(num)
        num
      end)

    start = Enum.at(sections, 0)
    stop = Enum.at(sections, 1)
    start..stop |> MapSet.new()
  end

  defp process_line(line) do
    sets = line |> String.split(",") |> Enum.map(&process_sections/1)
    first = sets |> Enum.at(0)
    second = sets |> Enum.at(1)
    {first, second}
  end

  defp fully_overlap({first, second}) do
    u = MapSet.union(first, second)

    if u == first || u == second do
      1
    else
      0
    end
  end

  defp any_overlap({first, second}) do
    overlap = MapSet.intersection(first, second) != MapSet.new()

    if overlap do
      1
    else
      0
    end
  end

  def p1(input) do
    input
    |> String.split("\n")
    |> Enum.map(&process_line/1)
    |> Enum.map(&fully_overlap/1)
    |> Enum.sum()
  end

  def p2(input) do
    input
    |> String.split("\n")
    |> Enum.map(&process_line/1)
    |> Enum.map(&any_overlap/1)
    |> Enum.sum()
  end
end
