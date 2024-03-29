BEGIN TRANSACTION;
CREATE TABLE "categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "label" text, "created_at" datetime, "updated_at" datetime);
INSERT INTO categories VALUES(1,'Musik','2010-12-29 19:37:39.366153','2010-12-29 19:37:39.366153');
INSERT INTO categories VALUES(2,'Web','2010-12-29 19:37:42.471331','2010-12-29 19:37:42.471331');
INSERT INTO categories VALUES(3,'Animation','2010-12-29 19:37:45.271491','2010-12-29 19:37:45.271491');
INSERT INTO categories VALUES(4,'Film','2010-12-29 19:37:48.551679','2010-12-29 19:37:48.551679');
INSERT INTO categories VALUES(5,'Design','2010-12-29 19:37:55.207059','2010-12-29 19:37:55.207059');
INSERT INTO categories VALUES(6,'Programmierung','2010-12-29 19:51:35.327968','2010-12-29 19:51:35.327968');
CREATE TABLE "categories_projects" ("project_id" integer, "category_id" integer);
INSERT INTO categories_projects VALUES(1,2);
INSERT INTO categories_projects VALUES(2,4);
INSERT INTO categories_projects VALUES(3,3);
INSERT INTO categories_projects VALUES(5,3);
INSERT INTO categories_projects VALUES(4,6);
CREATE TABLE "jobs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "project_id" integer, "created_at" datetime, "updated_at" datetime);
INSERT INTO jobs VALUES(1,'Software-Engineer',1,'2010-12-29 23:45:22.846296','2010-12-29 23:48:55.591464');
INSERT INTO jobs VALUES(2,'Designer',1,'2010-12-29 23:49:22.950029','2010-12-29 23:50:59.606557');
CREATE TABLE "projects" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "status" varchar(255), "link" varchar(255), "description" text, "picture" varchar(255), "isInternal" boolean, "isPublic" boolean, "created_at" datetime, "updated_at" datetime);
INSERT INTO projects VALUES(1,'YEAH',NULL,NULL,'Was geht ab, Leute???',NULL,NULL,NULL,'2010-12-29 19:36:59.658882','2010-12-29 19:36:59.658882');
INSERT INTO projects VALUES(2,'Mein zweites Projekt',NULL,NULL,'Also das hier wird voll cool. Da werden alle beeindruckt sein!!',NULL,NULL,NULL,'2010-12-29 19:37:26.882439','2010-12-29 19:37:26.882439');
INSERT INTO projects VALUES(4,'Teeeest',NULL,NULL,'Jetzt fällt mir gar nichts mehr ein!
Vielleicht ein Lorem Ipsum? Nööööö',NULL,NULL,NULL,NULL,NULL);
INSERT INTO projects VALUES(5,'Meine Güte, scheiß Leertexte!',NULL,NULL,'Test für die zweite Reihe ;-)',NULL,NULL,NULL,NULL,NULL);
CREATE TABLE "roles" ("role" varchar(255), "project_id" integer, "user_id" integer, "job_id" integer);
INSERT INTO roles VALUES(NULL,1,1,NULL);
INSERT INTO roles VALUES(NULL,NULL,NULL,NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
INSERT INTO schema_migrations VALUES(20101229185431);
INSERT INTO schema_migrations VALUES(20101229185747);
INSERT INTO schema_migrations VALUES(20101229193205);
INSERT INTO schema_migrations VALUES(20101229224149);
INSERT INTO schema_migrations VALUES(20101229224217);
INSERT INTO schema_migrations VALUES(20101229225504);
CREATE TABLE sqlite_sequence(name,seq);
INSERT INTO sqlite_sequence VALUES('projects',5);
INSERT INTO sqlite_sequence VALUES('categories',6);
INSERT INTO sqlite_sequence VALUES('users',2);
INSERT INTO sqlite_sequence VALUES('jobs',2);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "mail" varchar(255), "telephone" varchar(255), "password" varchar(255), "web" varchar(255), "avatar" varchar(255), "created_at" datetime, "updated_at" datetime);
INSERT INTO users VALUES(1,'Tobias Klika','klika@live.at','+43 660 265968997','hallloooo','http://artistandarchitects.at','tobi.jpg',NULL,NULL);
INSERT INTO users VALUES(2,'Tom','tom@tom.tom','+49 tom tom','tobi =)','http://tom.tom','tom.jpg',NULL,NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
COMMIT;
