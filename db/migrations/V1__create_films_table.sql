CREATE TABLE films (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    director VARCHAR(255),
    director_country VARCHAR(255),
    star VARCHAR(255),
    star_dob DATE,
    writer VARCHAR(255),
    writer_email VARCHAR(255),
    year INT,
    genre VARCHAR(100),
    score INT
);
