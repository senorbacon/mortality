// set up uniqueness indexes
CREATE CONSTRAINT ON (d:Death) ASSERT d.id IS UNIQUE;
CREATE CONSTRAINT ON (category:ICD_Category) ASSERT category.code IS UNIQUE;
CREATE CONSTRAINT ON (code:ICD_Code) ASSERT code.code IS UNIQUE;

// set up composite index on log nodes
CREATE INDEX ON :Log(event_type, node_ref, value);

// create ICD categories
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "file:///2018_icd_categories.csv" AS line WITH line
CREATE (c:ICD_Category {code: line.`Category Code`, title: line.`Category Title`});

// create ICD Codes
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "file:///2018_icd_codes.csv" AS line WITH line
CREATE (c:ICD_Code {code: line.`Full Code`, categoryCode: line.`Category Code`, description: line.`Full Description`});

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
    END as label,
    CASE 
        // if key is a number, store it as a number, not a string
        WHEN toInteger(dim_key) is null 
            THEN dim_key 
        ELSE toInteger(dim_key)
    END as dim_key_typed
CALL apoc.create.addLabels(id(n), [ label ]) YIELD node
CALL apoc.create.setProperty(node, "key", dim_key_typed) yield node as n2
CALL apoc.create.setProperty(node, "value", dim[dim_key]) yield node as n3
RETURN n3;

