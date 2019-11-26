/*
    QUESTION::
        Part A, B::
            From 1970 – 2016, what is the largest number of wins for a team
            that did not win the world series?
            What is the smallest number of wins for a team that did win the world series?

            Doing this will probably result in an unusually small number of wins for a
            world series champion – determine why this is the case.
            Then redo your query, excluding the problem year

    GROUPS::
        * year
        * did win ws (bool)
            * most wins, or least wins

    FILTERS::
        * years 1970-2016
        * wswin
        * win count

    CHARACTERISTICS::
        * team (name)
        * year
        * did win ws
        * win count
        * (rank)

    BREAKDOWN::
        1. select team, year, wswin, and w from teams
        2. apply year filter

        3. How can I answer both "max wins and did not win ws" and
           "min wins and did win ws"? What structure? Can I use one structure
           to answer both?

        4. How should we rank teams?
            * window is by year AND wswin
            * order by w

            > If you partition by both year AND wswin,
              you will get ranking within the nested window.
              This will allow for appropriate ranking later on.

        >> Note the "Relies on::" in the following section!
           This tells us how we can format our previous function, and reuse the result.

        5. Start working on max_wins_and_did_not_win from the results

            Relies on::
                team | year | wswin | rank
                __________________________
                foo  | bar  | baz   | ...

            1. Filter results to get rank = 1 and wswin = false
            2. sort and limit to the row we want

        6. Start working on min_wins_and_did_win from the results

            Relies on::
                team | year | wswin
                __________________________
                foo  | bar  | baz

            1. Filter results to wswin = true (rank doesn't matter here)
            2. sort and limit to the row we want
            3. problem year?

        7. How can we join both results?

    Example output:

        team_name | year | win_count | category
        _______________________________________
        foo       | bar  | baz       | (max_wins_and_did_not_win | min_wins_and_did_win)

*/

select *
from teams;
