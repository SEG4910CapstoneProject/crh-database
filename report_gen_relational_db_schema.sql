-- CREATE tables

-- Open CTI sources will be : alien vault + bleeping computer, no need for a source_link
CREATE TABLE open_cti_sources (
	source_ID 		INT PRIMARY KEY,
	source_name     VARCHAR(100)
);

-- This table is to keep track of all updates the system did
CREATE TABLE versions (
	version_id      SERIAL PRIMARY KEY,
	time_update     TIMESTAMP WITH TIME ZONE
);


CREATE TABLE sources (
	source_ID 		SERIAL PRIMARY KEY,
	source_name     VARCHAR(100),
	source_link		VARCHAR(150),
	last_update     TIMESTAMP
);

CREATE TABLE articles (
	article_ID 		UUID PRIMARY KEY,
	source_ID 		INT NOT NULL,
	date_ingested 	DATE NOT NULL,
	date_published 	DATE,
	is_feature_ext	BOOLEAN DEFAULT false,
	is_ML_ext		BOOLEAN DEFAULT false,
	hashlink 		BIGINT,
	FOREIGN KEY (source_ID) REFERENCES open_cti_sources(source_ID)

);

CREATE TABLE related_links(
	rel_link_id   		SERIAL PRIMARY KEY,
	related_hash_link	BIGINT,
	source_ID			INT NOT NULL,
	FOREIGN KEY (source_ID) REFERENCES open_cti_sources(source_ID)	
);

CREATE TABLE articles_related_links (
	article_ID			UUID,
	rel_link_id			INT NOT NULL,
	PRIMARY KEY (article_ID, rel_link_id),
	FOREIGN KEY (article_ID) REFERENCES articles(article_ID),
	FOREIGN KEY (rel_link_id) REFERENCES related_links(rel_link_id)
);



CREATE TABLE labels(
	label_id 			SERIAL PRIMARY KEY,
	label_name			VARCHAR(200)
);

CREATE TABLE article_labels(
	article_id			UUID,
	label_id			int,
	Primary KEY (article_id,label_id),
	FOREIGN KEY (article_id) REFERENCES articles(article_ID),
	FOREIGN KEY (label_id)   REFERENCES labels(label_id)
);

CREATE TABLE statistics (
	statistic_ID 		UUID PRIMARY KEY,
	statistic_number    INT NOT NULL,
	title              VARCHAR(100) NOT NULL, 
	subtitle			VARCHAR(100)
);

-- IOC tables
CREATE TABLE ioc_types (
	ioc_type_ID		SMALLSERIAL PRIMARY KEY,
	name			VARCHAR(25) UNIQUE
);

CREATE TABLE iocs (
	ioc_ID			SERIAL PRIMARY KEY,
	ioc_type		SMALLINT,
	ioc_value		TEXT UNIQUE,
	FOREIGN KEY (ioc_type) REFERENCES ioc_types(ioc_type_ID)
);

CREATE TABLE ioc_articles (
	article_ID 		UUID,
	ioc_ID		INTEGER,
	PRIMARY KEY (article_ID, ioc_ID),
	FOREIGN KEY (article_ID) REFERENCES articles(article_ID),
	FOREIGN KEY (ioc_ID) REFERENCES iocs(ioc_ID)
);

-- Global Filters (Applies regardless of source)
CREATE TABLE ioc_filter_pattern (
	ioc_type_ID		SMALLINT,
	ioc_pattern		TEXT,
	PRIMARY KEY (ioc_type_ID, ioc_pattern),
	FOREIGN KEY (ioc_type_ID) REFERENCES ioc_types(ioc_type_ID)
);

-- Source Filters (Filters that only apply to certain sources)
CREATE TABLE ioc_source_filter_pattern (
	ioc_type_ID		SMALLINT,
	source_ID		INTEGER,
	ioc_pattern		TEXT,
	PRIMARY KEY (ioc_type_ID, source_ID, ioc_pattern),
	FOREIGN KEY (ioc_type_ID) REFERENCES ioc_types(ioc_type_ID),
	FOREIGN KEY (source_ID) REFERENCES sources(source_ID)
);

-- Add Required IOC Types
INSERT INTO ioc_types (name) VALUES 
	('URL'),
	('Domain Name'),
	('IPv4 Address'),
	('IPv6 Address'),
	('IPv4 subnet'),
	('MD5 Hash'),
	('SHA1 Hash'),
	('SHA256 Hash'),
	('Email Address'),
	('Phone Number'),
	('Copyright String'),
	('CVE Vulnerability Id'),
	('Onion Address'),
	('Facebook Handle'),
	('Github Handle'),
	('Instagram Handle'),
	('Linkedin Handle'),
	('Pinterest Handle'),
	('Telegram Handle'),
	('Twitter Handle'),
	('Whatsapp Handle'),
	('Youtube Handle'),
	('Youtube Channel'),
	('Google Adsense Id'),
	('Google Analytics Id'),
	('Google Tag Manager Id'),
	('Bitcoin Address'),
	('Bitcoincash Address'),
	('Cardano Address'),
	('Dashcoin Address'),
	('Dogecoin Address'),
	('Ethereum Address'),
	('Litecoin Address'),
	('Monero Address'),
	('Ripple Address'),
	('Tezos Address'),
	('Tronix Address'),
	('Zcash Address'),
	('Webmoney Address'),
	('Chinese ICP License'),
	('Bank Account Number'),
	('Trademark'),
	('UUID'),
	('Android Package Name'),
	('Spanish NIF Id'),
	('Registry'),
	('Filename'),
	('Filepath'),
	('SHA 512');

-- Generated Reports

CREATE TYPE ReportType AS ENUM (
	'notSpecified',
	'daily',
	'weekly',
	'monthly'
);

CREATE TYPE EmailTemplateType AS ENUM (
	'restricted',
	'nonRestricted'
);

CREATE TABLE report (
	report_id SERIAL PRIMARY KEY,
	generate_date TIMESTAMP,
	report_type ReportType,
	last_modified TIMESTAMP,
	email_status BOOLEAN DEFAULT false,
	report_pdf BYTEA,
	email_type EmailTemplateType NOT NULL
);

-- Report - other table relations

CREATE TABLE report_articles (
	report_id INTEGER,
	article_id UUID,
	article_rank SMALLINT,
	suggestion BOOLEAN NOT NULL,
	PRIMARY KEY (report_id, article_id),
	FOREIGN KEY (article_id) REFERENCES articles(article_id) ON DELETE CASCADE,
    FOREIGN KEY (report_id) REFERENCES report(report_id) ON DELETE CASCADE
);

CREATE TABLE report_statistics (
	report_id INTEGER,
	statistic_id UUID,
	suggestion BOOLEAN NOT NULL,
	PRIMARY KEY (report_id, statistic_id),
	FOREIGN KEY (report_id) REFERENCES report(report_id) ON DELETE CASCADE,
	FOREIGN KEY (statistic_id) REFERENCES statistics(statistic_ID)
);

-- Article categorization
CREATE TABLE category (
	category_id SERIAL PRIMARY KEY,
	category_name VARCHAR(25) UNIQUE
);

CREATE TABLE category_rule (
	category_rank INTEGER PRIMARY KEY,
	category_regex TEXT,
	category_id INTEGER,
    FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE
);

CREATE TABLE article_category (
	category_id SERIAL,
	article_id UUID,
	PRIMARY KEY (category_id, article_id),
    FOREIGN KEY (article_id) REFERENCES articles(article_id) ON DELETE CASCADE,
	FOREIGN KEY (category_id) REFERENCES category(category_id)
);

-- Article type

CREATE TABLE article_type (
    article_id UUID PRIMARY KEY,
    article_type VARCHAR(255),
    FOREIGN KEY (article_id) REFERENCES articles(article_id) ON DELETE CASCADE
);

-- Index 
CREATE INDEX index_articles_hashlink  
ON articles (hashlink);

CREATE INDEX index_iocs_ioc_type
ON iocs (ioc_type);

CREATE INDEX index_report_generate_date
ON report (generate_date);

CREATE INDEX index_ioc_source_filter_pattern_type
ON ioc_source_filter_pattern (source_ID);

-- Monthly_articles table
CREATE TABLE monthly_articles (
    id SERIAL PRIMARY KEY,
    article_id UUID NOT NULL REFERENCES articles(article_id) ON DELETE CASCADE,
    date_published DATE NOT NULL,
    view_count INT NOT NULL DEFAULT 0,
    is_article_of_note BOOLEAN NOT NULL DEFAULT FALSE,
	title TEXT
);

-- Table for users to login
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(50) NOT NULL CHECK (role IN ('admin', 'analyst', 'restricted_analyst', 'user')),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Table for per-user article favourites
CREATE TABLE user_favourites (
    user_id BIGINT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    article_id UUID NOT NULL REFERENCES articles(article_id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (user_id, article_id)
);


INSERT INTO users (email, password_hash, role)
VALUES
  ('admin@example.com', '$2a$12$qOJPeE2THKiy3GxAq1TQS.USq9VZO8MGIvJyldIvQpPO8gqP35VQi', 'admin'),
  ('analyst@example.com', '$2a$12$qOJPeE2THKiy3GxAq1TQS.USq9VZO8MGIvJyldIvQpPO8gqP35VQi', 'analyst'),
  ('restricted@example.com', '$2a$12$qOJPeE2THKiy3GxAq1TQS.USq9VZO8MGIvJyldIvQpPO8gqP35VQi', 'restricted_analyst'),
  ('user@example.com', '$2a$12$qOJPeE2THKiy3GxAq1TQS.USq9VZO8MGIvJyldIvQpPO8gqP35VQi', 'user');


CREATE INDEX idx_monthly_articles_date ON monthly_articles(date_published);

CREATE INDEX idx_article_of_note ON monthly_articles(is_article_of_note);
