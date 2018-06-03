// delete existing stuff
MATCH (n)
DETACH DELETE n;

// create ICD categories
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "file:///2018_icd_categories.csv" AS line WITH line
CREATE (c:ICD_Category {code: line.`Category Code`, title: line.`Category Title`});

// set up index/constraint
CREATE CONSTRAINT ON (category:ICD_Category) ASSERT category.code IS UNIQUE;

// create ICD Codes
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "file:///2018_icd_codes.csv" AS line WITH line
CREATE (c:ICD_Code {code: line.`Full Code`, categoryCode: line.`Category Code`, description: line.`Full Description`});

// set up index/constraint
CREATE CONSTRAINT ON (code:ICD_Code) ASSERT code.code IS UNIQUE;

// link codes to categories
MATCH (code:ICD_Code), (category:ICD_Category {code: code.categoryCode})
CREATE (code)-[:HAS_CATEGORY]->(category);

// create dimensions
CALL apoc.load.json("file:///c:/git/mortality/data/2015_dimensions.json") YIELD value AS dimensions
WITH dimensions
UNWIND keys(dimensions) AS k
WITH k, dimensions[k] as dim
UNWIND keys(dim) as dim_key
CREATE (n)
WITH dim, dim_key, n, 
    CASE 
        // if CSV column starts with a number, put an underscore in front of it
        WHEN toInteger(left(k, 1)) is null 
            // also, capitalize labels
            THEN toUpper(left(k, 1)) + substring(k, 1) 
        ELSE "_" + k 
    END as label
CALL apoc.create.addLabels(id(n), [ label ]) YIELD node
CALL apoc.create.setProperty(node, "key", dim_key) yield node as n2
CALL apoc.create.setProperty(node, "value", dim[dim_key]) yield node as n3
RETURN n3;

// load death data and link to dimension nodes
// create ICD categories
CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Resident_status {key: map.`resident_status`})
CREATE (d)-[:HAS_RESIDENT_STATUS]->(n)
return d;

// set up index/constraint
CREATE CONSTRAINT ON (d:Death) ASSERT d.id IS UNIQUE;

CALL apoc.load.csv('file:///c:/git/mortality/data/2015_data.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Education_1989_revision {key: map.`education_1989_revision`})
CREATE (d)-[:HAS_EDUCATION_1989_REVISION]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Education_2003_revision {key: map.`education_2003_revision`})
CREATE (d)-[:HAS_EDUCATION_2003_REVISION]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Education_reporting_flag {key: map.`education_reporting_flag`})
CREATE (d)-[:HAS_EDUCATION_REPORTING_FLAG]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Month_of_death {key: map.`month_of_death`})
CREATE (d)-[:HAS_MONTH_OF_DEATH]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Sex {key: map.`sex`})
CREATE (d)-[:HAS_SEX]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Detail_age_type {key: map.`detail_age_type`})
CREATE (d)-[:HAS_DETAIL_AGE_TYPE]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Detail_age {key: map.`detail_age`})
CREATE (d)-[:HAS_DETAIL_AGE_TYPE]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Age_substitution_flag {key: map.`age_substitution_flag`})
CREATE (d)-[:HAS_AGE_SUBSTITUTION_FLAG]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Age_recode_52 {key: map.`age_recode_52`})
CREATE (d)-[:HAS_AGE_RECODE_52]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Age_recode_27 {key: map.`age_recode_27`})
CREATE (d)-[:HAS_AGE_RECODE_27]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Age_recode_12 {key: map.`age_recode_12`})
CREATE (d)-[:HAS_AGE_RECODE_12]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Infant_age_recode_22 {key: map.`infant_age_recode_22`})
CREATE (d)-[:HAS_INFANT_AGE_RECODE]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Place_of_death_and_decedents_status {key: map.`place_of_death_and_decedents_status`})
CREATE (d)-[:HAS_PLACE_OF_DEATH_AND_DECEDENTS_STATUS]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Marital_status {key: map.`marital_status`})
CREATE (d)-[:HAS_MARITAL_STATUS]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Day_of_week_of_death {key: map.`day_of_week_of_death`})
CREATE (d)-[:HAS_DAY_OF_WEEK_OF_DEATH]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Injury_at_work {key: map.`injury_at_work`})
CREATE (d)-[:HAS_INJURY_AT_WORK]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Manner_of_death {key: map.`manner_of_death`})
CREATE (d)-[:HAS_MANNER_OF_DEATH]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Method_of_disposition {key: map.`method_of_disposition`})
CREATE (d)-[:HAS_METHOD_OF_DISPOSITION]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Autopsy {key: map.`autopsy`})
CREATE (d)-[:HAS_AUTOPSY]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Activity_code {key: map.`activity_code`})
CREATE (d)-[:HAS_ACTIVITY_CODE]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Place_of_injury_for_causes_w00_y34_except_y06_and_y07_ {key: map.`place_of_injury_for_causes_w00_y34_except_y06_and_y07_`})
CREATE (d)-[:HAS_PLACE_OF_INJURY_FOR_CAUSES_W00_Y34_EXCEPT_Y06_AND_Y07_]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Icd_code_10th_revision {key: map.`icd_code_10th_revision`})
CREATE (d)-[:HAS_ICD_CODE_10th_REVISION]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:_358_cause_recode {key: map.`358_cause_recode`})
CREATE (d)-[:HAS_358_CAUSE_RECODE]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:_113_cause_recode {key: map.`113_cause_recode`})
CREATE (d)-[:HAS_113_CAUSE_RECODE]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:_130_infant_cause_recode {key: map.`130_infant_cause_recode`})
CREATE (d)-[:HAS_INFANT_CAUSE_RECODE]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:_39_cause_recode {key: map.`39_cause_recode`})
CREATE (d)-[:HAS_39_CAUSE_RECODE]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Race {key: map.`race`})
CREATE (d)-[:HAS_RACE]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Bridged_race_flag {key: map.`bridged_race_flag`})
CREATE (d)-[:HAS_BRIDGED_RACE_FLAG]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Race_imputation_flag {key: map.`race_imputation_flag`})
CREATE (d)-[:HAS_RACE_IMPUTATION_FLAG]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Race_recode_3 {key: map.`race_recode_3`})
CREATE (d)-[:HAS_RACE_RECODE_3]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Race_recode_5 {key: map.`race_recode_5`})
CREATE (d)-[:HAS_RACE_RECODE_5]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Hispanic_origin {key: map.`hispanic_origin`})
CREATE (d)-[:HAS_HISPANIC_ORIGIN]->(n)
return d;

CALL apoc.load.csv('file:///c:/git/mortality/data/x.csv') YIELD lineNo, list, map
MERGE (d:Death {id: lineNo})
WITH d, map
MATCH (n:Hispanic_originrace_recode {key: map.`hispanic_originrace_recode`})
CREATE (d)-[:HAS_HISPANIC_ORIGINRACE_RECODE]->(n)
return d;
