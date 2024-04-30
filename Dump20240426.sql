	insert into movie (Name, Description, YearOfedition, Rate, CoverImage, Genre)
	values ("Дюна: частина друга 
	","Молодий герцог Пол Атрід, що має дар ясновидіння, дивом переживає замах на свою сім'ю, після чого разом з матір'ю, леді Джессікою, ховається від переслідування серед безмежної пустелі. Двоє знаходять безпечний притулок у таборі фременів — волелюбного народу, який за багато століть пристосувався до життя у суворих умовах планети Арракіс.", 2024, 9.7, "8520.jpg", 4);

insert into director (fullname) values ("Some name");
select * from movie;

insert into MovieDirector(Movie_Id, Director_Id) values (1,1);

	UPDATE Movie
	SET CoverImage = 'cambg_5.jpg'
	WHERE movie.Id = 2;

ALTER TABLE Movie
ADD CoverImage VARCHAR(500);


use  MoviesGuide;

show tables;
select* from director;
insert into director (fullname) value ("
Ніколь Паоне");
select * from director;
insert into moviedirector (movie_Id, director_id) values(18,3);
delete from movie where id = 4;
SELECT Movie.*, Director.fullname
FROM Movie
LEFT JOIN MovieDirector ON Movie.Id = MovieDirector.Movie_Id
LEFT JOIN Director ON Director.Id = MovieDirector.Director_Id;

SELECT Movie.*, Director.fullname 
                           FROM Movie
                           LEFT JOIN MovieDirector ON Movie.Id = MovieDirector.Movie_Id 
                           LEFT JOIN Director ON Director.Id = MovieDirector.Director_Id
                           JOIN UserMovie ON Movie.Id = UserMovie.Movie_Id
                           WHERE UserMovie.User_Id = 1;
                           
insert into UserMovie (User_Id, Movie_Id) values (1,2);
SELECT Movie.*, Director.fullname 
               FROM Movie 
               LEFT JOIN MovieDirector ON Movie.Id = MovieDirector.Movie_Id 
               LEFT JOIN Director ON Director.Id = MovieDirector.Director_Id 
			WHERE Movie.genre = 3;
            
CREATE TABLE Movie (
    Id INT NOT NULL AUTO_INCREMENT,
    -- other columns for Movie table...
    PRIMARY KEY (Id)
);

update movie set name = "Дюна" where id =4;

CREATE TABLE Image (
    Id INT NOT NULL AUTO_INCREMENT,
    Path VARCHAR(50) NOT NULL,
    Movie_id INT,
    FOREIGN KEY (Movie_id) REFERENCES Movie(Id),
    PRIMARY KEY (Id)
);

insert into Image(path, movie_Id) values("d4.jpg",18);
select * from movie;


 SELECT * FROM Image;

show tables;

SELECT Movie.*, GROUP_CONCAT(DISTINCT Director.fullName) AS Directors
FROM Movie
LEFT JOIN MovieDirector ON Movie.Id = MovieDirector.Movie_Id
LEFT JOIN Director ON Director.Id = MovieDirector.Director_Id
INNER JOIN UserMovie ON Movie.Id = UserMovie.Movie_Id
WHERE UserMovie.User_Id = 1
GROUP BY Movie.Id;



select * from moviedirector;

delete from movie where movie.id = 16;