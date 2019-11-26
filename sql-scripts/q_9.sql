/*
    QUESTION::
        Which managers have won the TSN Manager of the Year award in
        both the National League (NL) and the American League (AL)?
        Give their full name and the teams that they were
        managing when they won the award.

    GROUPS::
        * playerid (manager)

    FILTERS::
        * did win TSN award
        * NL AND AL

    CHARACTERISTICS::
        * full name
        * team they coached when won award
        * year

    BREAKDOWN::
        * Which managers won TSN award?
        * apply NL or AL filters
        * Which managers show up for both?
        * How can we get the team for these years?
        * how can we get team names?
        * how can we get manager names?


    Example output:

        fullname | year | team_name
        ___________________________
        foo      | bar  | baz

*/

with reappearing_managers as (
    select playerid, awardid

    from awardsmanagers
    where awardid = 'TSN Manager of the Year'
        and lgid in ('NL', 'AL')

    group by playerid, awardid
    having count(distinct lgid) = 2)

select
       p.namefirst || ' ' || p.namelast as fullname,
       am.yearid as year,
       t.name as team_name

from reappearing_managers rm
inner join awardsmanagers am using(playerid, awardid)
inner join managers m on rm.playerid = m.playerid and am.yearid = m.yearid
inner join people p on rm.playerid = p.playerid
inner join teams t on m.teamid = t.teamid and am.yearid = t.yearid and am.lgid = t.lgid
order by am.yearid;
