defmodule Summer do
  # function head
  def sum(seq, groping)

  def sum(seq, grouping) when seq |> is_list and grouping |> is_list do
    Enum.reduce(seq, %{},
      fn ({dimension, value}, cur_totals) ->
        dim_key = dimension |> extract_key(grouping)
        case cur_totals |> Map.fetch(dim_key) do
          {:ok, cur_value} ->
            cur_totals |> Map.put(dim_key, cur_value + value)
          :error ->
            cur_totals |> Map.put_new(dim_key, value)
        end
      end)
  end

  defp extract_key(dimension_combination, dimension_set)
  when dimension_combination |> is_list and dimension_set |> is_list do
    dimension_map = dimension_set |> Map.new(&({&1, nil}))
    Enum.reduce(dimension_combination, dimension_map,
      fn ({dim_type, dim_code}, acc_map) ->
        case acc_map |> Map.fetch(dim_type) do
          {:ok, _}->
            acc_map |> Map.put(dim_type, dim_code)
          :error -> # means this dimension does not interest us (is not in our considered dimension set)
            acc_map
        end
      end)
  end
end
