-- as there were empty cells in the csv, the loading in process is slightly different:

-- Create temp and your actual table, make all columns data type TEXT (name them differently)
-- Load CSV into temp table
-- INSERT your temp table into actual table. Transfer your columns into desired data types and specify IFNULL then '' (insert whatever
-- you want into '')


SET datestyle = 'MDY'; -- csv has american dates

DROP TABLE IF EXISTS pres_polls;

CREATE TABLE pres_polls (
    poll_id INT,
    pollster_id SMALLINT,
    pollster VARCHAR,
    sponsor_ids VARCHAR,
    sponsors VARCHAR,
    display_name VARCHAR,
    pollster_rating_id SMALLINT,
    pollster_rating_name VARCHAR,
    numeric_grade NUMERIC,
    pollscore NUMERIC,
    methodology VARCHAR,
    transparency_score NUMERIC,
    state VARCHAR,
    start_date DATE,
    end_date DATE,
    sponsor_candidate_id SMALLINT,
    sponsor_candidate VARCHAR,
    sponsor_candidate_party VARCHAR,
    endorsed_candidate_id SMALLINT,
    endorsed_candidate_name VARCHAR,
    endorsed_candidate_party VARCHAR,
    question_id INT,
    sample_size INT,
    population VARCHAR,
    subpopulation VARCHAR,
    population_full VARCHAR,
    tracking BOOLEAN,
    created_at DATE,
    notes VARCHAR,
    url VARCHAR,
    source SMALLINT,
    internal VARCHAR,
    partisan VARCHAR,
    race_id SMALLINT,
    cycle INT,
    office_type VARCHAR,
    seat_number SMALLINT,
    seat_name VARCHAR,
    election_date DATE,
    stage VARCHAR,
    nationwide_batch BOOLEAN,
    ranked_choice_reallocated BOOLEAN,
    ranked_choice_round SMALLINT,
    party VARCHAR,
    answer VARCHAR,
    candidate_id SMALLINT,
    candidate_name VARCHAR,
    pct NUMERIC
);

DROP TABLE IF EXISTS pres_polls_staging;

CREATE TEMP TABLE pres_polls_staging (
    poll_id TEXT,
    pollster_id TEXT,
    pollster TEXT,
    sponsor_ids TEXT,
    sponsors TEXT,
    display_name TEXT,
    pollster_rating_id TEXT,
    pollster_rating_name TEXT,
    numeric_grade TEXT,
    pollscore TEXT,
    methodology TEXT,
    transparency_score TEXT,
    state TEXT,
    start_date TEXT,
    end_date TEXT,
    sponsor_candidate_id TEXT,
    sponsor_candidate TEXT,
    sponsor_candidate_party TEXT,
    endorsed_candidate_id TEXT,
    endorsed_candidate_name TEXT,
    endorsed_candidate_party TEXT,
    question_id TEXT,
    sample_size TEXT,
    population TEXT,
    subpopulation TEXT,
    population_full TEXT,
    tracking TEXT,
    created_at TEXT,
    notes TEXT,
    url TEXT,
    source TEXT,
    internal TEXT,
    partisan TEXT,
    race_id TEXT,
    cycle TEXT,
    office_type TEXT,
    seat_number TEXT,
    seat_name TEXT,
    election_date TEXT,
    stage TEXT,
    nationwide_batch TEXT,
    ranked_choice_reallocated TEXT,
    ranked_choice_round TEXT,
    party TEXT,
    answer TEXT,
    candidate_id TEXT,
    candidate_name TEXT,
    pct TEXT
);

-- Insert data into the staging table
COPY pres_polls_staging (poll_id, pollster_id, pollster, sponsor_ids, sponsors, display_name, pollster_rating_id, pollster_rating_name, numeric_grade, pollscore, methodology, transparency_score, state, start_date, end_date, sponsor_candidate_id, sponsor_candidate, sponsor_candidate_party, endorsed_candidate_id, endorsed_candidate_name, endorsed_candidate_party, question_id, sample_size, population, subpopulation, population_full, tracking, created_at, notes, url, source, internal, partisan, race_id, cycle, office_type, seat_number, seat_name, election_date, stage, nationwide_batch, ranked_choice_reallocated, ranked_choice_round, party, answer, candidate_id, candidate_name, pct)
FROM 'C:\president_polls_historical.csv'
DELIMITER ','
CSV HEADER;

-- Insert data from staging table to final table with proper casting
INSERT INTO pres_polls (
    poll_id,
    pollster_id,
    pollster,
    sponsor_ids,
    sponsors,
    display_name,
    pollster_rating_id,
    pollster_rating_name,
    numeric_grade,
    pollscore,
    methodology,
    transparency_score,
    state,
    start_date,
    end_date,
    sponsor_candidate_id,
    sponsor_candidate,
    sponsor_candidate_party,
    endorsed_candidate_id,
    endorsed_candidate_name,
    endorsed_candidate_party,
    question_id,
    sample_size,
    population,
    subpopulation,
    population_full,
    tracking,
    created_at,
    notes,
    url,
    source,
    internal,
    partisan,
    race_id,
    cycle,
    office_type,
    seat_number,
    seat_name,
    election_date,
    stage,
    nationwide_batch,
    ranked_choice_reallocated,
    ranked_choice_round,
    party,
    answer,
    candidate_id,
    candidate_name,
    pct
)
SELECT
    NULLIF(poll_id, '')::int,
    NULLIF(pollster_id, '')::smallint,
    NULLIF(pollster, '')::varchar,
    NULLIF(sponsor_ids, '')::varchar,
    NULLIF(sponsors, '')::varchar,
    NULLIF(display_name, '')::varchar,
    NULLIF(pollster_rating_id, '')::smallint,
    NULLIF(pollster_rating_name, '')::varchar,
    NULLIF(numeric_grade, '')::numeric,
    NULLIF(pollscore, '')::numeric,
    NULLIF(methodology, '')::varchar,
    NULLIF(transparency_score, '')::numeric,
    NULLIF(state, '')::varchar,
    TO_DATE(NULLIF(start_date, ''), 'MM/DD/YY'),
    TO_DATE(NULLIF(end_date, ''), 'MM/DD/YY'),
    NULLIF(sponsor_candidate_id, '')::smallint,
    NULLIF(sponsor_candidate, '')::varchar,
    NULLIF(sponsor_candidate_party, '')::varchar,
    NULLIF(endorsed_candidate_id, '')::smallint,
    NULLIF(endorsed_candidate_name, '')::varchar,
    NULLIF(endorsed_candidate_party, '')::varchar,
    NULLIF(question_id, '')::int,
    NULLIF(sample_size, '')::int,
    NULLIF(population, '')::varchar,
    NULLIF(subpopulation, '')::varchar,
    NULLIF(population_full, '')::varchar,
    NULLIF(tracking, '')::boolean,
    TO_TIMESTAMP(NULLIF(created_at, ''), 'MM/DD/YY HH24:MI'),
    NULLIF(notes, '')::varchar,
    NULLIF(url, '')::varchar,
    NULLIF(source, '')::smallint,
    NULLIF(internal, '')::varchar,
    NULLIF(partisan, '')::varchar,
    NULLIF(race_id, '')::smallint,
    NULLIF(cycle, '')::int,
    NULLIF(office_type, '')::varchar,
    NULLIF(seat_number, '')::smallint,
    NULLIF(seat_name, '')::varchar,
    TO_DATE(NULLIF(election_date, ''), 'MM/DD/YY'),
    NULLIF(stage, '')::varchar,
    NULLIF(nationwide_batch, '')::boolean,
    NULLIF(ranked_choice_reallocated, '')::boolean,
    NULLIF(ranked_choice_round, '')::smallint,
    NULLIF(party, '')::varchar,
    NULLIF(answer, '')::varchar,
    NULLIF(candidate_id, '')::smallint,
    NULLIF(candidate_name, '')::varchar,
    NULLIF(pct, '')::numeric
FROM
    pres_polls_staging;
	
select * from pres_polls;


-- Create custom data -- 
	-- Details on trump and biden, but also former presidents -- 
DROP TABLE IF EXISTS candidate_details;
CREATE TABLE candidate_details (candidate_id int,
							name varchar (25),
							 party varchar (25),
							 campaign_funding_raised numeric,--https://www.opensecrets.org/2020-presidential-race
							 ideology varchar,
							 actual_pct_share numeric, --https://en.wikipedia.org/wiki/2020_United_States_presidential_election
							 election_year smallint,
							 electoral_vote smallint); 

-- original table

INSERT INTO candidate_details (candidate_id, name, party, campaign_funding_raised, ideology,actual_pct_share, election_year, electoral_vote)
VALUES ('13256', 'Joe Biden','Democratic', '1624301628', 'centre-left', '51.3', '2020', '306'),
('13254', 'Donald Trump','Republican','1087909269', 'right wing', '46.8', '2020', '232'),
('1', 'Hilary Clinton', 'Democratic', '769879088', 'centre-left', '48.2', '2016', '227'),
('13254', 'Donald Trump','Republican','433392727', 'right wing', '46.1', '2016', '304'),
('2', 'Barack Obama', 'Democratic', '722393592', 'centre-left', '51.1', '2012', '332'),
('3', 'Mitt Romney', 'Republican', '449886513', 'centre-right', '47.2', '2012', '206'),
('2', 'Barack Obama', 'Democratic', '744985624', 'centre-left', '52.9', '2008', '365'),
('4', 'John McCain', 'Republican', '368093764', 'centre-right', '45.7', '2008', '173'),
('5', 'George W. Bush', 'Republican', '367228819', 'right wing', '50.7', '2004', '286'),
('6', 'John Kerry', 'Democratic', '328479256', 'left wing', '48.3', '2004', '251');

select * from candidate_details;

-- Inserting new data into the table based on latest 2024 election

INSERT INTO candidate_details (candidate_id, name, party, campaign_funding_raised, ideology,actual_pct_share, election_year, electoral_vote)
VALUES ('7', 'Kamala Harris','Democratic', '1846212308', 'centre-left', '48.4', '2024', '226'),
('13254', 'Donald Trump','Republican','1357364737', 'right wing', '49.9', '2024', '312');

select * from candidate_details;


CREATE VIEW electoral_vote_view AS 
SELECT DISTINCT name, party, 
round(avg(electoral_vote) OVER(PARTITION BY name),1) AS average_electoral_vote_by_candidate,
sum(CASE WHEN electoral_vote < 270 THEN 0 ELSE 1 END) OVER(PARTITION BY name) AS elections_won_by_candidate,
sum(CASE WHEN electoral_vote < 270 THEN 0 ELSE 1 END) OVER(PARTITION BY party) AS elections_won_by_party,
round(avg(electoral_vote) OVER(PARTITION BY party),1) AS average_electoral_vote_by_party
FROM candidate_details cd
order by average_electoral_vote_by_candidate desc;

CREATE VIEW elec_vote_pop_vote_share AS
WITH cd2 AS (select name, round(avg(cd.electoral_vote)/538*100,2) AS avg_electoral_college_share, 
			sum(CASE WHEN cd.electoral_vote >= 270 THEN 1 ELSE 0 END) AS electoral_wins,
			round(avg(cd.actual_pct_share),2) AS avg_popular_vote_share,
			sum(cd.campaign_funding_raised) AS total_campaign_funding_raised
			from candidate_details cd
			group by name)
SELECT distinct(cd2.name), cd.party, cd2.avg_electoral_college_share,
cd2.avg_popular_vote_share, cd2.avg_electoral_college_share-cd2.avg_popular_vote_share AS difference
from candidate_details cd, cd2
where cd.name = cd2.name;


-- Modifying the us-polls database

UPDATE candidate_details SET party = 'Democratic' WHERE party = 'Democrat';
-- renaming 'democrat' to 'democratic' in candidate details table


select distinct pp.candidate_id, pp.candidate_name
from pres_polls pp
where pp.candidate_name LIKE '%Biden%' OR pp.candidate_name LIKE '%Trump%';
-- find Trump and Bidens candidate_id, so we know what candidate_id to filter out in our PowerBI load in command

-- The top 10 polling companies for amount of polls conducted
select pollster, count(distinct(poll_id)) "Polls conducted" -- distinct as each poll is entered at least twice (seperately recording Democrat and Republican scores)
from pres_polls
group by pollster
order by "Polls conducted" desc
limit (10);

-- Survey Monkey conducted the most surveys, so lets run some analysis on them


----------------- SUBQUERIES AND CTES




-- Poll rating comparison: latest Survey Monkey poll, with high transparency score

	-- (manually entering transparency score)
SELECT cd.name AS "Candidate name", cd.party, cd.campaign_funding_raised AS "Campaign money raised", 
pp.pollster, pp."Polling share (%)", pp.start_date AS "Date of poll"
FROM candidate_details cd, (SELECT pollster, candidate_id, start_date, pct AS "Polling share (%)"
	from pres_polls
	where transparency_score > 8.5 and pollster = 'SurveyMonkey'-- 8.5 score is over the average transparency score
	order by start_date desc
	limit(2)) pp
where cd.candidate_id = pp.candidate_id and cd.election_year='2020'
order by pp."Polling share (%)" desc;


	-- (CTE to store average transparency score for the query) - good for storing values and referencing them
WITH avg_transparency AS (
    SELECT AVG(transparency_score) AS avg_score
    FROM pres_polls
)
SELECT cd.name AS "Candidate name", cd.party, cd.campaign_funding_raised AS "Campaign money raised", pp.pollster, 
pp."Polling share (%)", pp.start_date AS "Date of poll"
FROM candidate_details cd, 
    (SELECT pollster, candidate_id, start_date, pct AS "Polling share (%)"
     FROM pres_polls, avg_transparency
     WHERE transparency_score > avg_transparency.avg_score AND pollster = 'SurveyMonkey'
     ORDER BY start_date DESC
     LIMIT 2) pp
WHERE cd.candidate_id = pp.candidate_id AND cd.election_year = '2020'
ORDER BY 
    pp."Polling share (%)" DESC;

-- Poll rating comparison: earliest Survey Monkey poll, with high transparency score

WITH avg_transparency AS (
    SELECT AVG(transparency_score) AS avg_score
    FROM pres_polls
)
SELECT cd.name AS "Candidate name", cd.party, cd.campaign_funding_raised AS "Campaign money raised", pp.pollster, 
pp."Polling share (%)", pp.start_date AS "Date of poll"
FROM candidate_details cd, 
    (SELECT pollster, candidate_id, start_date, pct AS "Polling share (%)"
     FROM pres_polls, avg_transparency
     WHERE transparency_score > avg_transparency.avg_score AND pollster = 'SurveyMonkey'
     ORDER BY start_date asc
     LIMIT 2) pp
WHERE cd.candidate_id = pp.candidate_id AND cd.election_year = '2020'
ORDER BY 
    pp."Polling share (%)" DESC;

	-- we can see from both subqueries that over time Trumps lead was lost. But, for both candidates, their polling score went up, suggesting
	-- Americans were favouring alternative candidates at the start of the year (January 2020) compared to the very latest poll (end of October, Election in November)

-- (2018-2020) Average polling for Biden/Trump for all polls with transparency score over 8.5 (above the average transparency score)

	-- polling (amongst highly transparent polls) up until Election day, was very accurate, being 1.25 percentage points out
	-- on Trumps actual vote share, and essentially exactly in line with Bidens actual vote share

WITH avg_transparency AS (
    SELECT AVG(transparency_score) AS avg_score
    FROM pres_polls) -- add fundraising cte, to produce more or less column for each candidate by year
SELECT cd.name AS "Candidate name", cd.party "Party", cd.campaign_funding_raised AS "Campaign money raised", 
pp."Average polling share (%)", cd.actual_pct_share AS "Actual percentage share of the vote - 2020 election", 
cd.electoral_vote AS "Actual Electoral vote", CASE WHEN electoral_vote < 270 THEN 'Lost' ELSE 'Won' END AS "Election result"
FROM candidate_details cd, 
	(SELECT candidate_name, round(avg(pct),1) AS "Average polling share (%)"
	from pres_polls, avg_transparency
	where transparency_score > avg_transparency.avg_score
	group by candidate_name) pp
where cd.name= pp.candidate_name AND cd.election_year='2020'
order by pp."Average polling share (%)" desc;


------------- AGGREGATIONS AND OTHER FUNCTIONS


-- As shown, Biden raised more money than Trump for his campaign, and won. Historically, does the candidate with more money always win?:

CREATE VIEW candidate_funding_analysis_pct AS
WITH  funding_raised_candidate AS  --(this query includes multiple CTEs that refer to one another)
	  (select name,sum(campaign_funding_raised) AS funding_raised,
	   CASE WHEN electoral_vote < 270 THEN 'Lost' ELSE 'Won' END AS election_result,
	   election_year
	  FROM candidate_details
	  group by name, electoral_vote, election_year
	  ),
	  funding_raised_year AS
	  (select election_year, sum(campaign_funding_raised) AS funding_raised
	   from candidate_details
	   group by election_year),
	  calculation_table AS 
	  (SELECT funding_raised_candidate.name,  funding_raised_candidate.election_year,
	   round(funding_raised_candidate.funding_raised/funding_raised_year.funding_raised,2) AS pct_of_total_funding_raised_by_candidate_in_elec_year,
	   funding_raised_candidate.election_result
		FROM funding_raised_candidate, funding_raised_year
		WHERE funding_raised_candidate.election_year=funding_raised_year.election_year)
SELECT calculation_table.election_year, calculation_table.name,
CASE WHEN calculation_table.pct_of_total_funding_raised_by_candidate_in_elec_year < 0.50 THEN 'Raised less' ELSE 'Raised more' END AS funding_raised_compared_to_other_candidate,
calculation_table.election_result
FROM calculation_table
WHERE calculation_table.election_result = 'Won'
ORDER BY calculation_table.election_year asc;

-- including winners and losers
drop view candidate_funding_analysis_pct;

CREATE VIEW candidate_funding_analysis_pct AS
WITH  funding_raised_candidate AS  --(this query includes multiple CTEs that refer to one another)
	  (select name,sum(campaign_funding_raised) AS funding_raised,
	   CASE WHEN electoral_vote < 270 THEN 'Lost' ELSE 'Won' END AS election_result,
	   election_year, party, electoral_vote
	  FROM candidate_details
	  group by name, electoral_vote, election_year, party
	  ),
	  funding_raised_year AS
	  (select election_year, sum(campaign_funding_raised) AS funding_raised
	   from candidate_details
	   group by election_year),
	  calculation_table AS 
	  (SELECT funding_raised_candidate.name,  funding_raised_candidate.election_year, funding_raised_candidate.party,
	   round(funding_raised_candidate.funding_raised/funding_raised_year.funding_raised,2) AS pct_of_total_funding_raised_by_candidate_in_elec_year,
	   funding_raised_candidate.election_result, funding_raised_candidate.electoral_vote
		FROM funding_raised_candidate, funding_raised_year
		WHERE funding_raised_candidate.election_year=funding_raised_year.election_year)
SELECT calculation_table.election_year, calculation_table.name, pct_of_total_funding_raised_by_candidate_in_elec_year,
calculation_table.election_result, calculation_table.party, calculation_table.electoral_vote
FROM calculation_table;

select * from candidate_funding_analysis_pct;

	-- table including losers, and actual money breakdowns
SELECT name, party, campaign_funding_raised,election_year, electoral_vote,
CASE WHEN electoral_vote < 270 THEN 'Lost' ELSE 'Won' END AS "Election result"
FROM candidate_details cd
WHERE cd.election_year != '2020'
order by election_year, electoral_vote desc;


-- from the last five elections (exlcuding 2020), all winners bar Trump in 2016 and 2024 recieved more campaign funding




-- Amount of elections won for each candidate

SELECT name, party, sum(CASE WHEN electoral_vote < 270 THEN 0 ELSE 1 END) AS elections_won,
round(1.0*sum(CASE WHEN electoral_vote < 270 THEN 0 ELSE 1 END) / count(1)*100,1) AS elections_won_pct
FROM candidate_details cd
group by name, party
order by elections_won desc;

-- Amount of elections won for each party across last six elections

SELECT party, sum(CASE WHEN electoral_vote < 270 THEN 0 ELSE 1 END) AS elections_won,
round(1.0*sum(CASE WHEN electoral_vote < 270 THEN 0 ELSE 1 END) / count(1)*100,1) AS elections_won_pct,
round(avg(electoral_vote),1) AS average_electoral_vote,
max(electoral_vote) AS "Most seats won at an election"
FROM candidate_details cd
group by party
order by average_electoral_vote desc;



------ WINDOW FUNCTIONS (produce results for each row in your data, moving beyond group bys)

	-- a deep dive of electoral votes won by party, and by candidate, ordered by average electoral vote achieved by candidate


SELECT DISTINCT name, party, 
round(avg(electoral_vote) OVER(PARTITION BY name),1) AS average_electoral_vote_by_candidate,
sum(CASE WHEN electoral_vote < 270 THEN 0 ELSE 1 END) OVER(PARTITION BY name) AS elections_won_by_candidate,
sum(CASE WHEN electoral_vote < 270 THEN 0 ELSE 1 END) OVER(PARTITION BY party) AS elections_won_by_party,
round(avg(electoral_vote) OVER(PARTITION BY party),1) AS average_electoral_vote_by_party
FROM candidate_details cd
order by average_electoral_vote_by_candidate desc;

	-- ranking candidates based on 

	-- (Combining CTE with Windows Function - ranking the candidates based on average electoral votes achieved)
WITH candidate_party_aggregates AS 
(SELECT distinct name, party, 
 SUM(CASE WHEN electoral_vote >= 270 THEN 1 ELSE 0 END) OVER(PARTITION BY name) AS elections_won_by_candidate,
 SUM(CASE WHEN electoral_vote >= 270 THEN 1 ELSE 0 END) OVER(PARTITION BY party) AS elections_won_by_party,
 ROUND(AVG(electoral_vote) OVER(PARTITION BY party), 1) AS average_electoral_vote_by_party,
 ROUND(AVG(electoral_vote) OVER(PARTITION BY name), 1) AS average_electoral_vote_by_candidate
 FROM candidate_details
)
SELECT *,
RANK() OVER(ORDER BY average_electoral_vote_by_candidate DESC) AS overall_rank
FROM candidate_party_aggregates;

	-- Obama comes out as a high performer, winning two elections, and winning on average 42.5 electoral votes more than the second best (Joe Biden)


-- winning candidates that got over the average number of electoral votes amongst winners
WITH win AS (SELECT *, CASE WHEN electoral_vote >= 270 THEN 1 ELSE 0 END AS vote_threshold 
			 FROM candidate_details),
	 average_vote AS (SELECT avg(electoral_vote) AS avg_electoral_vote
					 FROM win
					 WHERE win.vote_threshold = 1)
SELECT win.name, win.election_year, win.party, win.electoral_vote, round(av.avg_electoral_vote,2) AS avg_votes_among_winners
FROM win, average_vote av
WHERE win.vote_threshold =1 AND win.electoral_vote > av.avg_electoral_vote;
	-- count version below
WITH win AS (SELECT *, CASE WHEN electoral_vote >= 270 THEN 1 ELSE 0 END AS vote_threshold 
			 FROM candidate_details),
	 average_vote AS (SELECT avg(electoral_vote) AS avg_electoral_vote
					 FROM win
					 WHERE win.vote_threshold = 1)
SELECT win.name,COUNT(*)
FROM win, average_vote av
WHERE win.vote_threshold =1 AND win.electoral_vote > av.avg_electoral_vote
GROUP BY win.name;

-- Difference between electoral vote share and popular vote share
WITH cd2 AS (select name, round(avg(cd.electoral_vote)/538*100,2) AS avg_electoral_college_share, 
			sum(CASE WHEN cd.electoral_vote >= 270 THEN 1 ELSE 0 END) AS electoral_wins,
			round(avg(cd.actual_pct_share),2) AS avg_popular_vote_share,
			sum(cd.campaign_funding_raised) AS total_campaign_funding_raised
			from candidate_details cd
			group by name)
SELECT distinct(cd2.name), cd.party, cd2.avg_electoral_college_share,
cd2.avg_popular_vote_share, cd2.avg_electoral_college_share-cd2.avg_popular_vote_share AS difference
from candidate_details cd, cd2
where cd.name = cd2.name;

-- ROLLING SUM OF FUNDRAISING MONEY BY ELECTION YEAR

SELECT distinct(election_year), sum(campaign_funding_raised) OVER (ORDER BY election_year) AS rolling_campaign_funding_raised 
FROM candidate_details
order by election_year asc;

-- 10bn raised across the 6 elections in the last 20 years

SELECT election_year, sum(campaign_funding_raised) AS funding_raised
FROM candidate_details
group by election_year
order by funding_raised asc;

-- funding raised has increased election on election

----------- JOINS

select end_date from pres_polls
limit(2) -- to see how date is formatted

-- Average 2020 poll popular vote score (only polls over the average transparency score and in 2020) 
-- and actual pop vote in the 2020 election
SELECT cd.name,cd.party,cd.actual_pct_share AS "Popular vote in 2020 election", 
round(avg(pp.pct),1) AS "Average popular vote in 2020 polls"
FROM candidate_details cd
INNER JOIN pres_polls pp ON cd.candidate_id = pp.candidate_id
WHERE pp.end_date > '2019-12-31' AND cd.election_year='2020' 
AND pp.transparency_score > (SELECT AVG(pp.transparency_score)FROM pres_polls pp)
GROUP BY cd.name,cd.party,cd.actual_pct_share;



