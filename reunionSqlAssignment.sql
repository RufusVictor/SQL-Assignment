-- Find students who share similar movie genres (e.g., Action or Romance lovers)
SELECT 
    g.genre_name,
    GROUP_CONCAT(s.name ORDER BY s.name SEPARATOR ', ') AS students_with_common_interest
FROM 
    student_movie_interests smi
JOIN 
    students s ON smi.student_id = s.student_id
JOIN 
    movie_genres g ON smi.genre_id = g.genre_id
GROUP BY 
    g.genre_name;
    
-- Group students by favorite actors
SELECT 
    sf.favorite_actor,
    GROUP_CONCAT(s.name ORDER BY s.name SEPARATOR ', ') AS fan_club_members
FROM 
    student_favorites sf
JOIN 
    students s ON sf.student_id = s.student_id
GROUP BY 
    sf.favorite_actor;

-- Group students by favorite actresses
SELECT 
    sf.favorite_actress,
    GROUP_CONCAT(s.name ORDER BY s.name SEPARATOR ', ') AS fan_club_members
FROM 
    student_favorites sf
JOIN 
    students s ON sf.student_id = s.student_id
GROUP BY 
    sf.favorite_actress;

-- Suggest ideal friend groups who share similar tastes in entertainment and hangout spots
SELECT 
    g.genre_name AS movie_genre,
    mall.mall_name AS favorite_mall,
    b.beach_name AS favorite_beach,
    GROUP_CONCAT(s.name ORDER BY s.name SEPARATOR ', ') AS friend_group
FROM 
    student_movie_interests smi
JOIN 
    student_fav_malls mf ON smi.student_id = mf.student_id
JOIN 
    student_fav_beaches sb ON smi.student_id = sb.student_id
JOIN 
    students s ON smi.student_id = s.student_id
JOIN 
    movie_genres g ON smi.genre_id = g.genre_id
JOIN 
    shopping_malls mall ON mf.mall_id = mall.mall_id
JOIN 
    beaches b ON sb.beach_id = b.beach_id
GROUP BY 
    g.genre_name, mall.mall_name, b.beach_name;

-- common favorite beaches
SELECT 
    b.beach_name,
    COUNT(sb.student_id) AS student_count,
    GROUP_CONCAT(s.name ORDER BY s.name SEPARATOR ', ') AS students_interested
FROM 
    student_fav_beaches sb
JOIN 
    students s ON sb.student_id = s.student_id
JOIN 
    beaches b ON sb.beach_id = b.beach_id
GROUP BY 
    b.beach_name
HAVING 
    COUNT(sb.student_id) >= 2;

-- common shopping malls
SELECT 
    m.mall_name,
    COUNT(sfm.student_id) AS student_count,
    GROUP_CONCAT(s.name ORDER BY s.name SEPARATOR ', ') AS students_interested
FROM 
    student_fav_malls sfm
JOIN 
    students s ON sfm.student_id = s.student_id
JOIN 
    shopping_malls m ON sfm.mall_id = m.mall_id
GROUP BY 
    m.mall_name
HAVING 
    COUNT(sfm.student_id) >= 2;

-- common favorite movies
SELECT 
    mv.movie_name,
    COUNT(sfm.student_id) AS student_count,
    GROUP_CONCAT(s.name ORDER BY s.name SEPARATOR ', ') AS students_interested
FROM 
    student_fav_movies sfm
JOIN 
    students s ON sfm.student_id = s.student_id
JOIN 
    movies mv ON sfm.movie_id = mv.movie_id
GROUP BY 
    mv.movie_name
HAVING 
    COUNT(sfm.student_id) >= 2;

-- Most liked actor
SELECT 
    favorite_actor,
    COUNT(*) AS like_count
FROM 
    student_favorites
GROUP BY 
    favorite_actor
ORDER BY 
    like_count DESC
LIMIT 1;

-- Most liked actress
SELECT 
    favorite_actress,
    COUNT(*) AS like_count
FROM 
    student_favorites
GROUP BY 
    favorite_actress
ORDER BY 
    like_count DESC
LIMIT 1;

-- Most popular movie genre 
SELECT 
    g.genre_name,
    COUNT(smi.student_id) AS popularity_count
FROM 
    student_movie_interests smi
JOIN 
    movie_genres g ON smi.genre_id = g.genre_id
GROUP BY 
    g.genre_name
ORDER BY 
    popularity_count DESC
LIMIT 1;

-- Top 5 favorite movies currently
SELECT 
    mv.movie_name,
    COUNT(sfm.student_id) AS popularity_count
FROM 
    student_fav_movies sfm
JOIN 
    movies mv ON sfm.movie_id = mv.movie_id
GROUP BY 
    mv.movie_name
ORDER BY 
    popularity_count DESC
LIMIT 5;

-- Who loves romantic movies?
SELECT 
    group_concat(s.name) AS Romantic_Movie_Enthusiasts
FROM 
    student_movie_interests smi
JOIN 
    students s ON smi.student_id = s.student_id
JOIN 
    movie_genres g ON smi.genre_id = g.genre_id
WHERE 
    g.genre_name = 'Romance';

-- Which beach is the most popular?
SELECT 
    b.beach_name,
    COUNT(sb.student_id) AS popularity_count
FROM 
    student_fav_beaches sb
JOIN 
    beaches b ON sb.beach_id = b.beach_id
GROUP BY 
    b.beach_name
ORDER BY 
    popularity_count DESC
LIMIT 1;

-- What are the top favorite actors?
SELECT 
    favorite_actor,
    COUNT(*) AS like_count
FROM 
    student_favorites
GROUP BY 
    favorite_actor
ORDER BY 
    like_count DESC
LIMIT 5;

-- Which movie can most people agree on watching together?
SELECT 
    mv.movie_name,
    COUNT(sfm.student_id) AS agreement_count
FROM 
    student_fav_movies sfm
JOIN 
    movies mv ON sfm.movie_id = mv.movie_id
GROUP BY 
    mv.movie_name
ORDER BY 
    agreement_count DESC
LIMIT 1;
