Drop table newtable;
Drop table temp;
Drop table runs;
Drop table runsAllowed;
Drop table gamesPitching;
Drop table gamesBatting;
Drop table gamesStarted;
Drop table awards;
Drop table rbi;
Drop table oba;
Drop table era;
Drop table slg;
Drop table obp;
Drop table salary;
Drop table yearsPlayed;
Drop table yearsRetired;
Drop table homeRunsPerYear;
Drop table runsAllowedPerGame;
Drop table gamesPitchingPerYear;
Drop table gamesBattingPerYear;
Drop table gamesFielding;
Drop table totalGames;
Drop table managersWins;
Drop table allStarAppearances;

-- CREATE TABLE newtable1 as SELECT people.playerID, s.awardCount from people left join (select playerID, count(*) as awardCount from AwardsPlayers group by playerID) as s ON people.playerID = s.playerID;

CREATE TABLE temp AS 
SELECT people.playerID, 
(CASE WHEN EXISTS 
    (SELECT 1 FROM halloffame WHERE halloffame.playerId = people.playerId) 
        THEN 'TRUE' 
        ELSE 'FALSE'
END) AS class  
from people;

CREATE TABLE yearsPlayed
Select temp.playerID, 
    CASE WHEN (DATEDIFF(finalGame, debut)/365) IS NULL THEN 0 ELSE (DATEDIFF(finalGame, debut)/365) END AS yearsPlayed 
    from (SELECT p.playerId, 
    CASE WHEN debut = '' OR debut IS NULL  THEN NULL ELSE debut END AS debut,
    CASE WHEN finalGame = '' OR finalGame IS NULL THEN CURDATE() ELSE finalGame END AS finalGame
FROM people p) as temp;

CREATE TABLE yearsRetired
Select temp.playerID, 
    CASE WHEN (DATEDIFF(CURDATE(), finalGame)/365) IS NULL THEN 0 ELSE (DATEDIFF(CURDATE(), finalGame)/365) END AS yearsRetired 
    from (SELECT p.playerId, 
    CASE WHEN finalGame IS NULL OR finalGame = '' THEN CURDATE() ELSE finalGame END AS finalGame
FROM people p) as temp;

CREATE TABLE gamesPitching
SELECT p.playerId, 
    CASE WHEN SUM(G) IS NULL THEN 0 ELSE SUM(G) END AS gamesPitching
FROM people p 
LEFT JOIN pitching pitch
ON p.playerId = pitch.playerId
GROUP BY playerId;

CREATE TABLE runs
SELECT p.playerId, 
    CASE WHEN SUM(R) IS NULL THEN 0 ELSE SUM(R) END AS runs
FROM people p 
    LEFT JOIN batting b 
        ON p.playerId = b.playerId
GROUP BY playerId;

CREATE TABLE runsAllowed
SELECT p.playerId, 
    CASE WHEN SUM(R) IS NULL THEN 0 ELSE SUM(R) END AS runsAllowed
FROM people p 
    LEFT JOIN pitching pt
        ON p.playerId = pt.playerId
GROUP BY playerId;

CREATE TABLE homeRunsPerYear
SELECT r.playerId, 
    CASE WHEN NULLIF(runs/yearsPlayed, 0) IS NULL THEN 0 ELSE NULLIF(runs/yearsPlayed, 0) END AS homeRunsPerYear
FROM runs r 
    LEFT JOIN yearsPlayed yp 
        ON r.playerId = yp.playerId;

CREATE TABLE runsAllowedPerGame
SELECT r.playerId, 
    CASE WHEN NULLIF(runsAllowed/gamesPitching, 0) IS NULL THEN 0 ELSE NULLIF(runsAllowed/gamesPitching, 0) END AS runsAllowedPerGame
FROM runsAllowed r 
    LEFT JOIN gamesPitching gp 
        ON r.playerId = gp.playerId;

CREATE TABLE rbi
SELECT p.playerId, 
    CASE WHEN SUM(RBI) IS NULL THEN 0 ELSE SUM(RBI) END AS rbi
FROM people p 
    LEFT JOIN batting b 
        ON p.playerId = b.playerId
GROUP BY playerId;

CREATE TABLE salary
SELECT p.playerId, 
    CASE WHEN AVG(salary) IS NULL THEN 0 ELSE AVG(salary) END AS salary
FROM people p 
    LEFT JOIN salaries s 
        ON p.playerId = s.playerId
GROUP BY playerId;

CREATE TABLE gamesPitchingPerYear
SELECT gp.playerId, 
    CASE WHEN NULLIF(gamesPitching/yearsPlayed, 0) IS NULL THEN 0 ELSE NULLIF(gamesPitching/yearsPlayed, 0) END AS gamesPitchingPerYear
FROM gamesPitching gp
    LEFT JOIN yearsPlayed yp 
        ON gp.playerId = yp.playerId;

CREATE TABLE gamesBatting
SELECT p.playerId, 
    CASE WHEN SUM(G) IS NULL THEN 0 ELSE SUM(G) END AS gamesBatting
FROM people p 
LEFT JOIN batting bat
ON p.playerId = bat.playerId
GROUP BY playerId;

CREATE TABLE gamesBattingPerYear
SELECT gb.playerId, 
    CASE WHEN NULLIF(gamesBatting/yearsPlayed, 0) IS NULL THEN 0 ELSE NULLIF(gamesBatting/yearsPlayed, 0) END AS gamesBattingPerYear
FROM gamesBatting gb
    LEFT JOIN yearsPlayed yp 
        ON gb.playerId = yp.playerId;

CREATE TABLE gamesStarted
SELECT p.playerId, 
    CASE WHEN SUM(GS) IS NULL THEN 0 ELSE SUM(GS) END AS gamesStarted
FROM people p 
LEFT JOIN pitching pitch
ON p.playerId = pitch.playerId
GROUP BY playerId;

CREATE TABLE awards
SELECT p.playerId, 
    (SELECT COUNT(*) FROM awardsPlayers WHERE awardsPlayers.playerID = p.playerID) AS awardCount
FROM people p;

CREATE TABLE oba
SELECT p.playerId,
    CASE WHEN AVG(BAOpp) IS NULL THEN 0 ELSE AVG(BAOpp) END AS oba
FROM people p
LEFT JOIN pitching pitch
ON p.playerID = pitch.playerId
GROUP BY playerId;

CREATE TABLE era
SELECT p.playerId,
    CASE WHEN AVG(ERA) IS NULL THEN 0 ELSE AVG(ERA) END AS era
FROM people p
LEFT JOIN pitching pitch
ON p.playerID = pitch.playerId
GROUP BY playerId;

CREATE TABLE slg 
SELECT p.playerId,
CASE 
    WHEN SUM(H) IS NULL THEN 0
    WHEN SUM(2B) IS NULL THEN 0
    WHEN SUM(3B) IS NULL THEN 0
    WHEN SUM(HR) IS NULL THEN 0
    WHEN SUM(AB) IS NULL THEN 0
    WHEN SUM(AB) = 0 THEN 0
    WHEN (SUM(H) + SUM(2B) + 2*SUM(3B) + 3*SUM(HR))/SUM(AB) IS NULL THEN 0
    ELSE (SUM(H) + SUM(2B) + 2*SUM(3B) + 3*SUM(HR))/SUM(AB)
END AS slg
FROM people p 
    LEFT JOIN batting b 
        ON p.playerId = b.playerId
GROUP BY playerId;

CREATE TABLE obp
Select temp.playerID, 
    CASE WHEN (temp.H + temp.BB + temp.HBP)/NULLIF((temp.AB + temp.BB + temp.HBP + temp.SF), 0) IS NULL THEN 0 ELSE (temp.H + temp.BB + temp.HBP)/(temp.AB + temp.BB + temp.HBP + temp.SF) END AS obp 
    from (SELECT p.playerId, 
    CASE WHEN AVG(H) IS NULL THEN 0 ELSE AVG(H) END AS H,
    CASE WHEN AVG(BB) IS NULL THEN 0 ELSE AVG(BB) END AS BB,
    CASE WHEN AVG(HBP) IS NULL THEN 0 ELSE AVG(HBP) END AS HBP,
    CASE WHEN AVG(AB) IS NULL THEN 0 ELSE AVG(AB) END AS AB,
    CASE WHEN AVG(SF) IS NULL THEN 0 ELSE AVG(SF) END AS SF
FROM people p
    LEFT JOIN batting b
        ON p.playerID = b.playerID
GROUP BY playerId) as temp;

CREATE TABLE gamesFielding
SELECT p.playerId, 
    SUM(IFNULL(G, 0)) AS gamesFielding
FROM people p
LEFT JOIN fielding f
ON p.playerId = f.playerId
GROUP BY playerId;

CREATE TABLE totalGames
SELECT b.playerId,
  IFNULL(GREATEST(COALESCE(gamesBatting,0), COALESCE(gamesPitching,0), COALESCE(gamesFielding,0)), 0) AS totalGames
FROM gamesBatting b
LEFT JOIN gamesPitching p
ON b.playerID = p.playerID
LEFT JOIN gamesFielding f
ON b.playerID = f.playerID;

CREATE TABLE managersWins
SELECT p.playerId,
    CASE WHEN SUM(G) IS NULL THEN 0 ELSE SUM(G) END AS managersWins
FROM people p
LEFT JOIN managers m
ON p.playerId = m.playerId
GROUP BY playerId;

CREATE TABLE allStarAppearances
SELECT p.playerId,
    CASE 
    WHEN SUM(GP) > 0 THEN 1 
    ELSE 0
END AS allStar
FROM people p
LEFT JOIN allStarFull a
ON p.playerId = a.playerId
GROUP BY playerId;

-- CREATE TABLE newtable AS 
-- SELECT * from 
-- awards 
-- natural join runs 
-- natural join runsAllowed
-- natural join gamesPitching
-- natural join gamesBatting
-- natural join gamesStarted 
-- natural join oba 
-- natural join era
-- natural join slg
-- natural join obp
-- natural join allStarAppearances
-- natural join yearsPlayed
-- natural join homeRunsPerYear
-- natural join gamesPitchingPerYear
-- natural join gamesBattingPerYear
-- natural join temp
-- natural join runsAllowedPerYear;

CREATE TABLE newtable AS 
SELECT * from 
awards 
natural join homeRunsPerYear
natural join yearsPlayed
natural join runsAllowed
natural join yearsRetired
natural join totalGames
natural join managersWins
natural join temp;

-- Drop table newtable1;
Drop table temp;
Drop table runs;
Drop table runsAllowed;
Drop table gamesPitching;
Drop table gamesBatting;
Drop table gamesStarted;
Drop table awards;
Drop table rbi;
Drop table oba;
Drop table era;
Drop table slg;
Drop table obp;
Drop table salary;
drop table yearsPlayed;
Drop table yearsRetired;
Drop table homeRunsPerYear;
Drop table runsAllowedPerGame;
Drop table gamesPitchingPerYear;
Drop table gamesBattingPerYear;
Drop table totalGames;
Drop table gamesFielding;
Drop table managersWins;
Drop table allStarAppearances;

SELECT 'playerID', 'awardCount', 'homeRunsPerYear', 'yearsPlayed', 'runsAllowed', 'yearsRetired', 'totalGames', 'managersWins', 'class'
UNION ALL
SELECT *
FROM
    newtable
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/taskA.csv'
FIELDS ENCLOSED BY '' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';
