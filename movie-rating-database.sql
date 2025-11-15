SET FOREIGN_KEY_CHECKS = 1;

-- MOVIE table
CREATE TABLE IF NOT EXISTS movie (
    movie_id   INT AUTO_INCREMENT PRIMARY KEY,
    title      VARCHAR(255) NOT NULL,
    year       INT,
    genre      VARCHAR(100)
);

-- USER table
CREATE TABLE IF NOT EXISTS `user` (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name    VARCHAR(255) NOT NULL,
    email   VARCHAR(255) UNIQUE
);

-- RATING table
CREATE TABLE IF NOT EXISTS rating (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id   INT NOT NULL,
    movie_id  INT NOT NULL,
    rating    INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review    TEXT,
    rated_on  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)  REFERENCES `user`(user_id)  ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE
);

-- Indexes
CREATE INDEX idx_movie_title  ON movie(title);
CREATE INDEX idx_user_email   ON `user`(email);
CREATE INDEX idx_rating_movie ON rating(movie_id);

-- View: average rating & vote count per movie
CREATE OR REPLACE VIEW movie_rating_summary AS
SELECT
    m.movie_id,
    m.title,
    m.year,
    m.genre,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    COUNT(r.rating)         AS votes
FROM movie m
LEFT JOIN rating r ON m.movie_id = r.movie_id
GROUP BY m.movie_id;

-- Movies
INSERT INTO movie (title, year, genre) VALUES ('The Shawshank Redemption', 1994, 'Drama');
INSERT INTO movie (title, year, genre) VALUES ('The Godfather', 1972, 'Crime');
INSERT INTO movie (title, year, genre) VALUES ('The Dark Knight', 2008, 'Action');
INSERT INTO movie (title, year, genre) VALUES ('Pulp Fiction', 1994, 'Crime');
INSERT INTO movie (title, year, genre) VALUES ('Forrest Gump', 1994, 'Drama');

-- Users
INSERT INTO `user` (name, email) VALUES ('Ashwin R', 'ashwin@example.com');
INSERT INTO `user` (name, email) VALUES ('Sneha Nair', 'sneha@example.com');
INSERT INTO `user` (name, email) VALUES ('Lena', 'lena@example.com');

-- Ratings
INSERT INTO rating (user_id, movie_id, rating, review) VALUES (1, 1, 5, 'Masterpiece');
INSERT INTO rating (user_id, movie_id, rating, review) VALUES (2, 1, 5, 'Amazing');
INSERT INTO rating (user_id, movie_id, rating, review) VALUES (3, 3, 4, 'Great action and story');
INSERT INTO rating (user_id, movie_id, rating, review) VALUES (1, 4, 4, 'Cult classic');

