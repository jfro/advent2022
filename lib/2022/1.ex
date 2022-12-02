import AOC

aoc 2022, 1 do
  def p1(input) do
    get_elf_sums(input) |> Enum.max()
  end

  def p2(input) do
    get_elf_sums(input) |> Enum.sort() |> Enum.reverse() |> Enum.take(3) |> Enum.sum()
  end

  defp get_elf_sums(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(fn elf ->
      elf |> String.split("\n") |> Enum.map(&String.to_integer/1) |> Enum.sum()
    end)
  end
end
