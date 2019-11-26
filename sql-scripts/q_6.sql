/*
    QUESTION::
        Find the player who had the most success stealing bases in 2016,
        where success is measured as::
            percentage of stolen base attempts which are successful
            * (A stolen base attempt results either in a stolen base or being caught stealing.)

        Consider only players who attempted at least 20 stolen bases.

    GROUPS::
        * player

    FILTERS::
        * only for 2016
        * stealing attempts >= 20

    CHARACTERISTICS::
        * player name
        * Stealing success rate as %
        * optionally::
            * # caught stealing
            * # stolen bases

    BREAKDOWN::
        1. What are the player stealing stats for 2016?
        2. apply filters
        3. Calculate success pct
        4. Who was the MOST successful?


    Example output:

        player_name | pct_successful
        ____________________________
        foo         | bar

*/

select p.namefirst || ' ' || p.namelast        as name,
       cs                                      as caught_stealing_count,
       sb                                      as stolen_base_count,
       round(sb / (cs + sb)::numeric * 100, 3) as pct_successful
from batting b
         inner join people p on b.playerid = p.playerid
where yearid = 2016
  and cs + sb >= 20
order by pct_successful desc;

