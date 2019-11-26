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

with decade_stats as (

    with games_per_year as (
        select year       as yearid,
               sum(games) as total_games
        from homegames
        group by year),

         batting_stats_per_year as (
             select yearid,
                    sum(so) as total_strikeouts,
                    sum(hr) as total_hr
             from batting
             group by yearid)

    select date_part('decade', to_date(bspy.yearid::varchar, 'YYYY')) as decade,
           sum(total_games)                                           as games,
           sum(total_strikeouts)                                      as strikeouts,
           sum(total_hr)                                              as homeruns,
           round(sum(total_hr) / sum(total_games), 2)                 as avg_hr_per_game,
           round(sum(total_strikeouts) / sum(total_games), 2)         as avg_so_per_game

    from games_per_year gpy
             inner join batting_stats_per_year bspy
                        on gpy.yearid = bspy.yearid and bspy.yearid >= 1920
    group by decade)

select round((corr(avg_hr_per_game, avg_so_per_game) * 100)::numeric, 3) as hr_so_corr
from decade_stats;
