CREATE DATABASE mydatabase;
USE mydatabase;


CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50)
);


INSERT INTO users (id, name, email) VALUES (1, 'karan', 'karan@gmail.com');


SELECT * FROM users;
UPDATE users 
SET email = 'karan@gmail.com'
WHERE id = 1;


DELETE FROM users
WHERE id = 1;