# Conference VIP Analysis | People Analytics with SQL

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Executive Summary
This project analyzes VIP logistics and reviewer assignments for a professional conference. Using SQL, I answered six real-world event management questions to ensure smooth operations and complete data quality. The queries demonstrate **LEFT JOIN, INNER JOIN, multiple JOINs, SELF JOIN, and a subquery** — key SQL skills every analyst uses in practice.

**Business impact:**
- Identified VIPs missing hotels or RSVPs → outreach list for HR ops  
- Summarized event type representation by association → balanced agenda planning  
- Analyzed hotel block utilization → capacity and catering alignment  
- Mapped reviewer ↔ speaker assignments → ensured coverage  
- Ran data quality checks → caught incomplete feedback assignments  

---

## Business Problem
Conference operations teams need accurate data to manage logistics and ensure every VIP is assigned correctly. Missing RSVPs, incomplete hotel reservations, or invalid reviewer links can lead to confusion, wasted costs, or negative attendee experience.  

---

## Methodology
- **Database:** 4 related tables (`vips`, `reservations`, `hotels`, `events`)  
- **SQL Techniques Used:**  
  - LEFT JOIN → include all VIPs, even if they missed RSVPs  
  - INNER JOIN → analyze speaker distribution across event types  
  - Multiple JOINs → combine `vips`, `reservations`, and `hotels` for utilization  
  - SELF JOIN → map reviewers to the speakers they provide feedback for  
  - Subquery → flag invalid or missing reviewer assignments  
- **Aggregations:** `COUNT`, `SUM(CASE...)`  
- **Data Type Handling:** BIT fields (`1=Yes`, `0=No`, `NULL=Missing`)  

---

## Key Findings
1. **Logistics gaps:** Several VIPs were missing hotel or RSVP info.  
2. **Event balance:** All associations were represented evenly, each with 1 speaker.  
3. **Hotel utilization:** Each hotel had clear counts of total guests, welcome RSVPs, and dinner RSVPs.  
4. **Reviewer coverage:** Every speaker had exactly 1 reviewer (by design of the dataset).  
5. **Invalid assignments:** Found reviewers with missing assignments (NULLs), no self-reviews or invalid IDs.  

---

## Skills Highlighted
- SQL: JOINs, SELF JOIN, subqueries, CASE, aggregates  
- People Analytics & HR Ops: RSVP pipeline QA, event staffing, data quality checks  
- Communication: Translating raw queries into business insights  

---

## Next Steps
 - Send reminder emails to VIPs who have not RSVP’d for the welcome party or dinner.
 - Follow up with hotel coordinators to resolve missing or duplicate reservations.
 - Reassign reviewers where feedback links are incomplete or invalid.
 - Adjust the conference schedule if certain associations or event types are underrepresented.
 - Prepare a summary report for the HR/Events team highlighting gaps and recommended fixes before the conference begins.  

---

## Files in this Folder
- `conference_analysis.sql` → All SQL queries with comments  
