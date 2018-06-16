var express = require('express');
var express_graphql = require('express-graphql');
var { buildSchema } = require('graphql');

// GraphQL schema
var schema = buildSchema(`
    type Query {
        course(id: Int!): Course
        courses(topic: String): [Course]
    }

    enum Sex {
        "Male"
        M
        "Female"
        F
    }

    enum MaritalStatus {
        "Single"
        S
        "Married"
        M
        "Widowed"
        W
        "Divorced"
        D
        "Unknown"
        U
    }

    enum YesNoUnknown {
        "Yes"
        Y
        "No"
        N
        "Unknown"
        U
    }

    enum Disposition {
        "Burial"
        B
        "Cremation"
        C
        "Other"
        O
        "Unknown"
        U
    }

    type Death {
        id: ID
        resident_status: Int
        education_1989_revision: Int
        education_2003_revision: Int
        education_reporting_flag: Int
        month_of_death: Int!
        sex: Sex!
        detail_age_type: Int
        age_substitution_flag: Int
        age_recode_52: Int
        age_recode_27: Int
        age_recode_12: Int
        infant_age_recode_22: Int
        place_of_death_and_decedents_status: Int
        marital_status: MaritalStatus!
        day_of_week_of_death: Int!
        injury_at_work: YesNoUnknown!
        manner_of_death: Int
        method_of_disposition: Disposition
        autopsy: YesNoUnknown!
        activity_code: Int
        place_of_injury_for_causes_w00_y34_except_y06_and_y07_: Int
        icd_code_10th_revision: String
        358_cause_recode: Int!
        113_cause_recode: Int!
        130_infant_cause_recode: Int
        39_cause_recode: Int!
        race: Int!
        bridged_race_flag: Int
        race_imputation_flag: Int
        race_recode_3: Int!
        race_recode_5: Int!
        hispanic_origin: Int!
        hispanic_originrace_recode: Int!
    }
`);

var coursesData = [
    {
        id: 1,
        title: 'The Complete Node.js Developer Course',
        author: 'Andrew Mead, Rob Percival',
        description: 'Learn Node.js by building real-world applications with Node, Express, MongoDB, Mocha, and more!',
        topic: 'Node.js',
        url: 'https://codingthesmartway.com/courses/nodejs/'
    },
    {
        id: 2,
        title: 'Node.js, Express & MongoDB Dev to Deployment',
        author: 'Brad Traversy',
        description: 'Learn by example building & deploying real-world Node.js applications from absolute scratch',
        topic: 'Node.js',
        url: 'https://codingthesmartway.com/courses/nodejs-express-mongodb/'
    },
    {
        id: 3,
        title: 'JavaScript: Understanding The Weird Parts',
        author: 'Anthony Alicea',
        description: 'An advanced JavaScript course for everyone! Scope, closures, prototypes, this, build your own framework, and more.',
        topic: 'JavaScript',
        url: 'https://codingthesmartway.com/courses/understand-javascript/'
    }
];

var getCourse = (args) => {
    const id = args.id;
    return coursesData.filter(course => {
        return course.id == id;
    })[0];
}

var getCourses = (args) => {
    if (args.topic) {
        var topic = args.topic;
        return courseData.filter(course => course.topic === topic);
    } else {
        return coursesData;
    }
}

var root = {
    course: getCourse,
    courses: getCourses
}

var app = express();
app.use('/gql', express_graphql({
    schema: schema,
    rootValue: root,
    graphiql: true
}));
app.listen(4000, () => console.log('GQL now running on localhost:4000/gql'));



