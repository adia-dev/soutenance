DROP TABLE IF EXISTS articles;
DROP TABLE IF EXISTS users;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE users (
    id bigserial not null  constraint users_pk primary key,
    name varchar(100) not null,
    password bytea not null,
    created timestamp with time zone not null default CURRENT_TIMESTAMP,
    updated timestamp with time zone not null default CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX users_name_uindex ON users (name);

CREATE TABLE articles (
    id bigserial not null  constraint articles_pk primary key,
    slug text not null,
    title text not null,
    content text not null,
    date timestamp with time zone not null default CURRENT_TIMESTAMP,
    active boolean not null default false,
    id_user bigint not null constraint articles_users_id_fk references users(id)
                      on update cascade on delete cascade,
    created timestamp with time zone not null default CURRENT_TIMESTAMP,
    updated timestamp with time zone not null default CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX articles_slug_uindex ON articles (slug);
