
create extension  IF NOT EXIST POSTGIS;

--ctreating table
CREATE TABLE IF NOT EXISTS geometries ( name varchar, coordinates geometry);

--inserting coordinate values
INSERT INTO geometries values
('Home', 'POINT(-118.28729818895258 34.03256935911488)'),
('Leavy Library','POINT(-118.28285457545785 34.021883088619404)'),
('USC Viterbi', 'POINT(-118.28933150155044 34.02065104947765)'),
('Marshall', 'POINT(-118.28536961415018 34.018910818647406)'),
('Thornton School', 'POINT(-118.28540861599501 34.02330431633266)'),
('Trader Joes', 'POINT(-118.28465759754573 34.02625646445648)'),
('USC Annenberg', 'POINT(-118.28613287080884 34.022178287780285)'),
('Cinematic Arts', 'POINT(-118.286543949599 34.023596271855666)'),
('Wilson Library', 'POINT(-118.2859861068857 34.023754600475144)'),
('PED Building', 'POINT(-118.28630505952296 34.02135544445477)'),
('USC Hotel', 'POINT(-118.28135917551013 34.019435932253245)'),
('Cromwell', 'POINT(-118.28785545056616 34.0220348175169)'),
('USC Dornsife', 'POINT(-118.28553710250009 34.02117196033497)');

--5a) ConvexHull
SELECT ST_AsText(ST_ConvexHull(
    ST_Collect(geometries.coordinates))) FROM geometries;

--5b nearest neighbor
SELECT a1.name,a2.name, ST_Distance(a1.coordinates,a2.coordinates)
as Distance_From_Home
FROM geometries a1, geometries a2
WHERE a1.name = 'Home' and a2.name != 'Home'
ORDER BY ST_Distance(a1.coordinates,a2.coordinates) ASC
LIMIT 4;

--http://jsfiddle.net/shreenidhishegde/gp2s57tn/1/




