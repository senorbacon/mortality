// set up index/constraint
CREATE CONSTRAINT ON (d:Death) ASSERT d.id IS UNIQUE;

// load death data and link to dimension nodes
// create ICD categories
CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Resident_status {key: map.`resident_status`})
    CREATE (d)-[:HAS_RESIDENT_STATUS]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Education_1989_revision {key: map.`education_1989_revision`})
    CREATE (d)-[:HAS_EDUCATION_1989_REVISION]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Education_2003_revision {key: map.`education_2003_revision`})
    CREATE (d)-[:HAS_EDUCATION_2003_REVISION]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Education_reporting_flag {key: map.`education_reporting_flag`})
    CREATE (d)-[:HAS_EDUCATION_REPORTING_FLAG]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Month_of_death {key: map.`month_of_death`})
    CREATE (d)-[:HAS_MONTH_OF_DEATH]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Sex {key: map.`sex`})
    CREATE (d)-[:HAS_SEX]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Detail_age_type {key: map.`detail_age_type`})
    CREATE (d)-[:HAS_DETAIL_AGE_TYPE]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Detail_age {key: map.`detail_age`})
    CREATE (d)-[:HAS_DETAIL_AGE_TYPE]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Age_substitution_flag {key: map.`age_substitution_flag`})
    CREATE (d)-[:HAS_AGE_SUBSTITUTION_FLAG]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Age_recode_52 {key: map.`age_recode_52`})
    CREATE (d)-[:HAS_AGE_RECODE_52]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Age_recode_27 {key: map.`age_recode_27`})
    CREATE (d)-[:HAS_AGE_RECODE_27]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Age_recode_12 {key: map.`age_recode_12`})
    CREATE (d)-[:HAS_AGE_RECODE_12]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Infant_age_recode_22 {key: map.`infant_age_recode_22`})
    CREATE (d)-[:HAS_INFANT_AGE_RECODE]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Place_of_death_and_decedents_status {key: map.`place_of_death_and_decedents_status`})
    CREATE (d)-[:HAS_PLACE_OF_DEATH_AND_DECEDENTS_STATUS]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Marital_status {key: map.`marital_status`})
    CREATE (d)-[:HAS_MARITAL_STATUS]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Day_of_week_of_death {key: map.`day_of_week_of_death`})
    CREATE (d)-[:HAS_DAY_OF_WEEK_OF_DEATH]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Injury_at_work {key: map.`injury_at_work`})
    CREATE (d)-[:HAS_INJURY_AT_WORK]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Manner_of_death {key: map.`manner_of_death`})
    CREATE (d)-[:HAS_MANNER_OF_DEATH]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Method_of_disposition {key: map.`method_of_disposition`})
    CREATE (d)-[:HAS_METHOD_OF_DISPOSITION]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Autopsy {key: map.`autopsy`})
    CREATE (d)-[:HAS_AUTOPSY]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Activity_code {key: map.`activity_code`})
    CREATE (d)-[:HAS_ACTIVITY_CODE]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Place_of_injury_for_causes_w00_y34_except_y06_and_y07_ {key: map.`place_of_injury_for_causes_w00_y34_except_y06_and_y07_`})
    CREATE (d)-[:HAS_PLACE_OF_INJURY_FOR_CAUSES_W00_Y34_EXCEPT_Y06_AND_Y07_]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Icd_code_10th_revision {key: map.`icd_code_10th_revision`})
    CREATE (d)-[:HAS_ICD_CODE_10th_REVISION]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:_358_cause_recode {key: map.`358_cause_recode`})
    CREATE (d)-[:HAS_358_CAUSE_RECODE]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:_113_cause_recode {key: map.`113_cause_recode`})
    CREATE (d)-[:HAS_113_CAUSE_RECODE]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:_130_infant_cause_recode {key: map.`130_infant_cause_recode`})
    CREATE (d)-[:HAS_INFANT_CAUSE_RECODE]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:_39_cause_recode {key: map.`39_cause_recode`})
    CREATE (d)-[:HAS_39_CAUSE_RECODE]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Race {key: map.`race`})
    CREATE (d)-[:HAS_RACE]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Bridged_race_flag {key: map.`bridged_race_flag`})
    CREATE (d)-[:HAS_BRIDGED_RACE_FLAG]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Race_imputation_flag {key: map.`race_imputation_flag`})
    CREATE (d)-[:HAS_RACE_IMPUTATION_FLAG]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Race_recode_3 {key: map.`race_recode_3`})
    CREATE (d)-[:HAS_RACE_RECODE_3]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Race_recode_5 {key: map.`race_recode_5`})
    CREATE (d)-[:HAS_RACE_RECODE_5]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Hispanic_origin {key: map.`hispanic_origin`})
    CREATE (d)-[:HAS_HISPANIC_ORIGIN]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});

CALL apoc.periodic.iterate("
    CALL apoc.load.csv('file:///c:/git/mortality/data/z.csv') YIELD lineNo, list, map", "
    MERGE (d:Death {id: lineNo})
    WITH d, map
    MATCH (n:Hispanic_originrace_recode {key: map.`hispanic_originrace_recode`})
    CREATE (d)-[:HAS_HISPANIC_ORIGINRACE_RECODE]->(n)
    RETURN d;
", {batchSize:100, iterateList:true});
