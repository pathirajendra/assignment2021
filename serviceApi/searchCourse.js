const mssql = require('mssql');
const fuzzysort = require('fuzzysort')

module.exports = async (dbwrapper, params) => {


    console.log("request started", new Date())
    const requestParams = dbwrapper.getNewRequest();

    let matchingCourses = []
    if (params.courseName && params.courseName != "null" && params.courseName != "undefined") {
        let coursesList = await requestParams.execute('getAllCourseName');
        // console.log(coursesList);        
        let results = fuzzysort.go(params.courseName, coursesList.recordsets[0].map(course => { return course.name }))
        // console.log(results[0].target)
        if (results && Array.isArray(results) && results.length) {
            for (const result of results) {
                matchingCourses.push(result.target)
            }
        }
        else {
            matchingCourses.push(params.courseName)
        }
        // console.log(matchingCourses)
    }
    return new Promise((resolve, reject) => {
        requestParams.input('gpa', mssql.Float, Number(params.gpa));
        requestParams.input('greScore', mssql.Int, Number(params.greScore));
        requestParams.input('country', mssql.VarChar, params.country);
        requestParams.input('courseName', mssql.VarChar, matchingCourses.length ? matchingCourses.toString() : null);

        requestParams.execute('searchCourse', (err, result) => {
            if (err) {
                console.error(err);
                return reject(err);

            }
            console.log("request ended", new Date())
            return resolve(result.recordsets[0]);
        })
    })
}