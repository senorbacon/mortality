// delete existing stuff
MATCH (n)
DETACH DELETE n;

// no DROP IF EXISTS :-/
DROP INDEX ON :ICD_Category(code);
DROP INDEX ON :ICD_Code(code);

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
WITH k, dim, dim_key, n 
CALL apoc.create.addLabels(id(n), [ k ]) YIELD node
CALL apoc.create.setProperty(node, "key", dim_key) yield node as n2
CALL apoc.create.setProperty(node, "value", dim[dim_key]) yield node as n3
RETURN n3;

// load death data and link to dimension nodes
// create ICD categories
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "file:///x.csv" AS line WITH line
CREATE (d:Death)
WITH d, line
MATCH (n:sex {key: toString(line.sex)})
CREATE (d)-[:HAS_EDUCATION_1989_REVISION]->(e1)
WITH d, line
OPTIONAL MATCH (a:activity_code {key: toString(line.activity_code)})
CREATE (d)-[:HAS_EDUCATION_1989_REVISION]->(a)
WITH d, line
OPTIONAL MATCH (r:resident_status {key: toString(line.resident_status)})
CREATE (d)-[:HAS_RESIDENT_STATUS]->(r)
RETURN d;