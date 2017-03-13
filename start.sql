CREATE TABLE test.user
(
    id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    age INT(11) NOT NULL,
    createdDate DATETIME,
    isAdmin BIT(1) NOT NULL,
    name VARCHAR(255)
);
INSERT INTO test.user (age, createdDate, isAdmin, name) VALUES (30, '2017-01-31 15:36:04', true, 'Admin');
INSERT INTO test.user (age, createdDate, isAdmin, name) VALUES (40, '2017-01-31 15:36:19', false, 'Zoidberg');
INSERT INTO test.user (age, createdDate, isAdmin, name) VALUES (27, '2017-01-31 15:36:25', false, 'Philip J. Fry');
INSERT INTO test.user (age, createdDate, isAdmin, name) VALUES (27, '2017-01-31 15:36:41', false, 'Leela Turanga');
INSERT INTO test.user (age, createdDate, isAdmin, name) VALUES (100, '2017-01-31 15:37:13', false, 'Bender');
INSERT INTO test.user (age, createdDate, isAdmin, name) VALUES (32, '2017-01-31 15:37:28', false, 'Hermes Conrad');
INSERT INTO test.user (age, createdDate, isAdmin, name) VALUES (160, '2017-01-31 15:39:12', false, 'Professor Farnsworth');
INSERT INTO test.user (age, createdDate, isAdmin, name) VALUES (25, '2017-01-31 15:40:14', false, 'Amy Wong');
INSERT INTO test.user (age, createdDate, isAdmin, name) VALUES (35, '2017-01-31 15:40:36', false, 'Zapp Brannigan');
