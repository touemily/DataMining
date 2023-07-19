--Change the file path. Replace all occurence of "C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/".
LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/AllstarFull.csv'   INTO TABLE AllstarFull
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/Batting.csv'   INTO TABLE Batting
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/BattingPost.csv'   INTO TABLE BattingPost
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/Fielding.csv'   INTO TABLE Fielding
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/FieldingOF.csv'   INTO TABLE FieldingOF
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/FieldingOFSplit.csv'   INTO TABLE FieldingOFSplit
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/FieldingPost.csv'   INTO TABLE FieldingPost
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/HomeGames.csv'   INTO TABLE HomeGames
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/Managers.csv'   INTO TABLE Managers
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/ManagersHalf.csv'   INTO TABLE ManagersHalf
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/Parks.csv' INTO TABLE Parks
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/People.csv'   INTO TABLE People
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/Pitching.csv'   INTO TABLE Pitching
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/PitchingPost.csv'   INTO TABLE PitchingPost
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/SeriesPost.csv'   INTO TABLE SeriesPost 
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/Teams.csv'   INTO TABLE Teams 
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/TeamsFranchises.csv'   INTO TABLE TeamsFranchises 
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/core/TeamsHalf.csv'   INTO TABLE TeamsHalf 
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

--Change the file path. Replace all occurence of "C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/contrib/".

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/contrib/AwardsManagers.csv'   INTO TABLE AwardsManagers
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/contrib/AwardsPlayers.csv'   INTO TABLE AwardsPlayers 
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/contrib/AwardsShareManagers.csv'   INTO TABLE AwardsShareManagers 
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/contrib/AwardsSharePlayers.csv'   INTO TABLE AwardsSharePlayers 
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/contrib/CollegePlaying.csv'   INTO TABLE CollegePlaying 
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/contrib/HallOfFame.csv'   INTO TABLE HallOfFame 
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/contrib/Salaries.csv'   INTO TABLE Salaries 
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/jains/Desktop/ECE 356/LAB 4/baseballdatabank-2022.2/baseballdatabank-2022.2/contrib/Schools.csv'   INTO TABLE Schools 
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;