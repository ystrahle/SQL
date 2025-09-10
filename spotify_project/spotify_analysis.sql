-- =========================
-- Table Setup
-- =========================
CREATE TABLE IF NOT EXISTS Spotifydata (
  id               TEXT,
  artist_name      TEXT,
  track_name       TEXT,
  track_id         TEXT,
  popularity       INTEGER,
  danceability     REAL,
  energy           REAL,
  key              INTEGER,
  loudness         REAL,
  mode             INTEGER,
  speechiness      REAL,
  acousticness     REAL,
  instrumentalness REAL,
  liveness         REAL,
  valence          REAL,
  tempo            REAL,
  duration_ms      INTEGER,
  time_signature   INTEGER
);

-- =========================
-- Q1: Performance Review (Avg Popularity)
-- =========================
SELECT
  artist_name,
  AVG(popularity) AS avg_popularity,
  COUNT(*)        AS track_count
FROM Spotifydata
WHERE artist_name IS NOT NULL
  AND popularity  IS NOT NULL
GROUP BY artist_name
HAVING COUNT(*) >= 2
ORDER BY avg_popularity DESC, track_count DESC;

-- =========================
-- Q2: Workload Distribution
-- =========================
SELECT
  artist_name,
  COUNT(*) AS track_count
FROM Spotifydata
WHERE artist_name IS NOT NULL
GROUP BY artist_name
ORDER BY track_count DESC, artist_name;

-- =========================
-- Q3: Time on Task (Avg Duration)
-- =========================
SELECT
  artist_name,
  ROUND(AVG(duration_ms) / 60000.0, 2) AS avg_duration_min,
  COUNT(*)                              AS track_count
FROM Spotifydata
WHERE artist_name IS NOT NULL
  AND duration_ms IS NOT NULL
GROUP BY artist_name
ORDER BY avg_duration_min DESC;

-- =========================
-- Q4: Skill Profile (Energy / Danceability)
-- =========================
-- By energy
SELECT
  artist_name,
  AVG(energy)       AS avg_energy,
  AVG(danceability) AS avg_danceability,
  COUNT(*)          AS track_count
FROM Spotifydata
WHERE artist_name IS NOT NULL
  AND energy       IS NOT NULL
  AND danceability IS NOT NULL
GROUP BY artist_name
HAVING COUNT(*) >= 2
ORDER BY avg_energy DESC, track_count DESC, artist_name;

-- By danceability
SELECT
  artist_name,
  AVG(energy)       AS avg_energy,
  AVG(danceability) AS avg_danceability,
  COUNT(*)          AS track_count
FROM Spotifydata
WHERE artist_name IS NOT NULL
  AND energy       IS NOT NULL
  AND danceability IS NOT NULL
GROUP BY artist_name
HAVING COUNT(*) >= 2
ORDER BY avg_danceability DESC, track_count DESC, artist_name;

-- Optional composite score
SELECT
  artist_name,
  (AVG(energy) + AVG(danceability)) / 2.0 AS composite_score,
  COUNT(*)                                AS track_count
FROM Spotifydata
WHERE artist_name IS NOT NULL
GROUP BY artist_name
HAVING COUNT(*) >= 2
ORDER BY composite_score DESC;

-- =========================
-- Q5: Versatility Index (Tempo Range)
-- =========================
SELECT
  artist_name,
  MAX(tempo) - MIN(tempo) AS tempo_range,
  COUNT(*)                AS track_count
FROM Spotifydata
WHERE artist_name IS NOT NULL
  AND tempo       IS NOT NULL
GROUP BY artist_name
HAVING COUNT(*) >= 2
ORDER BY tempo_range DESC, track_count DESC, artist_name;

-- =========================
-- CTE Practice: Top Stars
-- =========================
WITH popularity_average_CTE AS (
  SELECT
    artist_name,
    AVG(popularity) AS average_popularity
  FROM Spotifydata
  WHERE artist_name IS NOT NULL
    AND popularity  IS NOT NULL
  GROUP BY artist_name
)
SELECT
  artist_name,
  average_popularity,
  'Top Star' AS tag
FROM popularity_average_CTE
WHERE average_popularity >= 90
ORDER BY average_popularity DESC, artist_name;
