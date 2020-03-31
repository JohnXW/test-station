CREATE TABLE "MIGRATION"(
	"FILE" TEXT NOT NULL,
	PRIMARY KEY("FILE")
);

CREATE TABLE "USER"(
	"NAME" TEXT NOT NULL,
	"PASSWORD" TEXT NOT NULL,
	"ROLE" SMALLINT NOT NULL,
	"MARK" INTEGER NOT NULL DEFAULT 0,
	"LOCK" BOOLEAN NOT NULL DEFAULT FALSE,
	PRIMARY KEY("NAME")
);

CREATE TABLE "SESSION"(
	"TOKEN" TEXT NOT NULL,
	"USER" TEXT NOT NULL,
	"TIME" TIMESTAMP NOT NULL,
	PRIMARY KEY("TOKEN"),
	FOREIGN KEY("USER")
		REFERENCES "USER"("NAME")
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
CREATE SEQUENCE "SESSION_TOKEN_seq"
	AS INTEGER
	CYCLE
	OWNED BY "SESSION"."TOKEN";

CREATE TABLE "SUBJECT"(
	"IDENTIFIER" SERIAL NOT NULL,
	"TITLE" TEXT NOT NULL,
	"DESCRIPTION" TEXT NOT NULL,
	PRIMARY KEY("IDENTIFIER")
);

CREATE TABLE "COURSE"(
	"IDENTIFIER" SERIAL NOT NULL,
	"SUBJECT" INTEGER NOT NULL,
	"TITLE" TEXT NOT NULL,
	"DESCRIPTION" TEXT NOT NULL,
	PRIMARY KEY("IDENTIFIER"),
	FOREIGN KEY("SUBJECT")
		REFERENCES "SUBJECT"("IDENTIFIER")
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE "LESSON"(
	"IDENTIFIER" SERIAL NOT NULL,
	"COURSE" INTEGER NOT NULL,
	"NUMBER" SMALLINT NOT NULL,
	"TITLE" TEXT NOT NULL,
	"CONTENT" TEXT NOT NULL,
	PRIMARY KEY("IDENTIFIER"),
	FOREIGN KEY("COURSE")
		REFERENCES "COURSE"("IDENTIFIER")
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE "QUESTION"(
	"IDENTIFIER" SERIAL NOT NULL,
	"LESSON" INTEGER NOT NULL,
	"NUMBER" SMALLINT NOT NULL,
	"TEXT" TEXT NOT NULL,
	PRIMARY KEY("IDENTIFIER"),
	FOREIGN KEY("LESSON")
		REFERENCES "LESSON"("IDENTIFIER")
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE "ANSWER"(
	"IDENTIFIER" SERIAL NOT NULL,
	"QUESTION" INTEGER NOT NULL,
	"TEXT" TEXT NOT NULL,
	"MARK" INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY("IDENTIFIER"),
	FOREIGN KEY("QUESTION")
		REFERENCES "QUESTION"("IDENTIFIER")
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE "WORK"(
	"USER" TEXT NOT NULL,
	"ANSWER" INTEGER NOT NULL,
	FOREIGN KEY("USER")
		REFERENCES "USER"("NAME")
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY("ANSWER")
		REFERENCES "ANSWER"("IDENTIFIER")
		ON DELETE CASCADE
		ON UPDATE CASCADE
);