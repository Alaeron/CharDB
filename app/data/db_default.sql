BEGIN TRANSACTION;
DROP TABLE IF EXISTS "Status";
CREATE TABLE IF NOT EXISTS "Status" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Character_ID"	INTEGER NOT NULL,
	"Name"	TEXT,
	"Description"	TEXT,
	"Duration"	TEXT,
	FOREIGN KEY("Character_ID") REFERENCES "Character"("ID")
);
DROP TABLE IF EXISTS "Character";
CREATE TABLE IF NOT EXISTS "Character" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Name"	TEXT NOT NULL DEFAULT 'New Character',
	"Background"	TEXT,
	"PlayerName"	TEXT,
	"Race"	TEXT,
	"Alignment"	TEXT,
	"ExperiencePoints"	INTEGER,
	"Appearance"	BLOB,
	"Age"	TEXT,
	"Eyes"	TEXT,
	"Height"	TEXT,
	"Weight"	TEXT,
	"Skin"	REAL,
	"Hair"	TEXT,
	"Strength"	INTEGER,
	"Dexterity"	INTEGER,
	"Constitution"	INTEGER,
	"Intelligence"	INTEGER,
	"Wisdom"	INTEGER,
	"Charisma"	INTEGER,
	"ArmorClass"	INTEGER,
	"Initiative"	INTEGER,
	"Speed"	INTEGER,
	"CurrentHitPoints"	NUMERIC,
	"MaxHitPoints"	INTEGER,
	"TemporaryHitPoint"	INTEGER,
	"DeathSaveSuccess"	INTEGER,
	"DeathSaveFailure"	INTEGER,
	"PassiveWisdom"	INTEGER,
	"SpellSaveDC"	INTEGER,
	"SpellAttackBonus"	INTEGER,
	"ProficiencyBonus"	INTEGER NOT NULL DEFAULT 2,
	"CurrentSpellSlot1"	INTEGER NOT NULL DEFAULT 0,
	"CurrentSpellSlot2"	INTEGER NOT NULL DEFAULT 0,
	"CurrentSpellSlot3"	INTEGER NOT NULL DEFAULT 0,
	"CurrentSpellSlot4"	INTEGER NOT NULL DEFAULT 0,
	"CurrentSpellSlot5"	INTEGER NOT NULL DEFAULT 0,
	"CurrentSpellSlot6"	INTEGER NOT NULL DEFAULT 0,
	"CurrentSpellSlot7"	INTEGER NOT NULL DEFAULT 0,
	"CurrentSpellSlot9"	INTEGER NOT NULL DEFAULT 0,
	"MaxSpellSlot1"	INTEGER NOT NULL DEFAULT 0,
	"MaxSpellSlot2"	INTEGER NOT NULL DEFAULT 0,
	"MaxSpellSlot3"	INTEGER NOT NULL DEFAULT 0,
	"MaxSpellSlot4"	INTEGER NOT NULL DEFAULT 0,
	"MaxSpellSlot5"	INTEGER NOT NULL DEFAULT 0,
	"MaxSpellSlot6"	INTEGER NOT NULL DEFAULT 0,
	"MaxSpellSlot7"	INTEGER NOT NULL DEFAULT 0,
	"MaxSpellSlot8"	INTEGER NOT NULL DEFAULT 0,
	"MaxSpellSlot9"	INTEGER NOT NULL DEFAULT 0,
	"SavingThrowStrengthProficiency"	INTEGER NOT NULL DEFAULT 0,
	"SavingThrowDexterityProficiency"	INTEGER NOT NULL DEFAULT 0,
	"SavingThrowConstitutionProficiency"	INTEGER NOT NULL DEFAULT 0,
	"SavingThrowIntelligenceProficiency"	INTEGER NOT NULL DEFAULT 0,
	"SavingThrowWisdomProficiency"	INTEGER NOT NULL DEFAULT 0,
	"SavingThrowCharismaProficiency"	INTEGER NOT NULL DEFAULT 0
);
DROP TABLE IF EXISTS "SkillProficiency";
CREATE TABLE IF NOT EXISTS "SkillProficiency" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Skill_ID"	INTEGER,
	FOREIGN KEY("Skill_ID") REFERENCES "Skill"("ID")
);
DROP TABLE IF EXISTS "Skill";
CREATE TABLE IF NOT EXISTS "Skill" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Name"	INTEGER,
	"Attribute"	INTEGER
);
DROP TABLE IF EXISTS "PersonOfInterest";
CREATE TABLE IF NOT EXISTS "PersonOfInterest" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Character_ID"	INTEGER NOT NULL,
	"Name"	TEXT,
	"Location"	TEXT,
	"Text"	TEXT,
	FOREIGN KEY("Character_ID") REFERENCES "Character"("ID")
);
DROP TABLE IF EXISTS "Item";
CREATE TABLE IF NOT EXISTS "Item" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Character_ID"	INTEGER NOT NULL,
	"Name"	TEXT,
	"Description"	TEXT,
	"Type"	TEXT,
	"QuickDescription"	TEXT,
	"Weight"	INTEGER,
	"Value"	TEXT,
	FOREIGN KEY("Character_ID") REFERENCES "Character"("ID")
);
DROP TABLE IF EXISTS "ViewState";
CREATE TABLE IF NOT EXISTS "ViewState" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Name"	TEXT,
	"Collapsed"	INTEGER NOT NULL DEFAULT 0
);
DROP TABLE IF EXISTS "Settings";
CREATE TABLE IF NOT EXISTS "Settings" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Name"	TEXT NOT NULL,
	"Value"	TEXT
);
DROP TABLE IF EXISTS "HitDie";
CREATE TABLE IF NOT EXISTS "HitDie" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Character_ID"	INTEGER NOT NULL,
	"Type"	TEXT,
	"Current"	INTEGER,
	"Max"	INTEGER,
	FOREIGN KEY("Character_ID") REFERENCES "Character"("ID")
);
DROP TABLE IF EXISTS "Note";
CREATE TABLE IF NOT EXISTS "Note" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Character_ID"	INTEGER NOT NULL,
	"Name"	TEXT,
	"Text"	TEXT,
	"SortOrder"	INTEGER NOT NULL UNIQUE,
	FOREIGN KEY("Character_ID") REFERENCES "Character"("ID")
);
DROP TABLE IF EXISTS "Backstory";
CREATE TABLE IF NOT EXISTS "Backstory" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Character_ID"	INTEGER NOT NULL,
	"Text"	TEXT,
	FOREIGN KEY("Character_ID") REFERENCES "Character"("ID")
);
DROP TABLE IF EXISTS "Language";
CREATE TABLE IF NOT EXISTS "Language" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Character_ID"	INTEGER NOT NULL,
	"Name"	TEXT,
	"Description"	TEXT,
	FOREIGN KEY("Character_ID") REFERENCES "Character"("ID")
);
DROP TABLE IF EXISTS "Proficiency";
CREATE TABLE IF NOT EXISTS "Proficiency" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Character_ID"	INTEGER NOT NULL,
	"Name"	TEXT,
	"Description"	TEXT,
	FOREIGN KEY("Character_ID") REFERENCES "Character"("ID")
);
DROP TABLE IF EXISTS "Flaw";
CREATE TABLE IF NOT EXISTS "Flaw" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Character_ID"	INTEGER NOT NULL,
	"Name"	TEXT,
	"Description"	TEXT,
	FOREIGN KEY("Character_ID") REFERENCES "Character"("ID")
);
DROP TABLE IF EXISTS "Bond";
CREATE TABLE IF NOT EXISTS "Bond" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Character_ID"	INTEGER NOT NULL,
	"Name"	TEXT,
	"Description"	TEXT,
	FOREIGN KEY("Character_ID") REFERENCES "Character"("ID")
);
DROP TABLE IF EXISTS "Ideal";
CREATE TABLE IF NOT EXISTS "Ideal" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Character_ID"	INTEGER NOT NULL,
	"Name"	TEXT,
	"Description"	TEXT,
	FOREIGN KEY("Character_ID") REFERENCES "Character"("ID")
);
DROP TABLE IF EXISTS "Trait";
CREATE TABLE IF NOT EXISTS "Trait" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Character_ID"	INTEGER NOT NULL,
	"Name"	TEXT,
	"Description"	TEXT,
	FOREIGN KEY("Character_ID") REFERENCES "Character"("ID")
);
DROP TABLE IF EXISTS "Spell";
CREATE TABLE IF NOT EXISTS "Spell" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Character_ID"	INTEGER NOT NULL,
	"Name"	TEXT,
	"Description"	TEXT,
	"School"	TEXT,
	"Range"	TEXT,
	"CastingTime"	TEXT,
	"Components"	TEXT,
	"Duration"	TEXT,
	"HigherLevel"	TEXT,
	FOREIGN KEY("Character_ID") REFERENCES "Character"("ID")
);
DROP TABLE IF EXISTS "Feat";
CREATE TABLE IF NOT EXISTS "Feat" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Character_ID"	INTEGER NOT NULL,
	"Name"	TEXT,
	"MaxUses"	INTEGER,
	"RemainingUses"	INTEGER,
	"Description"	TEXT,
	FOREIGN KEY("Character_ID") REFERENCES "Character"("ID")
);
DROP TABLE IF EXISTS "Class";
CREATE TABLE "Class" (
	"ID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Character_ID"	INTEGER NOT NULL,
	"Name"	TEXT,
	"Level"	INTEGER,
	FOREIGN KEY("Character_ID") REFERENCES "Character"("ID")
)
INSERT INTO "Skill" VALUES (1,'Acrobatics
','Dexterity'),
 (2,'Animal Handling','Wisdom'),
 (3,'Arcana','Intelligence'),
 (4,'Athletics','Strength'),
 (5,'Deception','Charisma'),
 (6,'Insight','Wisdom'),
 (7,'Intimidation','Charisma'),
 (8,'Investigation','Intelligence'),
 (9,'Medicine','Wisdom'),
 (10,'Nature','Intelligence'),
 (11,'Perception','Wisdom'),
 (12,'Performance','Charisma'),
 (13,'Persuasion','Charisma'),
 (14,'Religion','Intelligence'),
 (15,'Sleight of Hand','Dexterity'),
 (16,'Stealth','Dexterity'),
 (17,'Survival','Wisdom');
COMMIT;
