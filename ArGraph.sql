USE MASTER
GO
DROP DATABASE IF EXISTS ArGraph
GO
CREATE DATABASE ArGraph
GO
USE ArGraph
GO

-- Создание таблицы Пользователи
CREATE TABLE Users (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
) AS NODE;

-- Создание таблицы Артисты
CREATE TABLE Artists (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
) AS NODE;

-- Создание таблицы Песни
CREATE TABLE Songs (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    duration INT NOT NULL, 
) AS NODE;


-- Добавление узлов в таблицу Пользователи
INSERT INTO Users (id, name, email) VALUES
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com'),
(3, 'Charlie', 'charlie@example.com'),
(4, 'David', 'david@example.com'),
(5, 'Eve', 'eve@example.com'),
(6, 'Frank', 'frank@example.com'),
(7, 'Grace', 'grace@example.com'),
(8, 'Henry', 'henry@example.com'),
(9, 'Ivy', 'ivy@example.com'),
(10, 'Jack', 'jack@example.com');

-- Добавление узлов в таблицу Артисты
INSERT INTO Artists (id, name, genre) VALUES
(1, 'The Beatles', 'Rock'),
(2, 'Michael Jackson', 'Pop'),
(3, 'Pink Floyd', 'Rock'),
(4, 'Madonna', 'Pop'),
(5, 'Led Zeppelin', 'Rock'),
(6, 'Beyoncé', 'R&B'),
(7, 'Elvis Presley', 'Rock and Roll'),
(8, 'Queen', 'Rock'),
(9, 'Bob Marley', 'Reggae'),
(10, 'David Bowie', 'Rock');

-- Добавление узлов в таблицу Песни
INSERT INTO Songs (id, name, duration) VALUES
(1, 'Hey Jude', 431),
(2, 'Billie Jean', 294),
(3, 'Comfortably Numb', 382),
(4, 'Like a Prayer', 344),
(5, 'Stairway to Heaven', 482),
(6, 'Single Ladies (Put a Ring on It)', 203),
(7, 'Hound Dog', 136),
(8, 'Bohemian Rhapsody', 354),
(9, 'No Woman, No Cry', 236),
(10, 'Space Oddity', 301);


CREATE TABLE Writes ([time] DATETIME) AS EDGE;

CREATE TABLE Friends AS EDGE;

CREATE TABLE Listens AS EDGE;

	INSERT INTO Writes ($from_id, $to_id, [time])
VALUES ((SELECT $node_id FROM Artists WHERE ID = 1),
 (SELECT $node_id FROM Songs WHERE ID = 6), '2021-09-10 09:45:00'),
 ((SELECT $node_id FROM Artists WHERE ID = 5),
 (SELECT $node_id FROM Songs WHERE ID = 1), '2021-09-05 09:45:00'),
 ((SELECT $node_id FROM Artists WHERE ID = 8),
 (SELECT $node_id FROM Songs WHERE ID = 7), '2021-09-10 09:45:00'),
 ((SELECT $node_id FROM Artists WHERE ID = 2),
 (SELECT $node_id FROM Songs WHERE ID = 2), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Artists WHERE ID = 3),
 (SELECT $node_id FROM Songs WHERE ID = 5), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Artists WHERE ID = 4),
 (SELECT $node_id FROM Songs WHERE ID = 3), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Artists WHERE ID = 6),
 (SELECT $node_id FROM Songs WHERE ID = 4), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Artists WHERE ID = 7),
 (SELECT $node_id FROM Songs WHERE ID = 2), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Artists WHERE ID = 1),
 (SELECT $node_id FROM Songs WHERE ID = 9), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Artists WHERE ID = 9),
 (SELECT $node_id FROM Songs WHERE ID = 8), '2021-11-05 09:45:00'),
 ((SELECT $node_id FROM Artists WHERE ID = 10),
 (SELECT $node_id FROM Songs WHERE ID = 10), '2021-11-10 09:45:00');

 INSERT INTO Listens ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Users WHERE ID = 1),
 (SELECT $node_id FROM Songs WHERE ID = 6)),
 ((SELECT $node_id FROM Users WHERE ID = 5),
 (SELECT $node_id FROM Songs WHERE ID = 1)),
 ((SELECT $node_id FROM Users WHERE ID = 8),
 (SELECT $node_id FROM Songs WHERE ID = 7)),
 ((SELECT $node_id FROM Users WHERE ID = 2),
 (SELECT $node_id FROM Songs WHERE ID = 2)),
 ((SELECT $node_id FROM Users WHERE ID = 3),
 (SELECT $node_id FROM Songs WHERE ID = 5)),
 ((SELECT $node_id FROM Users WHERE ID = 4),
 (SELECT $node_id FROM Songs WHERE ID = 3)),
 ((SELECT $node_id FROM Users WHERE ID = 6),
 (SELECT $node_id FROM Songs WHERE ID = 4)),
 ((SELECT $node_id FROM Users WHERE ID = 7),
 (SELECT $node_id FROM Songs WHERE ID = 2)),
 ((SELECT $node_id FROM Users WHERE ID = 1),
 (SELECT $node_id FROM Songs WHERE ID = 9)),
 ((SELECT $node_id FROM Users WHERE ID = 9),
 (SELECT $node_id FROM Songs WHERE ID = 8)),
 ((SELECT $node_id FROM Users WHERE ID = 10),
 (SELECT $node_id FROM Songs WHERE ID = 10));

 INSERT INTO Friends ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Users WHERE ID = 1),
 (SELECT $node_id FROM Users WHERE ID = 6)),
 ((SELECT $node_id FROM Users WHERE ID = 5),
 (SELECT $node_id FROM Users WHERE ID = 1)),
 ((SELECT $node_id FROM Users WHERE ID = 8),
 (SELECT $node_id FROM Users WHERE ID = 7)),
 ((SELECT $node_id FROM Users WHERE ID = 2),
 (SELECT $node_id FROM Users WHERE ID = 4)),
 ((SELECT $node_id FROM Users WHERE ID = 3),
 (SELECT $node_id FROM Users WHERE ID = 5)),
 ((SELECT $node_id FROM Users WHERE ID = 4),
 (SELECT $node_id FROM Users WHERE ID = 3)),
 ((SELECT $node_id FROM Users WHERE ID = 6),
 (SELECT $node_id FROM Users WHERE ID = 4)),
 ((SELECT $node_id FROM Users WHERE ID = 7),
 (SELECT $node_id FROM Users WHERE ID = 2)),
 ((SELECT $node_id FROM Users WHERE ID = 1),
 (SELECT $node_id FROM Users WHERE ID = 9)),
 ((SELECT $node_id FROM Users WHERE ID = 9),
 (SELECT $node_id FROM Users WHERE ID = 8)),
 ((SELECT $node_id FROM Users WHERE ID = 10),
 (SELECT $node_id FROM Users WHERE ID = 9));

SELECT U1.name, U2.name
FROM Users AS U1
	, Friends AS F
	, Users AS U2
WHERE MATCH(U1-(F)->U2)
	AND U1.name = 'Alice';

SELECT U.name, S.name
FROM Users AS U
	, Listens AS L
	, Songs AS S
WHERE MATCH(U-(L)->S)
	AND U.name = 'Alice';

SELECT U.name, S.name
FROM Users AS U
	, Listens AS L
	, Songs AS S
WHERE MATCH(U-(L)->S)
	AND S.name = 'Billie Jean';

SELECT A.name, S.name
FROM Artists AS A
	, Writes AS W
	, Songs AS S
WHERE MATCH(A-(W)->S)
	AND A.name = 'The Beatles';

	SELECT A.name, S.name
FROM Artists AS A
	, Writes AS W
	, Songs AS S
WHERE MATCH(A-(W)->S)
	AND S.name = 'Billie Jean';

	SELECT U1.name
 , STRING_AGG(U2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Friends
FROM Users AS U1
 , Friends FOR PATH AS f
 , Users FOR PATH AS U2
WHERE MATCH(SHORTEST_PATH(U1(-(f)->U2)+))
 AND U1.name = 'Alice';

	SELECT U1.name
 , STRING_AGG(U2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Friends
FROM Users AS U1
 , Friends FOR PATH AS f
 , Users FOR PATH AS U2
WHERE MATCH(SHORTEST_PATH(U1(-(f)->U2){1,3}))
 AND U1.name = 'Alice';

  SELECT U1.id AS IdFirst
	, U1.name AS First
	, CONCAT(N'user (', U1.id, ')') AS [First image name]
	, U2.id AS IdSecond
	, U2.name AS Second
	, CONCAT(N'user (', U2.id, ')') AS [Second image name]
FROM Users AS U1
	, Friends AS F
	, Users AS U2
WHERE MATCH(U1-(F)->U2)

  SELECT U.id AS IdFirst
	, U.name AS First
	, CONCAT(N'user (', U.id, ')') AS [First image name]
	, S.id AS IdSecond
	, S.name AS Second
	, CONCAT(N'song (', S.id, ')') AS [Second image name]
FROM Users AS U
	, Listens AS L
	, Songs AS S
WHERE MATCH(U-(L)->S)

  SELECT A.id AS IdFirst
	, A.name AS First
	, CONCAT(N'artist (', A.id, ')') AS [First image name]
	, S.id AS IdSecond
	, S.name AS Second
	, CONCAT(N'song (', S.id, ')') AS [Second image name]
FROM Artists AS A
	, Writes AS W
	, Songs AS S
WHERE MATCH(A-(W)->S)

select @@servername