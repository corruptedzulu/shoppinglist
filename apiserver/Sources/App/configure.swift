import FluentMySQL
import Vapor
import DotEnv

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentMySQLProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database

    /// Register the configured SQLite database to the database config.
    //var databases = DatabasesConfig()
    //databases.add(database: mysql, as: .sqlite)
    //services.register(databases)
    
    let env = DotEnv(withFile: ".env");
    
    let host = env.get("DB_HOST") ?? "localhost";
    let port = env.get("DB_PORT") ?? 3306;
    let pswd = env.get("DB_PW");
    let user = env.get("DB_USER");
    let base = eng.get("DB_DATABASE");

    let mysqlConfig = MySQLDatabaseConfig(hostname: "localhost", port: 3306, username: "", password: "", database: "listdb")
    services.register(mysqlConfig)
    
    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Item.self, database: .mysql)
    services.register(migrations)

}
