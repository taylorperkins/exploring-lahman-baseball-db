/*
    QUESTION::
        Find the name and height of the shortest player in the database.
            * How many games did he play in?
            * What is the name of the team for which he played?

    GROUPS::
        * player

    FILTERS::
        * min height

    CHARACTERISTICS::
        * full name (namefirst + namelast)
        * height
        * game count

    BREAKDOWN::
        The "people" table holds characteristics about a player, but not game stats.
        The "appearances" table holds info about game count for player per year per team

        1. What is the shortest height?
        2. Who is the player with the shortest height?
        3. What is the full name of that player?
        4. What team did he play for?


    Example output:

        player_name | player_height | team_name
        _______________________________________
        foo         | bar           | baz

*/

with shortest_player as (
    select playerid, namefirst || ' ' || namelast as full_name, height
    from people
    where height = (
        select min(height) as min_height
        from people
    ))

select sp.full_name, sp.height, t.name as team_name, t.g as game_count
from shortest_player sp
inner join appearances a using(playerid)
inner join teams t on a.teamid = t.teamid and a.yearid = t.yearid;


