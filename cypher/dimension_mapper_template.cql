CREATE CONSTRAINT ON (n:%%label%%) ASSERT n.key IS UNIQUE;

CALL apoc.periodic.iterate("
CALL apoc.load.csv('%%path%%') YIELD lineNo, list, map", "

// TODO: id by year, lineNo
// Death nodes id'd by line number of CSV file
MERGE (d:Death {id: lineNo, year: map.`current_data_year`})
WITH d, map, 
    CASE 
        // if value is a number, cast it to an integer so we can match
        WHEN toInteger(map.`%%dimension%%`) is null 
            THEN map.`%%dimension%%`
        ELSE toInteger(map.`%%dimension%%`)
    END as value_typed
OPTIONAL MATCH (n:%%label%% {key: value_typed})

// if we find the key, then create the relationship
FOREACH (ignoreMe in CASE
   WHEN n IS NOT NULL THEN [1]
   ELSE [] END | 
   MERGE (d)-[:%%relation%%]->(n)
)
// otherwise, create a log node for debug purposes
FOREACH (ignoreMe in CASE
   WHEN n IS NULL THEN [1]
   ELSE [] END | 
   MERGE (l:Log {event_type: 'missing foreign key', 
                 node_ref: '%%label%%', 
                 value: value_typed
                })
   ON CREATE SET l.updated_at = datetime(), l.instances = 1
   ON MATCH SET l.updated_at = datetime(), l.instances = l.instances + 1
)
RETURN d;
", {batchSize:100, iterateList:true});
