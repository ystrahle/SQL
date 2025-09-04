------------------------------------------------------------
-- Conference VIP Analysis | People Analytics with SQL
-- Database (db-fiddle): https://www.db-fiddle.com/f/pxMci1sLL945KHKYvpe9W6/1
-- Engine: (use the same engine as the fiddle)
-- Note: BIT fields -> 1 = Yes, 0 = No, NULL = Missing
-- This file includes six analysis queries only (schema lives in the db-fiddle).
------------------------------------------------------------

-- Conference Project
-- Database: https://www.db-fiddle.com/f/pxMci1sLL945KHKYvpe9W6/1
------------------------------------------------------------
-- QUERIES
------------------------------------------------------------

-- Q1. LEFT JOIN — List all VIPs and their reservations (include missing)
SELECT v.member_id, v.first_name, v.last_name,
       r.hotel, r.welcome_rsvp, r.dinner_rsvp
FROM vips v
LEFT JOIN reservations r
  ON v.member_id = r.member_id;

-- Q2. INNER JOIN — Speakers by event type & association
SELECT v.association,
       e.event_type,
       COUNT(DISTINCT v.member_id) AS speaker_count
FROM vips v
INNER JOIN events e
  ON v.event = e.event_id
GROUP BY v.association, e.event_type
ORDER BY speaker_count DESC;

-- Q3. Multiple JOINs — Hotel utilization (VIP count + RSVP yes)
SELECT h.hotel_name,
       COUNT(DISTINCT v.member_id) AS vip_count,
       SUM(CASE WHEN r.welcome_rsvp = 1 THEN 1 ELSE 0 END) AS welcome_yes,
       SUM(CASE WHEN r.dinner_rsvp  = 1 THEN 1 ELSE 0 END) AS dinner_yes
FROM vips v
LEFT JOIN reservations r
  ON v.member_id = r.member_id
JOIN hotels h
  ON r.hotel = h.hotel_id
GROUP BY h.hotel_name
ORDER BY vip_count DESC;

-- Q4. SELF JOIN — Reviewer → Speaker map (with event)
SELECT spk.first_name AS speaker_first,
       spk.last_name  AS speaker_last,
       rev.first_name AS reviewer_first,
       rev.last_name  AS reviewer_last,
       e.event_name,
       e.event_type
FROM vips AS spk
JOIN vips AS rev
  ON rev.provides_feedback_to = spk.member_id
JOIN events AS e
  ON spk.event = e.event_id;

-- Q5. Multiple JOINs + Aggregation — Reviewers per speaker
SELECT spk.member_id,
       spk.first_name,
       spk.last_name,
       e.event_name,
       e.event_type,
       COUNT(rev.member_id) AS reviewer_count
FROM vips spk
JOIN vips rev
  ON rev.provides_feedback_to = spk.member_id
JOIN events e
  ON spk.event = e.event_id
GROUP BY spk.member_id, spk.first_name, spk.last_name, e.event_name, e.event_type
ORDER BY reviewer_count DESC, spk.last_name, spk.first_name;

-- Q6. Subquery — Invalid reviewer assignments (NULL/self/orphan)
SELECT rev.member_id AS reviewer_id,
       rev.first_name AS reviewer_first,
       rev.last_name  AS reviewer_last,
       rev.provides_feedback_to AS supposed_speaker_id
FROM vips rev
WHERE rev.provides_feedback_to IS NULL
   OR rev.provides_feedback_to = rev.member_id
   OR rev.provides_feedback_to NOT IN (
        SELECT spk.member_id
        FROM vips spk
        WHERE spk.event IS NOT NULL
      )
ORDER BY reviewer_last, reviewer_first;
