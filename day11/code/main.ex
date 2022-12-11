defmodule Monkey do
  @enforce_keys [:n, :queue, :operation, :divisible_by, :if_true, :if_false, :inspection_count]
  defstruct [:n, :queue, :operation, :divisible_by, :if_true, :if_false, :inspection_count]

  def parse_stdin() do
    number_line = IO.read(:line)
    items_line = IO.read(:line)
    op_line = IO.read(:line)
    test_line = IO.read(:line)
    if_true_line = IO.read(:line)
    if_false_line = IO.read(:line)
    IO.read(:line)

    if if_false_line == :eof do
      nil
    else
      {number, _} = number_line |> String.split |> Enum.at(1) |> String.trim(":") |> Integer.parse
      items = items_line |> String.split(": ") |> Enum.at(1) |> String.split(", ") |> Enum.map(&(Integer.parse(&1) |> elem(0)))
      [lhs, op, rhs] = op_line |> String.split(" = ") |> Enum.at(1) |> String.split
      operation = fn n ->
        x = if lhs == "old" do n else Integer.parse(lhs) |> elem(0) end
        y = if rhs == "old" do n else Integer.parse(rhs) |> elem(0) end
        if op == "+" do x + y else x * y end
      end
      {divisible_by, _} = test_line |> String.split("by ") |> Enum.at(1) |> Integer.parse
      {if_true, _} = if_true_line |> String.split("monkey ") |> Enum.at(1) |> Integer.parse
      {if_false, _} = if_false_line |> String.split("monkey ") |> Enum.at(1) |> Integer.parse
      queue = items |> Enum.reduce(:queue.new, fn item, queue -> :queue.in(item, queue) end)

      %Monkey{
        n: number,
        queue: queue,
        operation: operation,
        divisible_by: divisible_by,
        if_true: if_true,
        if_false: if_false,
        inspection_count: 0,
      }
    end
  end

  def parse_all_stdin() do
    helper = fn (this, monkeys) ->
      monkey = Monkey.parse_stdin
      if monkey == nil do
        monkeys
      else
        this.(this, Map.put(monkeys, monkey.n, monkey))
      end
    end

    helper.(helper, %{})
  end

  def run(monkey) do
    receive do
      {:dbg} -> Monkey.run(IO.inspect(monkey))
      {:push, item} -> Monkey.run(%Monkey { monkey | queue: :queue.in(item, monkey.queue) })
      {:inspection_count, who_asks} ->
        send(who_asks, {:inspection_count, monkey.inspection_count})
        Monkey.run(monkey)
      {:turn, monkeys, div3, modulo, done} ->
        queue_each = fn q, f -> :queue.fold(fn x, _ -> f.(x) end, nil, q) end
        queue_each.(monkey.queue, fn item ->
          after_op = monkey.operation.(item)
          after_div = if div3 do div(after_op, 3) else after_op end
          normalized = rem(after_div, modulo)
          test_result = rem(normalized, monkey.divisible_by) == 0
          next_monkey_num = if test_result do monkey.if_true else monkey.if_false end
          send(monkeys[next_monkey_num], {:push, normalized})
        end)
        send(done, {:done})
        Monkey.run(%Monkey { monkey |
          queue: :queue.new,
          inspection_count: monkey.inspection_count + :queue.len(monkey.queue)
        })
    end
  end
end

defmodule Main do
  def main() do
    part = Enum.at(System.argv(), 0)
    div3 = part != "2"
    rounds = if part == "2" do 10000 else 20 end

    monkeys = Monkey.parse_all_stdin
    all_divisors = monkeys |> Enum.map(fn {_, monkey} -> monkey.divisible_by end)
    modulo = all_divisors |> Enum.reduce(&(&1 * &2))
    pids = monkeys |> Enum.map(fn {num, monkey} -> {num, spawn(fn -> Monkey.run(monkey) end)} end) |> Map.new
    Enum.each(1..rounds, fn _round ->
      Enum.each(pids, fn {_num, pid} ->
        send(pid, {:turn, pids, div3, modulo, self()})
        receive do {:done} -> nil end
      end)
    end)
    results = Enum.map(pids, fn {_num, pid} ->
      send(pid, {:inspection_count, self()})
      receive do
        {:inspection_count, count} -> count
      end
    end)
    [first, second | _] = results |> Enum.sort(:desc)
    IO.puts(first * second)
  end
end
