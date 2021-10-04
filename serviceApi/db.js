let mssql = require('mssql');
module.exports = (params) => {
    return new Promise((res, rej) => {
        var config = {
            server: params.sql.server,
            user: params.sql.user,
            password: params.sql.password,
            database: params.sql.database,
            port: params.sql.port
        };

        var pool = new mssql.ConnectionPool(config);
        pool.connect()
            .then(resp => {
                console.log("db connected")
                res({
                    getNewRequest: function () {
                        return new mssql.Request(pool);
                    }
                });
            })
            .catch(err => {
                // ... error handler
                console.log('SQLConnError:', err);
                rej(err);
            });


    });
};