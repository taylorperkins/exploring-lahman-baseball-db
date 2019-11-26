/*
    QUESTION::
        What range of years does this database cover?

    GROUPS::
        -

    FILTERS::
        -

    CHARACTERISTICS::
        * min year
        * max year

    BREAKDOWN::
        Potential direction..

        1. Look at the docs:
            > This database contains pitching, hitting, and fielding statistics for
              Major League Baseball from 1871 through 2016

        2. Quick query of priority table (batting | pitching | fielding)


    Example output:

        min_year | max_year | total_years
        _________________________________
        foo      | bar      | baz

*/

select *
from teams;
