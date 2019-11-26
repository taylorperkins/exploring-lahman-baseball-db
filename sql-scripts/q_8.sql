/*
    QUESTION::
        Using the attendance figures from the homegames table,
        find the teams and parks which had the top 5 average attendance per game
        in 2016.
        Average attendance is defined as::
            total attendance divided by number of games

        Only consider parks where there were at least 10 games played.
        Report the park name, team name, and average attendance.
        Repeat for the lowest 5 average attendance.


    GROUPS::
        * teams
        * parks

    FILTERS::
        * 2016
        * top 5 avg attendance (limit)
        * bottom 5 avg attendance (limit)

    CHARACTERISTICS::
        * park name
        * team name
        * avg attendance

    BREAKDOWN::
        * Are parks and teams separate groups, or should I use them
          as a combined group? How can I see their relationship?
        * Filter to 2016
        * Calculate total attendance and number of games per group
        * Filter to groups with at least 10 games played
        * Calculate avg attendance per game
        * How can we get the top 5 and bottom 5 in the same table?
        * How can we label them separately?


    Example output:

        park name | team name | avg attendance
        ______________________________________
        foo       | bar       | baz

*/

with attendance_stats as (
    select team, park, round(sum(attendance) / sum(games)) as avg_attendance
    from homegames
    where year = 2016
    group by team, park)

select *
from (

    (
        select *, 'top' as category
        from attendance_stats
        order by avg_attendance desc
        limit 5
    )

    UNION ALL

    (
        select *, 'bottom' as category
        from attendance_stats
        order by avg_attendance
        limit 5
    )

) as sub
order by avg_attendance desc;
