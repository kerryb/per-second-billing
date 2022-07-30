defmodule PerSecondBilling do
  def report(timestamp_pairs) do
    case timestamp_pairs
         |> Enum.map(&parse_period/1)
         |> Enum.reduce(%{}, &record_period/2)
         |> Enum.map(&to_csv_row/1)
         |> Enum.join("\n") do
      "" -> header()
      rows -> header() <> rows <> "\n"
    end
  end

  defp header do
    "DATE, #{Enum.map_join(0..23, ", ", &"HOUR_#{&1}")}\n"
  end

  defp parse_period(period) do
    [yr_1, mon_1, day_1, hr_1, min_1, sec_1, yr_2, mon_2, day_2, hr_2, min_2, sec_2] =
      ~r/^(\d{4})-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d) (\d{4})-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d)/
      |> Regex.run(period, capture: :all_but_first)
      |> Enum.map(&String.to_integer/1)

    {NaiveDateTime.new!(yr_1, mon_1, day_1, hr_1, min_1, sec_1),
     NaiveDateTime.new!(yr_2, mon_2, day_2, hr_2, min_2, sec_2)}
  end

  defp record_period({start_time, end_time}, report) do
    hour_values = hour_values(NaiveDateTime.to_time(start_time), NaiveDateTime.to_time(end_time))

    Map.update(
      report,
      NaiveDateTime.to_date(start_time),
      hour_values,
      &add_hour_values(&1, hour_values)
    )
  end

  defp hour_values(start_time, end_time) do
    Enum.map(0..23, &hour_value(&1, start_time, end_time))
  end

  defp hour_value(hour, start_time, _end_time) when start_time.hour > hour, do: 0
  defp hour_value(hour, _start_time, end_time) when end_time.hour < hour, do: 0

  defp hour_value(hour, start_time, end_time) do
    period_start_time = Enum.max([start_time, Time.new!(hour, 0, 0)], Time)
    period_end_time = Enum.min([end_time, Time.new!(hour + 1, 0, 0)], Time)
    Time.diff(period_end_time, period_start_time)
  end

  defp add_hour_values(existing_values, values) do
    existing_values |> Enum.zip(values) |> Enum.map(fn {a, b} -> a + b end)
  end

  defp to_csv_row({date, hour_values}) do
    Enum.join([Date.to_string(date) | hour_values], ", ")
  end
end
