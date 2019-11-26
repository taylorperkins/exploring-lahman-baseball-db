/*
    QUESTION::
        Using the fielding table, group players into three groups based on their position:
            * ('OF')                   -> 'Outfield'
            * ('SS', '1B', '2B', '3B') -> 'Infield'
            * ('P', 'C')               -> 'Battery'

        Determine the number of putouts made by each of these three groups in 2016.

    GROUPS::
        * Infield, outfield, or battery

    FILTERS::
        * year = 2016
        * fielding table only

    CHARACTERISTICS::
        * total # putouts

    BREAKDOWN::
        1. Map old position to new position
        2. Filter to year
        3. How many putouts per mapped position?


    Example output:

        position | total_putouts
        ________________________
        foo      | bar

*/

select case
           when pos in ('OF') then 'Outfield'
           when pos in ('SS', '1B', '2B', '3B') then 'Infield'
           when pos in ('P', 'C') then 'Battery'
           else 'Unknown'
           end as position,
       sum(po) as total_putouts

from fielding
group by position
order by total_putouts desc;



