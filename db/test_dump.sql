BEGIN TRANSACTION;
CREATE TABLE "categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "label" text, "created_at" datetime, "updated_at" datetime);
INSERT INTO categories VALUES(1,'Kunst','2011-01-28 16:17:25.732123','2011-01-28 16:17:25.732123');
INSERT INTO categories VALUES(2,'Fotografie','2011-01-28 16:17:34.380617','2011-01-28 16:17:34.380617');
INSERT INTO categories VALUES(3,'Film','2011-01-28 16:17:39.204893','2011-01-28 16:17:39.204893');
INSERT INTO categories VALUES(4,'Animation','2011-01-28 16:17:44.940221','2011-01-28 16:17:44.940221');
INSERT INTO categories VALUES(5,'Werbung','2011-01-28 16:17:59.750068','2011-01-28 16:17:59.750068');
INSERT INTO categories VALUES(6,'Design','2011-01-28 16:18:09.796643','2011-01-28 16:18:09.796643');
INSERT INTO categories VALUES(7,'Comic','2011-01-28 16:18:16.702038','2011-01-28 16:18:16.702038');
INSERT INTO categories VALUES(8,'Game','2011-01-28 16:18:28.220697','2011-01-28 16:18:28.220697');
INSERT INTO categories VALUES(9,'Flash','2011-01-28 16:18:33.388993','2011-01-28 16:18:33.388993');
INSERT INTO categories VALUES(10,'Web','2011-01-28 16:18:37.204211','2011-01-28 16:18:37.204211');
INSERT INTO categories VALUES(11,'Community','2011-01-28 16:19:13.821305','2011-01-28 16:19:13.821305');
INSERT INTO categories VALUES(12,'Sozial','2011-01-28 16:19:19.085606','2011-01-28 16:19:19.085606');
CREATE TABLE "categories_projects" ("category_id" integer, "project_id" integer);
INSERT INTO categories_projects VALUES(6,2);
INSERT INTO categories_projects VALUES(10,2);
INSERT INTO categories_projects VALUES(11,2);
INSERT INTO categories_projects VALUES(6,1);
INSERT INTO categories_projects VALUES(10,1);
INSERT INTO categories_projects VALUES(2,3);
CREATE TABLE "jobs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "project_id" integer, "created_at" datetime, "updated_at" datetime);
INSERT INTO jobs VALUES(1,'PHP5-Developer',1,'2011-01-28 16:20:27.652528','2011-01-28 16:20:27.652528');
INSERT INTO jobs VALUES(2,'Marketing-Manager',1,'2011-01-28 16:20:27.720532','2011-01-28 16:20:27.720532');
INSERT INTO jobs VALUES(3,'Frontend-Designer',2,'2011-01-28 16:27:39.689239','2011-01-28 16:27:39.689239');
CREATE TABLE "media" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "label" varchar(255), "link" varchar(255), "project_id" integer, "statusupdate_id" integer, "created_at" datetime, "updated_at" datetime, "asset_file_name" varchar(255), "asset_content_type" varchar(255), "asset_file_size" integer, "asset_updated_at" datetime, "type" varchar(255));
CREATE TABLE "notifications" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "content" text, "sender_id" integer, "receiver_id" integer, "project_id" integer, "isNew" boolean, "html_tmpl_key" varchar(255), "created_at" datetime, "updated_at" datetime);
INSERT INTO notifications VALUES(2,NULL,3,2,2,'f','USER_NEW','2011-01-28 16:25:22.504393','2011-01-28 16:27:10.982597');
INSERT INTO notifications VALUES(3,NULL,2,3,2,'f','ACCEPTED_TO_USER','2011-01-28 16:25:22.667402','2011-01-28 16:34:58.882360');
INSERT INTO notifications VALUES(4,NULL,2,1,3,'t','DECISION_TO_OWNER','2011-01-28 16:34:23.551339','2011-01-28 16:46:35.689215');
INSERT INTO notifications VALUES(5,NULL,2,1,2,'t','DECISION_TO_USER','2011-01-28 16:45:20.571918','2011-01-28 16:46:36.039235');
CREATE TABLE "privacy_settings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "show_update" boolean, "show_update_media" boolean, "show_update_edit" boolean, "show_update_jobs" boolean, "show_update_status" boolean, "show_update_user" boolean, "show_update_post" boolean, "project_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "projects" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "status" varchar(255), "link" varchar(255), "description" text, "isInternal" boolean, "isPublic" boolean, "created_at" datetime, "updated_at" datetime, "currentstage" integer, "cover_id" integer);
INSERT INTO projects VALUES(1,'envoice','finished',NULL,'envoice kombiniert organisatorische Angelegenheiten und bringt sie auf einen Platz zusammen. Vorwiegend soll die Applikation für Freiberufler gedacht sein.

Aufbau ist folgender:

Es gibt Projekte, denen sogenannte Items zugeordnet werden (im Bsp. Website wäre das: Design, Programmierung, SEO, etc.), diese Projekte erhalten einen Status und können auch einem Kunden zugeordnet werden.

Je nach Status hat man versch. Interaktionsmöglichkeiten.

Ist ein Projekt abgeschlossen, kann eine Rechnung ausgestellt werden. Diese wird dynamisch als PDF generiert.

Weiters werden die Projekte mit ihren Deadlines in einem eigens geschriebenen Kalender angezeigt.

envoice wurde in PHP5 geschrieben, die dazugehörige Datenbank in MySQL.

envoice ist als Basis-Qualifikationsprojekt entstanden.','t','t','2011-01-28 16:09:36.128263','2011-01-28 16:26:27.041084',NULL,NULL);
INSERT INTO projects VALUES(2,'Projektplattform','inprogress',NULL,'Die Plattform soll die Möglichkeit schaffen Projekte zu kommunizieren und die Teambildung vereinfachen.
Zugänglich für alle Studierenenden des Mediacubes und externe Auftraggeber. Durch Erweiterungen der Funktionen soll die Plattform attraktiver und dadurch mehr genutzt werden.
Damit die Plattform präsenter wird als der bestehende Projektblog soll das System in den “Single Sign On” eingebunden werden.','t','t','2011-01-28 16:23:30.515987','2011-01-28 16:30:32.554126',6,NULL);
INSERT INTO projects VALUES(3,'Test Projekt','idea',NULL,'Der Test-User hat folgende Login Daten: "admin@example.com", "admintest".','t','t','2011-01-28 16:33:14.326379','2011-01-28 16:33:14.326379',NULL,NULL);
CREATE TABLE "roles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "role" varchar(255), "project_id" integer, "user_id" integer, "job" varchar(255));
INSERT INTO roles VALUES(1,'owner',1,2,'one-man-project ;-)');
INSERT INTO roles VALUES(2,'owner',2,2,'Ruby on Rails');
INSERT INTO roles VALUES(3,'member',2,3,'Ruby on Rails');
INSERT INTO roles VALUES(4,'owner',3,1,'Testing');
INSERT INTO roles VALUES(5,'follower',3,3,NULL);
INSERT INTO roles VALUES(6,'follower',1,1,NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
INSERT INTO schema_migrations VALUES(20101229185431);
INSERT INTO schema_migrations VALUES(20101229185747);
INSERT INTO schema_migrations VALUES(20101229193205);
INSERT INTO schema_migrations VALUES(20101229224149);
INSERT INTO schema_migrations VALUES(20101229224217);
INSERT INTO schema_migrations VALUES(20101229225504);
INSERT INTO schema_migrations VALUES(20101230134029);
INSERT INTO schema_migrations VALUES(20101230211715);
INSERT INTO schema_migrations VALUES(20110105160548);
INSERT INTO schema_migrations VALUES(20110106132717);
INSERT INTO schema_migrations VALUES(20110106193610);
INSERT INTO schema_migrations VALUES(20110107234519);
INSERT INTO schema_migrations VALUES(20110108022908);
INSERT INTO schema_migrations VALUES(20110108235921);
INSERT INTO schema_migrations VALUES(20110108235924);
INSERT INTO schema_migrations VALUES(20110109102903);
INSERT INTO schema_migrations VALUES(20110109155432);
INSERT INTO schema_migrations VALUES(20110122171507);
INSERT INTO schema_migrations VALUES(20110123140312);
INSERT INTO schema_migrations VALUES(20110123160021);
INSERT INTO schema_migrations VALUES(20110124211655);
INSERT INTO schema_migrations VALUES(20110124214046);
INSERT INTO schema_migrations VALUES(20110125102716);
INSERT INTO schema_migrations VALUES(20110126191243);
CREATE TABLE sqlite_sequence(name,seq);
INSERT INTO sqlite_sequence VALUES('users',3);
INSERT INTO sqlite_sequence VALUES('projects',3);
INSERT INTO sqlite_sequence VALUES('roles',6);
INSERT INTO sqlite_sequence VALUES('texttemplates',8);
INSERT INTO sqlite_sequence VALUES('statusupdates',10);
INSERT INTO sqlite_sequence VALUES('categories',12);
INSERT INTO sqlite_sequence VALUES('jobs',3);
INSERT INTO sqlite_sequence VALUES('notifications',5);
INSERT INTO sqlite_sequence VALUES('stages',7);
CREATE TABLE "stages" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "description" text, "position" integer, "project_id" integer, "created_at" datetime, "updated_at" datetime);
INSERT INTO stages VALUES(1,'Konzeption',NULL,1,2,'2011-01-28 16:30:24.085642','2011-01-28 16:30:24.085642');
INSERT INTO stages VALUES(2,'Projektübersicht/-ansicht',NULL,2,2,'2011-01-28 16:30:24.180647','2011-01-28 16:30:24.180647');
INSERT INTO stages VALUES(3,'Editing-Modus',NULL,3,2,'2011-01-28 16:30:24.270653','2011-01-28 16:30:24.270653');
INSERT INTO stages VALUES(4,'Roles & Permissions + Login',NULL,4,2,'2011-01-28 16:30:24.324656','2011-01-28 16:30:24.324656');
INSERT INTO stages VALUES(5,'Statusupdates',NULL,5,2,'2011-01-28 16:30:24.387659','2011-01-28 16:30:24.387659');
INSERT INTO stages VALUES(6,'Notifications / Interaktion',NULL,6,2,'2011-01-28 16:30:24.442662','2011-01-28 16:30:24.442662');
INSERT INTO stages VALUES(7,'Refactoring',NULL,7,2,'2011-01-28 16:30:24.505666','2011-01-28 16:30:24.505666');
CREATE TABLE "statusupdates" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "content" varchar(255), "isPublic" boolean, "user_id" integer, "project_id" integer, "created_at" datetime, "updated_at" datetime, "html_tmpl_key" varchar(255));
INSERT INTO statusupdates VALUES(1,'Der <b>Projektstatus</b> wurde auf <span>Abgeschlossen</span> gesetzt.','t',2,1,'2011-01-28 16:15:55.093939','2011-01-28 16:15:55.171943','STATUS');
INSERT INTO statusupdates VALUES(2,'Es wurden neue Jobs ausgeschrieben:<br /><span>PHP5-Developer, Marketing-Manager</span>','t',2,1,'2011-01-28 16:20:27.842539','2011-01-28 16:20:27.952545','JOBS');
INSERT INTO statusupdates VALUES(3,'ist ein neues Teammitglied.','t',3,2,'2011-01-28 16:25:22.772408','2011-01-28 16:25:22.772408','TEAM');
INSERT INTO statusupdates VALUES(4,'Das Projekt wurde editiert.','t',2,1,'2011-01-28 16:26:27.220094','2011-01-28 16:26:27.304099','EDIT');
INSERT INTO statusupdates VALUES(5,'Es wurden neue Jobs ausgeschrieben:<br /><span>Frontend-Designer</span>','t',2,2,'2011-01-28 16:27:39.855249','2011-01-28 16:27:39.956254','JOBS');
INSERT INTO statusupdates VALUES(6,'Der <b>Projektstatus</b> wurde auf <span>In Arbeit</span> gesetzt.','t',2,2,'2011-01-28 16:30:32.662133','2011-01-28 16:30:32.792140','STATUS');
INSERT INTO statusupdates VALUES(7,'Ich teste hier mal eben die Statusupdates!! :)','t',2,2,'2011-01-28 16:40:05.601903','2011-01-28 16:40:05.601903','POST');
INSERT INTO statusupdates VALUES(8,'Ich schreib hier auch noch was dazu ;)','t',3,2,'2011-01-28 16:40:59.406980','2011-01-28 16:40:59.406980','POST');
INSERT INTO statusupdates VALUES(9,'So, dann können wir ja das Projekt starten!!','t',1,3,'2011-01-28 16:41:21.411239','2011-01-28 16:41:21.411239','POST');
INSERT INTO statusupdates VALUES(10,'Das Projekt wurde editiert.','t',1,3,'2011-01-28 16:44:01.098372','2011-01-28 16:44:01.165376','EDIT');
CREATE TABLE "texttemplates" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "key" varchar(255), "text" text(255), "created_at" datetime, "updated_at" datetime);
INSERT INTO texttemplates VALUES(1,'media_new','#user hat neue Medien hochgeladen.','2011-01-23 14:28:27.058937','2011-01-23 14:28:27.058937');
INSERT INTO texttemplates VALUES(2,'project_edit','Das Projekt wurde editiert.','2011-01-23 14:28:55.024536','2011-01-23 14:28:55.024536');
INSERT INTO texttemplates VALUES(3,'project_status_edit','Der <b>Projektstatus</b> wurde auf <span>#status</span> gesetzt.','2011-01-23 14:29:47.473536','2011-01-23 14:29:47.473536');
INSERT INTO texttemplates VALUES(4,'project_current_stage_edit','Das Projekt befindet sich jetzt in der Stage <span>#stage</span>.','2011-01-23 14:30:36.009312','2011-01-23 14:30:36.009312');
INSERT INTO texttemplates VALUES(5,'job_new','Es wurden neue Jobs ausgeschrieben:<br /><span>#jobs</span>','2011-01-23 14:31:36.601778','2011-01-23 14:31:36.601778');
INSERT INTO texttemplates VALUES(6,'job_delete','Folgende Jobs sind nicht mehr verfügbar:<br /><span>#jobs</span>','2011-01-23 14:31:59.716100','2011-01-23 14:31:59.716100');
INSERT INTO texttemplates VALUES(7,'team_new','ist ein neues Teammitglied.','2011-01-23 14:33:12.845283','2011-01-23 14:33:12.845283');
INSERT INTO texttemplates VALUES(8,'team_delete','hat das Team verlassen.','2011-01-23 14:33:37.872714','2011-01-23 14:33:37.872714');
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "telephone" varchar(255), "web" varchar(255), "avatar" varchar(255), "created_at" datetime, "updated_at" datetime, "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(128) DEFAULT '' NOT NULL, "password_salt" varchar(255) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "remember_token" varchar(255), "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "confirmation_token" varchar(255), "confirmed_at" datetime, "confirmation_sent_at" datetime, "statement" text);
INSERT INTO users VALUES(1,'Test User',NULL,NULL,NULL,'2011-01-28 16:04:29.268712','2011-01-28 16:45:27.329305','admin@example.com','$2a$10$Qg.edYpeyuXDtEtSbVdTGeE/CJySZMHIeLR94UB8Ye2Ti8NOqyYwq','$2a$10$Qg.edYpeyuXDtEtSbVdTGe',NULL,NULL,NULL,6,'2011-01-28 16:45:27.329305','2011-01-28 16:43:51.294812','127.0.0.1','127.0.0.1',NULL,NULL,NULL,NULL);
INSERT INTO users VALUES(2,'Tobias Klika',+436602594892,'http://artistandarchitects.at',NULL,'2011-01-28 16:05:24.104848','2011-01-28 16:53:50.719097','klika@live.at','$2a$10$A0cN4Ng7QxhI2yED/6v0luaqPoe7H6qy2yVmIgvz3U4Hhnv/Fsr2O','$2a$10$A0cN4Ng7QxhI2yED/6v0lu',NULL,NULL,NULL,8,'2011-01-28 16:52:33.025653','2011-01-28 16:45:02.458882','127.0.0.1','127.0.0.1',NULL,NULL,NULL,'Hallo!

Wir erstellen hier einen Test Dump für unsere Projektplattform =)');
INSERT INTO users VALUES(3,'Thomas Buchöster',NULL,NULL,NULL,'2011-01-28 16:24:39.985961','2011-01-28 16:40:43.800088','tb.tabu@web.de','$2a$10$i7qlUfCAGyaoPk7sRJn3mOSeIC0DMeS.BhUGJq9MpZ27hetd1wuEK','$2a$10$i7qlUfCAGyaoPk7sRJn3mO',NULL,NULL,NULL,3,'2011-01-28 16:40:43.799088','2011-01-28 16:34:50.707892','127.0.0.1','127.0.0.1',NULL,NULL,NULL,NULL);
CREATE UNIQUE INDEX "index_users_on_confirmation_token" ON "users" ("confirmation_token");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
COMMIT;
