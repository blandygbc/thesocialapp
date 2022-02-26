import { join } from "path";
import { ConnectionOptions } from "typeorm";

const connectionOptions: ConnectionOptions = {
    type: "postgres",
    host: process.env.POSTGRES_HOST,
    port: Number.parseInt(process.env.POSTGRES_PORT as string) || 5432,
    username: process.env.POSTGRES_USER,
    password: process.env.POSTGRES_PASSWORD,
    database: process.env.POSTGRES_DATABASE,
    entities: ["src/database/entity/*.ts"],
    synchronize: true,
    dropSchema: false,
    migrationsRun: true,
    logging: true,
    logger: "debug",
    migrations: [join(__dirname, "src/migration/**/*.ts")],
};

export = connectionOptions;