/*
    QUESTION::
        Find all players in the database who played at Vanderbilt University.
        Create a list showing each player’s first and last names
        as well as the total salary they earned in the major leagues.
        Sort this list in descending order by the total salary earned.

        > Which Vanderbilt player earned the most money in the majors?

    GROUPS::
        * player

    FILTERS::
        * played at vandy
        * top salary earner (sorted)

    CHARACTERISTICS::
        * first and last name
        * total salary earned in major leagues

    BREAKDOWN::
        1. Who played at vandy?
        2. What are their names?
        3. How much did they earn?


    Example output:

        player_first_name | player_last_name | total_salary
        ___________________________________________________
        foo               | bar              | baz          <--- Top Earner
        ...               | ...              | ...

*/

with vandy_players as (
    select distinct playerid
    from collegeplaying
    where schoolid = 'vandy')

select p.namefirst || ' ' || p.namelast as full_name,
       sum(salary)::numeric::money      as total_salary_earned

from vandy_players vp
         inner join people p using (playerid)
         inner join salaries s on p.playerid = s.playerid

group by vp.playerid, full_name
order by total_salary_earned desc
limit 1;


