Drop table taskBData;
Drop table class;
Drop table homeRuns;
Drop table gamesPitching;
Drop table gamesBatting;
Drop table gamesFielding;
Drop table totalGames;
Drop table awards;
Drop table oba;
Drop table era;
Drop table slg;
Drop table obp;
Drop table allStarAppearances;
Drop table yearsPlayed;
Drop table finalGame;
Drop table completeGames;
Drop table zr;

CREATE TABLE class AS 
SELECT DISTINCT halloffame.playerID, 
CASE WHEN halloffame.playerId IN 
    (SELECT DISTINCT halloffame.playerID 
    FROM halloffame
    WHERE inducted = 'Y')
THEN 'TRUE' ELSE 'FALSE' END AS class  
FROM halloffame;

CREATE TABLE homeRuns
SELECT c.playerId, 
    CASE WHEN SUM(HR) IS NULL THEN 0 ELSE SUM(HR) END AS homeRuns
FROM class c
LEFT JOIN batting b 
ON c.playerId = b.playerId
GROUP BY playerId;

CREATE TABLE gamesPitching
SELECT c.playerId, 
    SUM(IFNULL(G, 0)) AS gamesPitching
FROM class c 
LEFT JOIN pitching pitch
ON c.playerId = pitch.playerId
GROUP BY playerId;

CREATE TABLE gamesBatting
SELECT c.playerId, 
    SUM(IFNULL(G, 0)) AS gamesBatting
FROM class c
LEFT JOIN batting bat
ON c.playerId = bat.playerId
GROUP BY playerId;

CREATE TABLE gamesFielding
SELECT c.playerId, 
    SUM(IFNULL(G, 0)) AS gamesFielding
FROM class c
LEFT JOIN fielding f
ON c.playerId = f.playerId
GROUP BY playerId;

CREATE TABLE totalGames
SELECT b.playerId,
  IFNULL(GREATEST(COALESCE(gamesBatting,0), COALESCE(gamesPitching,0), COALESCE(gamesFielding,0)), 0) AS totalGames
FROM gamesBatting b
LEFT JOIN gamesPitching p
ON b.playerID = p.playerID
LEFT JOIN gamesFielding f
ON b.playerID = f.playerID;

CREATE TABLE awards
SELECT c.playerId, 
    (SELECT COUNT(*) FROM awardsPlayers WHERE awardsPlayers.playerID = c.playerID) AS awardCount
FROM class c;

CREATE TABLE oba
SELECT c.playerId,
    IFNULL(AVG(BAOpp),999) AS oba
FROM class c
LEFT JOIN pitching pitch
ON c.playerId = pitch.playerId
GROUP BY playerId;

CREATE TABLE era
SELECT c.playerId,
    IFNULL(AVG(ERA),999) AS era
FROM class c
LEFT JOIN pitching pitch
ON c.playerId = pitch.playerId
GROUP BY playerId;

CREATE TABLE slg 
SELECT c.playerId,
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
FROM class c 
LEFT JOIN batting b 
ON c.playerId = b.playerId
GROUP BY playerId;

CREATE TABLE obp
Select temp.playerID, 
    CASE WHEN (temp.H + temp.BB + temp.HBP)/NULLIF((temp.AB + temp.BB + temp.HBP + temp.SF), 0) IS NULL THEN 0 ELSE (temp.H + temp.BB + temp.HBP)/(temp.AB + temp.BB + temp.HBP + temp.SF) END AS obp 
    from (SELECT c.playerId, 
    CASE WHEN AVG(H) IS NULL THEN 0 ELSE AVG(H) END AS H,
    CASE WHEN AVG(BB) IS NULL THEN 0 ELSE AVG(BB) END AS BB,
    CASE WHEN AVG(HBP) IS NULL THEN 0 ELSE AVG(HBP) END AS HBP,
    CASE WHEN AVG(AB) IS NULL THEN 0 ELSE AVG(AB) END AS AB,
    CASE WHEN AVG(SF) IS NULL THEN 0 ELSE AVG(SF) END AS SF
FROM class c
LEFT JOIN batting b
ON c.playerId = b.playerID
GROUP BY playerId) as temp;

CREATE TABLE allStarAppearances
SELECT c.playerId,
    IFNULL(SUM(GP),0) AS allStar
FROM class c
LEFT JOIN allStarFull a
ON c.playerId = a.playerId
GROUP BY playerId;

CREATE TABLE yearsPlayed
Select temp.playerID, 
    CASE WHEN (DATEDIFF(finalGame, debut)/365) IS NULL THEN 0 ELSE (DATEDIFF(finalGame, debut)/365) END AS yearsPlayed 
    from (SELECT p.playerId, debut, 
    CASE WHEN finalGame IS NULL THEN CURDATE() ELSE finalGame END AS finalGame
FROM people p) as temp;

CREATE TABLE finalGame
SELECT p.playerID, 
    IFNULL(finalGame,CURDATE())
FROM people p;

CREATE TABLE completeGames
SELECT c.playerId, 
    SUM(IFNULL(CG, 0)) AS completeGames
FROM class c 
LEFT JOIN pitching pitch
ON c.playerId = pitch.playerId
GROUP BY playerId;

CREATE TABLE zr
SELECT c.playerId, 
    IFNULL(AVG(zr), 0) AS uzr
FROM class c 
LEFT JOIN fielding f
ON c.playerId = f.playerId
GROUP BY playerId;

CREATE TABLE taskBData AS 
SELECT * from awards 
natural join homeRuns 
natural join totalGames
natural join oba 
natural join era
natural join slg
natural join obp
natural join allStarAppearances
natural join yearsPlayed
natural join finalGame
natural join completeGames
natural join zr
natural join class;

Drop table class;
Drop table homeRuns;
Drop table gamesPitching;
Drop table gamesBatting;
Drop table gamesFielding;
Drop table totalGames;
Drop table awards;
Drop table oba;
Drop table era;
Drop table slg;
Drop table obp;
Drop table allStarAppearances;
Drop table yearsPlayed;
-- Drop table finalGame;
Drop table completeGames;
Drop table zr;

SELECT 
'playerId', 'awardCount', 'homeRuns', 'totalGames', 'oba', 'era', 'slg', 'obp', 'allStar', 'yearsPlayed', 'finalGame', 'completeGames', 'zr', 'class'
UNION
SELECT *
FROM
    taskBData
INTO OUTFILE '~/ece356-lab4/taskB.csv'
FIELDS ENCLOSED BY '' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';