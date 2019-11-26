/*
    QUESTION::
        Find the average number of strikeouts per game by decade since 1920.
        Round the numbers you report to 2 decimal places.
        Do the same for home runs per game.
        Do you see any trends?

    GROUPS::
        * decade

    FILTERS::
        * >= 1920

    CHARACTERISTICS::
        * avg strikeouts per game
        * avg home runs per game
        * trends / correlation?

    BREAKDOWN::
        * look at year, strikeouts, homeruns
        * filter above 1920
        * map over decade
        * How many total decades are there?
        * How many strikeouts, homeruns, game counts per decade?
        * What are the avgs per decade?
        * What are the trends?


    Example output:

        decade | total_games | total_so | avg_so_per_game | total_hr | avg_hr_per_game
        _____________________________________________________________________________
        foo    | bar         | baz      | ...             | ...      | ...

*/

select *
from teams;
