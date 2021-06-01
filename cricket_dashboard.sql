------------------------------------------------------------
----------------- cricket_dashboard ------------------------
------------------------------------------------------------

--- url : https://www.youtube.com/watch?v=aTkVJMgrnH8

"""
Input
-----

Match_No  Team_A        Team_B        Winner
1         WESTINDIES    SRILANKA      WESTINDIES
2         INDIA         SRILANKA      INDIA
3         AUSTRALIA     SRILANKA      AUSTRALIA
etc...



Output
------

Team_Name   No_of_Matches_Played  Matches_WON   Matches_LOSS
INDIA       4                     3             1
etc...

"""

--Answer--
----------

with matches_played as (
                          select team_name, count(*) as cnt from (
                          select team_a team_name from cricket 
                          union all 
                          select team_b team_name from cricket)
                          group by team_name),
      matches_won as (select Winner, count(*)
                      from cricket 
                      group by Winner)
      select team_name,
             matches_played.cnt total_matches,
             coalesce(matches_won.cnt,0) Matches_WON
             matches_played.cnt - coalesce(matches_won.cnt,0) Matches_LOSS
             from matches_played full outer join matches_won
             on matches_played.team_name = matches_won.Winner;
