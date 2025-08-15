CREATE TABLE person (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(100),
    dob DATE,
    email VARCHAR(255)
);

-- new columns
ALTER TABLE films
ADD COLUMN director_id INT,
ADD COLUMN star_id INT,
ADD COLUMN writer_id INT;

-- unique directors
INSERT INTO person (name, country)
SELECT DISTINCT director, director_country
FROM films
WHERE director IS NOT NULL;

-- unique stars
INSERT INTO person (name, dob)
SELECT DISTINCT star, star_dob
FROM films
WHERE star IS NOT NULL
  AND star NOT IN (SELECT name FROM person);

-- unique writers
INSERT INTO person (name, email)
SELECT DISTINCT writer, writer_email
FROM films
WHERE writer IS NOT NULL
  AND writer NOT IN (SELECT name FROM person);

-- id
UPDATE films f
SET director_id = p.id
FROM person p
WHERE f.director = p.name;

UPDATE films f
SET star_id = p.id
FROM person p
WHERE f.star = p.name;

UPDATE films f
SET writer_id = p.id
FROM person p
WHERE f.writer = p.name;

-- Foreign keys
ALTER TABLE films
ADD CONSTRAINT fk_director FOREIGN KEY (director_id) REFERENCES person (id),
ADD CONSTRAINT fk_star FOREIGN KEY (star_id) REFERENCES person (id),
ADD CONSTRAINT fk_writer FOREIGN KEY (writer_id) REFERENCES person (id);

-- delete old columns
ALTER TABLE films
DROP COLUMN director,
DROP COLUMN director_country,
DROP COLUMN star,
DROP COLUMN star_dob,
DROP COLUMN writer,
DROP COLUMN writer_email;
