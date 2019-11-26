/*
    QUESTION::
        How often from 1970 – 2016 was it the case that a
        team with the most wins also won the world series?
        What percentage of the time?

    GROUPS::
        * team
        * year

    FILTERS::
        * between 1970 and 2016
        * did win ws
        * team did have most wins per year

    CHARACTERISTICS::
        * count of team that did have the most wins and
          did win ws
        * pct of above

    BREAKDOWN::
        * which years had a ws?
        * Separately, rank each team per year based on total wins
        * Join both queries based on year and rank = 1
        * How many teams won ws?
        * What's the pct of the time?


    Example output:

        count | pct
        ___________
        foo   | bar

*/

with ws_years as (
    select distinct yearid
    from teams
    where wswin is not null
        and yearid between 1970 and 2016

    order by yearid),

ranked_ws_win as (
    select yearid, case when wswin = 'Y' then 1 else 0 end as did_win_ws,
           row_number() over (partition by yearid order by w desc, wswin desc) as rank

    from teams
    where wswin is not null)

select sum(did_win_ws) as count,
       round(sum(did_win_ws) / count(distinct ws_years.yearid)::numeric, 2) as pct

from ws_years
inner join ranked_ws_win on ws_years.yearid = ranked_ws_win.yearid
    and ranked_ws_win.rank = 1;
