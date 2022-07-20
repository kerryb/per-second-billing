# Per Second Billing

You've decided that your time is so valuable that you are going to bill your
clients by the second. They reluctantly agree to this but to be awkward they
tell you they want to see a break down of the seconds in each hour of the day
you've worked for them.

You need to write a program that accepts one or more pairs of date times that
specify the period you worked in the format
`YYYY-MM-DD hh:mm:ss YYYY-MM-DD hh:mm:ss`

eg:

    2021-12-24 08:35:41 2021-12-24 17:53:50, 2022-01-02 20:11:12 2022-01-03 08:23:44

Your program should then produce a CSV output (with a header row) of the
results to the following specification:

    DATE, HOUR_0, HOUR_1, HOUR_2 ... HOUR_23

eg for the two periods in the previous example:

    DATE, HOUR_0, HOUR_1, HOUR_2, HOUR_3, HOUR_4, HOUR_5, HOUR_6, HOUR_7, HOUR_8, HOUR_9, HOUR_10, HOUR_11, HOUR_12, HOUR_13, HOUR_14, HOUR_15, HOUR_16, HOUR_17, HOUR_18, HOUR_19, HOUR_20, HOUR_21, HOUR_22, HOUR_23
    2021-12-24, 0, 0, 0, 0, 0, 0, 0, 0, 1459, 3600, 3600, 3600, 3600, 3600, 3600, 3600, 3600, 3230, 0, 0, 0, 0, 0, 0
    2022-01-02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2928, 3600, 3600, 3600
    2022-01-03, 3600, 3600, 3600, 3600, 3600, 3600, 3600, 3600, 1424, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
