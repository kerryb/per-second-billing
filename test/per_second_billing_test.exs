defmodule PerSecondBillingTest do
  use ExUnit.Case

  describe "PerSecondBilling.report/1" do
    test "produces an empty report if no time has been booked" do
      assert PerSecondBilling.report([]) == """
             DATE, HOUR_0, HOUR_1, HOUR_2, HOUR_3, HOUR_4, HOUR_5, HOUR_6, HOUR_7, HOUR_8, HOUR_9, HOUR_10, HOUR_11, HOUR_12, HOUR_13, HOUR_14, HOUR_15, HOUR_16, HOUR_17, HOUR_18, HOUR_19, HOUR_20, HOUR_21, HOUR_22, HOUR_23
             """
    end

    test "allocates the time correctly for a single reported period within a single day" do
      assert PerSecondBilling.report(["2021-12-24 08:35:41 2021-12-24 17:53:50"]) == """
             DATE, HOUR_0, HOUR_1, HOUR_2, HOUR_3, HOUR_4, HOUR_5, HOUR_6, HOUR_7, HOUR_8, HOUR_9, HOUR_10, HOUR_11, HOUR_12, HOUR_13, HOUR_14, HOUR_15, HOUR_16, HOUR_17, HOUR_18, HOUR_19, HOUR_20, HOUR_21, HOUR_22, HOUR_23
             2021-12-24, 0, 0, 0, 0, 0, 0, 0, 0, 1459, 3600, 3600, 3600, 3600, 3600, 3600, 3600, 3600, 3230, 0, 0, 0, 0, 0, 0
             """
    end

    test "allocates the time correctly for multiple reported periods on different days" do
      assert PerSecondBilling.report([
               "2021-12-24 08:35:41 2021-12-24 17:53:50",
               "2021-12-26 09:35:41 2021-12-24 16:53:50"
             ]) == """
             DATE, HOUR_0, HOUR_1, HOUR_2, HOUR_3, HOUR_4, HOUR_5, HOUR_6, HOUR_7, HOUR_8, HOUR_9, HOUR_10, HOUR_11, HOUR_12, HOUR_13, HOUR_14, HOUR_15, HOUR_16, HOUR_17, HOUR_18, HOUR_19, HOUR_20, HOUR_21, HOUR_22, HOUR_23
             2021-12-24, 0, 0, 0, 0, 0, 0, 0, 0, 1459, 3600, 3600, 3600, 3600, 3600, 3600, 3600, 3600, 3230, 0, 0, 0, 0, 0, 0
             2021-12-26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1459, 3600, 3600, 3600, 3600, 3600, 3600, 3230, 0, 0, 0, 0, 0, 0, 0
             """
    end
  end
end
