# Mortality Explorer
Explore US Mortality data. 

Original data set is from [this Kaggle project](https://www.kaggle.com/cdc/mortality "Kaggle"), which in turn is based on public CDC data from 2015. 

ICD codes are taken from [this Github repo](http://https://github.com/kamillamagna/ICD-10-CSV "this Github repo") and are from 2018. 2015 codes are available [here](https://www.cdc.gov/nchs/icd/icd10cm.htm "here") but only in XML form. I will convert to CSV only if the 2018 codes have changed significantly enough to make the 2015 mortality data problematic.

## Technical details
### Data model
NOTE: the data file `2015_data.csv` is too large to store in this repo. Please download it from [this Kaggle project](https://www.kaggle.com/cdc/mortality "Kaggle") if you need it.

The data itself is rendered as a graph in [Neo4j](https://neo4j.com/ "Neo4j") version 3.4. APOC plugin is required. Current strategy is to render all mortality data as specific nodes, linked to single "Death" node via specific relationships.  For example:

(:Death) -[:HAS_SEX]-> (:Sex {key: "M", value: "Male"})

One challenge is that there is no uniquely identifying data for a given death in the data files. As Neo4J does not provide any sort of auto-increment, we need to reference the line number in the CSV as the unique identifier. This is why the `apoc.load.csv` call is required to load the data, rather than `LOAD CSV` Cypher construct.

#### Example queries
Count how many people died of emphysema:
Emphysema
`MATCH (:_358_cause_recode {key: "266"})<-[r]-(:Death) RETURN count(r);`

Count how many men vs women died of emphysema:
`MATCH (:_358_cause_recode {key: "266"})<--(:Death)-[r:HAS_SEX]->(s) RETURN s, count(r) as count order by count desc;`

Count of different activity codes for homicides/suicides:
`MATCH (:Manner_of_death {value: "Homicide"})<--(:Death)-[r:HAS_ACTIVITY_CODE]->(a) RETURN a, count(r) as count order by count desc;`
`MATCH (:Manner_of_death {value: "Suicide"})<--(:Death)-[r:HAS_ACTIVITY_CODE]->(a) RETURN a, count(r) as count order by count desc;`

Count of causes of death for sports-related injuries:
`MATCH (:Activity_code {key: "0"})<--(:Death)-[r:HAS_358_CAUSE_RECODE]->(c) RETURN c, count(r) as count order by count desc;`

Count of causes of death for work-related injuries:
`MATCH (:Injury_at_work {key: "Y"})<--(:Death)-[r:HAS_358_CAUSE_RECODE]->(c) RETURN c, count(r) as count order by count desc;`

Accidental deaths that occured on a Monday, returning all dimensions for resulting deaths:
`MATCH (:Day_of_week_of_death {value: "Monday"})<-[]-(d:Death)-[]->(:Manner_of_death {value: "Accident"}) 
    WITH d MATCH (d)-[*]->(dim) 
    RETURN d, labels(dim)[0] as dimension, dim.value as value;`

People with a doctorate degree who were the victims of homicide via gun violence:
`MATCH (:Education_2003_revision {value: "Doctorate or professional degree"})<-[]-(d:Death)-[]->(:_358_cause_recode {key: "435"}) 
    WITH d MATCH (d)-[*]->(dim) 
    RETURN d, labels(dim)[0] as dimension, dim.value as value;`



### API / backend
API is https://graphql.org/, running on a serverless backend (Node locally).

### Front-end
Front-end is React.
