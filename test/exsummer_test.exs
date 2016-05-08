defmodule ExSummerTest do
  use ExUnit.Case
  doctest ExSummer

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "Sum sample dimensioned trans" do
    seq =
    [
      {[{:country, "Russia"}, {:city, "Moscow"}, {:area, "ZAO"}], 50000},
      {[{:country, "Russia"}, {:city, "Moscow"}, {:area, "UZAO"}], 60000},
      {[{:country, "USA"}, {:city, "Seattle"}, {:area, "Downtown"}], 30000},
      {[{:country, "USA"}, {:city, "New-York"}, {:area, "Manhathen"}], 1000000},
      {[{:country, "USA"}, {:city, "Moscow"}], 9000}
    ]
    sum_by_countries = %{%{country: "Russia"} => 110000, %{country: "USA"} => 1039000}
    assert Summer.sum(
      seq,
      [:country]
      ) === sum_by_countries
    sum_by_cities =
    %{
      %{city: "Moscow"} => 119000,
      %{city: "Seattle"} => 30000,
      %{city: "New-York"} => 1000000
    }
    assert Summer.sum(
      seq,
      [:city]
    ) === sum_by_cities
    sum_by_countries_cities =
    %{
      %{country: "Russia", city: "Moscow"} => 110000,
      %{country: "USA", city: "Moscow"} => 9000,
      %{country: "USA", city: "New-York"} => 1000000,
      %{country: "USA", city: "Seattle"} => 30000
    }
    assert Summer.sum(
      seq,
      [:country, :city]
    ) === sum_by_countries_cities
  end
end
