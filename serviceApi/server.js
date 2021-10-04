
const express = require("express");

let app = express();


app.use(function (req, res, next) {
	res.header("Access-Control-Allow-Origin", "*");
	res.header(
		"Access-Control-Allow-Headers",
		"Origin, X-Requested-With, Content-Type, Accept"
	);
	next();
});

const configParams = (() => {
	let p = {
		// sql: {
		//     server: "groceries.c3zv0ag7ak5f.ap-south-1.rds.amazonaws.com",
		//     // server: "localhost",
		//     user: "admin",
		//     password: "Apple#123",
		//     database: "assessment",
		//     trustServerCertificate: true,
		//     port: 1404,
		//     pool: {
		// 		max: 10,
		// 		min: 0,
		// 		idleTimeoutMillis: 30000
		// 	},
		// 	options: {
		// 		encrypt: false,
		// 		appName: "cloud-Rajendra"
		//     },            
		//     connectionTimeout: 50000,
		//     requestTimeout: 50000,
		// }
		sql: {
			// server: "groceries.c3zv0ag7ak5f.ap-south-1.rds.amazonaws.com",
			server: "localhost",
			user: "sa",
			password: "Apple#123",
			database: "University",
			// port: 1404,
			port: 1433,
			pool: {
				max: 10,
				min: 0,
				idleTimeoutMillis: 30000
			}
		},
	};

	if (process.env.server && process.env.user && process.env.password && process.env.database && process.env.port) {
		p.sql.server = process.env.server;
		p.sql.port = process.env.port;
		p.sql.user = process.env.user;
		p.sql.password = process.env.password;
		p.sql.database = process.env.database;
	}
	return p;
})();

require("./db")(configParams)
	.then(dbwrapper => {
		let searchCourse = require("./searchCourse");
		app.get("/searchCourse", async function (req, res) {

			let response = await searchCourse(dbwrapper, req.query)
			console.log("response",response)
			res.status(200).json(response)

		});
		if (!process.env.UT) {
			app.listen(process.env.PORT || 1337);
		}
	})

	.catch(reason => {
		console.log("app init failed", reason);
	});

module.exports = app
