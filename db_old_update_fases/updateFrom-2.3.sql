BEGIN TRANSACTION;
CREATE TEMPORARY TABLE `receipts_temp` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`receipt_type_id`	INTEGER NOT NULL,
	`payment_type_id`	INTEGER NOT NULL,
	`partner_id`	INTEGER NOT NULL,
	`receipt_date`	TEXT NOT NULL,
	`receipt_period_start`	TEXT,
	`receipt_period_end`	TEXT,
	`amount`	NUMERIC NOT NULL DEFAULT 0,
	`currency`	TEXT NOT NULL DEFAULT 'ARS',
	`notes`	TEXT,
	`entity_id`	INTEGER NOT NULL,
	`base_user_id`	INTEGER NOT NULL,
	`printed`	TEXT
);

INSERT INTO receipts_temp SELECT
	id,
	receipt_type_id,
	payment_type_id,
	partner_id,
	receipt_date,
	receipt_period_start,
	receipt_period_end,
	amount,
	currency,
	notes,
	entity_id,
	base_user_id,
	printed
FROM
	receipts;

DROP TABLE receipts;


CREATE TABLE IF NOT EXISTS `receipts` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`receipt_type_id`	INTEGER NOT NULL,
	`payment_type_id`	INTEGER NOT NULL,
	`partner_id`	INTEGER NOT NULL,
	`receipt_date`	TEXT NOT NULL,
	`receipt_period_start`	TEXT,
	`receipt_period_end`	TEXT,
	`amount`	NUMERIC NOT NULL DEFAULT 0,
	`currency`	TEXT NOT NULL DEFAULT 'ARS',
	`notes`	TEXT,
	`entity_id`	INTEGER NOT NULL,
	`base_user_id`	INTEGER NOT NULL,
	`printed`	TEXT,
	`receipt_number` TEXT,
	FOREIGN KEY(`entity_id`) REFERENCES `entities`(`id`),
	FOREIGN KEY(`receipt_type_id`) REFERENCES `receipt_types`(`id`),
	FOREIGN KEY(`base_user_id`) REFERENCES `base_users`(`id`)
)
;
INSERT INTO receipts  SELECT
	id,
	receipt_type_id,
	payment_type_id,
	partner_id,
	receipt_date,
	receipt_period_start,
	receipt_period_end,
	amount,
	currency,
	notes,
	entity_id,
	base_user_id,
	printed,
	null
FROM
	receipts_temp;



DROP VIEW receipts_all;

CREATE VIEW receipts_all (
    id,
    receipt_type_id,
    payment_type_id,
    partner_id,
    receipt_date,
    receipt_period_start,
    receipt_period_end,
    amount,
    currency,
    notes,
    entity_id,
    base_user_id,
    printed,
    name,
    name_2,
    name_3,
    attribute_1,
    attribute_3,
    attribute_4,
    attribute_5,
    attribute_2,
    type_description,
    type_code,
    payment_description,
    payment_code,
    receipt_description,
    receipt_code,
    receipt_number,
    course_id,
    course_name,
    course_name_2,
    course_name_3,
    course_attribute_1,
    course_attribute_2,
    course_attribute_3,
    course_attribute_4,
    course_attribute_5,
    course_type_description,
    course_type_code,
    family_id,
    family_name,
    family_name_2,
    family_name_3,
    family_attribute_1,
    family_attribute_2,
    family_attribute_3,
    family_attribute_4,
    family_attribute_5,
    family_type_description,
    family_type_code
)
AS
      SELECT r.id,
           r.receipt_type_id,
           r.payment_type_id,
           r.partner_id,
           r.receipt_date,
           r.receipt_period_start,
           r.receipt_period_end,
           r.amount,
           r.currency,
           r.notes,
           r.entity_id,
           r.base_user_id,
           r.printed,
           IFNULL(s.name, d.name) AS name,
           IFNULL(s.name_2, d.name_2) AS name_2,
           IFNULL(s.name_3, d.name_3) AS name_3,
           IFNULL(s.attribute_1, d.attribute_1) AS attribute_1,
           IFNULL(s.attribute_2, d.attribute_2) AS attribute_2,
           IFNULL(s.attribute_1, d.attribute_3) AS attribute_3,
           IFNULL(s.attribute_4, d.attribute_4) AS attribute_4,
           IFNULL(s.attribute_5, d.attribute_5) AS attribute_5,
           IFNULL(s.type_description, d.type_description) AS type_description,
           IFNULL(s.type_code, d.type_code) AS type_code,
           pt.payment_description,
           pt.payment_code,
           rt.receipt_description,
           rt.receipt_code,
           r.receipt_number,
           s.course_id,
           s.course_name,
           s.course_name_2,
           s.course_name_3,
           s.course_attribute_1,
           s.course_attribute_2,
           s.course_attribute_3,
           s.course_attribute_4,
           s.course_attribute_5,
           s.course_type_description,
           s.course_type_code,
           s.family_id,
           s.family_name,
           s.family_name_2,
           s.family_name_3,
           s.family_attribute_1,
           s.family_attribute_2,
           s.family_attribute_3,
           s.family_attribute_4,
           s.family_attribute_5,
           s.family_type_description,
           s.family_type_code
      FROM receipts r
           INNER JOIN receipt_types rt ON r.receipt_type_id = rt.id
           INNER JOIN payment_types pt ON r.payment_type_id = pt.id
           LEFT JOIN students s ON s.id = r.partner_id AND s.entity_id = r.entity_id
           LEFT JOIN donators d ON d.id = r.partner_id;

COMMIT;
