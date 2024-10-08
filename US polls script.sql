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
							 campaign_funding_raised_2020 varchar,-- https://www.opensecrets.org/2020-presidential-race
							 ideology varchar,
							 actual_pct_share_2020 numeric, --https://en.wikipedia.org/wiki/2020_United_States_presidential_election
							 election_year smallint,
							 electoral_vote smallint); 

INSERT INTO candidate_details (candidate_id, name, party, campaign_funding_raised_2020, ideology,actual_pct_share_2020, election_year, electoral_vote)
VALUES ('13256', 'Joe Biden','Democrat', '$1,624,301,628', 'centre-left', '51.3', '2020', '306'),
('13254', 'Donald Trump','Republican','$1,087,909,269', 'right wing', '46.8', '2020', '232'),
('1', 'Hilary Clinton', 'Democrat', '$769,879,088', 'centre-left', '48.2', '2016', '227'),
('13254', 'Donald Trump','Republican','$433,392,727', 'right wing', '46.1', '2016', '304'),
('2', 'Barack Obama', 'Democrat', '$722,393,592', 'centre-left', '51.1', '2012', '332'),
('3', 'Mitt Romney', 'Republican', '$449,886,513', 'centre-right', '47.2', '2012', '206'),
('2', 'Barack Obama', 'Democrat', '$744,985,624', 'centre-left', '52.9', '2008', '365'),
('4', 'John McCain', 'Republican', '$368,093,764', 'centre-right', '45.7', '2008', '173'),
('5', 'George W. Bush', 'Republican', '$367,228,819', 'right wing', '50.7', '2004', '286'),
('6', 'John Kerry', 'Democrat', '$328,479,256', 'left wing', '48.3', '2004', '251');

select * from candidate_details;

-- The top 10 polling companies for amount of polls conducted
select pollster, count(distinct(poll_id)) "Polls conducted" -- distinct as each poll is entered at least twice (seperately recording Democrat and Republican scores)
from pres_polls
group by pollster
order by "Polls conducted" desc
limit (10);

-- subqueries

-- Poll rating comparison: latest Survey Monkey poll, with high transparency score

select avg(transparency_score), max(transparency_score)
from pres_polls;

SELECT cd.name AS "Candidate name", cd.party, cd.campaign_funding_raised_2020 AS "Campaign money raised", 
pp.pollster, pp."Polling share (%)", pp.start_date AS "Date of poll"
FROM candidate_details cd, (SELECT pollster, candidate_id, start_date, pct AS "Polling share (%)"
	from pres_polls
	where transparency_score > 8.5 and pollster = 'SurveyMonkey'-- 8.5 score is over the average transparency score
	order by start_date desc
	limit(2)) pp
where cd.candidate_id = pp.candidate_id and cd.election_year='2020'
order by pp."Polling share (%)" desc;


-- Poll rating comparison: earliest Survey Monkey poll, with high transparency score

select avg(transparency_score), max(transparency_score)
from pres_polls;

SELECT cd.name AS "Candidate name", cd.party, cd.campaign_funding_raised_2020 AS "Campaign money raised", 
pp.pollster, pp."Polling share (%)", pp.start_date AS "Date of poll"
FROM candidate_details cd, (SELECT pollster, candidate_id, start_date, pct AS "Polling share (%)"
	from pres_polls
	where transparency_score > 8.5 and pollster = 'SurveyMonkey'-- 8.5 score is over the average transparency score
	order by start_date asc
	limit(2)) pp
where cd.candidate_id = pp.candidate_id and cd.election_year = '2020'
order by pp."Polling share (%)" desc;

	-- we can see from both subqueries that over time Trumps lead was lost. But, for both candidates, their polling score went up, suggesting
	-- Americans were favouring alternative candidates at the start of the year (January 2020) compared to the very latest poll (end of October, Election in November)

-- Average polling Biden/Trump for all polls (2018-2020) with transparency score over 8.5

	-- polling (amongst highly transparent polls) up until Election day, was very accurate, being 1.25 percentage points out
	-- on Trumps actual vote share, and essentially exactly in line with Bidens actual vote share

SELECT cd.name AS "Candidate name", cd.party "Party", cd.campaign_funding_raised_2020 AS "Campaign money raised", 
pp."Average polling share (%)", cd.actual_pct_share_2020 AS "Actual percentage share of the vote - 2020 election", 
cd.electoral_vote AS "Actual Electoral vote"
FROM candidate_details cd, (SELECT candidate_name, round(avg(pct),2) AS "Average polling share (%)"
	from pres_polls
	where transparency_score > 8.5 -- 8.5 score is over the average transparency score
	group by candidate_name) pp
where cd.name= pp.candidate_name AND cd.election_year='2020'
order by pp."Average polling share (%)" desc;


-- As shown, Biden raised more money than Trump for his campaign, and won. Historically, does the candidate with more money win?:

SELECT name, party, campaign_funding_raised_2020,election_year, electoral_vote
FROM candidate_details cd
WHERE cd.election_year != '2020'
order by election_year, electoral_vote desc

-- in the last four elections, all winners bar Trump in 2016 recieved more campaign funding