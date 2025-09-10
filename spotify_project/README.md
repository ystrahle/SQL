# 🎧 Spotify Top 50 (2021) — HR-Framed Analytics

## 📌 Project Overview
This project analyzes the 2021 Spotify Top 50 dataset, treating **artists as employees** and **tracks as projects**.  
The goal was to practice SQL skills while framing insights in an **HR/business context**: measuring performance, workload, skills, and versatility.

[spotify_top50_2021.csv](./spotify_top50_2021.csv)

---

## ❓ Business Objectives
The project answers key business-style questions:

1. **Performance Review**  
   Which artists maintained the **highest average popularity** across multiple tracks?  
   → Helps identify “high performers” who consistently deliver impact.

2. **Workload Distribution**  
   Which artists contributed the **most tracks** in the Top 50?  
   → Provides insight into how output is distributed across employees.

3. **Time on Task**  
   What is the **average project (song) duration** per artist?  
   → Mirrors measuring average task length to understand efficiency.

4. **Skill Profile**  
   Who excels in **energy** and **danceability**?  
   → Equivalent to identifying specialized skill strengths within a team.

5. **Versatility Index**  
   Which artists show the **widest tempo variety** across songs?  
   → Highlights adaptability and flexibility in skill application.

6. **CTE Example — Top Stars**  
   Use a Common Table Expression (CTE) to tag artists with **average popularity ≥ 90** as “Top Stars.”  
   → Mirrors HR dashboards where top performers are highlighted for recognition.

---

## 🛠️ Tools & Techniques
- **SQL** (SQLite): aggregates, GROUP BY, HAVING vs WHERE, multi-key ORDER BY
- **CTEs**: temporary tables for readability and tagging
- **CSV import** into SQLite Studio

---

## 📊 Key Insights
- A handful of artists contribute disproportionately to the Top 50 (high workload concentration).  
- Several “consistent high performers” emerged with average popularity above 90.  
- Duration averages highlight stylistic tendencies: some artists lean toward shorter “efficient” outputs, others toward longer tracks.  
- Danceability and energy leaders reflect specialized strengths.  
- Tempo variety reveals adaptability — some artists stick to a formula, others experiment widely.  

---

## 🚀 Next Steps (Business Lens)
- **Recognition & Rewards:** Highlight “Top Stars” to drive retention of top performers.  
- **Workload Balancing:** Consider distribution of projects — avoid over-reliance on a few high-output employees.  
- **Skill Development:** Use insights on energy/danceability to design training pathways for balanced team skills.  
- **Encourage Versatility:** Recognize employees who adapt across multiple project types as potential leaders.

