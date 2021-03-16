CREATE TABLE instrument (
 id SERIAL NOT NULL,
 type VARCHAR(50),
 brand VARCHAR(80),
 monthly_price INT,
 stock INT
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);


CREATE TABLE school (
 id SERIAL NOT NULL,
 name VARCHAR(300) NOT NULL
);

ALTER TABLE school ADD CONSTRAINT PK_school PRIMARY KEY (id);


CREATE TABLE person (
 id SERIAL NOT NULL,
 first_name VARCHAR(100),
 last_name VARCHAR(100),
 person_number VARCHAR(10) UNIQUE,
 school_id INT
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (id);


CREATE TABLE pricing_scheme (
 school_id INT NOT NULL,
 beginner_price INT,
 intermediate_price INT,
 advanced_price INT,
 weekend_price INT,
 individual_price INT,
 group_price INT,
 ensemble_price INT,
 sibling_discount FLOAT(2)
);

ALTER TABLE pricing_scheme ADD CONSTRAINT PK_pricing_scheme PRIMARY KEY (school_id);


CREATE TABLE salary_scheme (
 school_id INT NOT NULL,
 beginner_salary INT,
 intermediate_salary INT,
 advanced_salary INT,
 weekend_salary INT,
 individual_salary INT,
 group_salary INT,
 ensemble_salary INT
);

ALTER TABLE salary_scheme ADD CONSTRAINT PK_salary_scheme PRIMARY KEY (school_id);


CREATE TABLE student (
 id SERIAL NOT NULL,
 person_id INT NOT NULL,
 fee INT,
 instrument_quota INT
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE contact_details (
 person_id INT NOT NULL,
 email VARCHAR(60) UNIQUE NOT NULL
);

ALTER TABLE contact_details ADD CONSTRAINT PK_contact_details PRIMARY KEY (person_id);


CREATE TABLE instructor (
 id SERIAL NOT NULL,
 monthly_payment INT,
 person_id INT NOT NULL,
 salary INT
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE instructs_for (
 instructor_id INT NOT NULL,
 instrument VARCHAR(50) NOT NULL
);

ALTER TABLE instructs_for ADD CONSTRAINT PK_instructs_for PRIMARY KEY (instructor_id,instrument);


CREATE TABLE parent (
 id SERIAL NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE parent ADD CONSTRAINT PK_parent PRIMARY KEY (id);


CREATE TABLE phone_num (
 phone_num VARCHAR(19) UNIQUE NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE phone_num ADD CONSTRAINT PK_phone_num PRIMARY KEY (phone_num,person_id);


CREATE TABLE rentals (
 student_id INT NOT NULL,
 instrument_id INT NOT NULL,
 rental_date TIMESTAMP(10) NOT NULL,
 rental_end TIMESTAMP(10)
);

ALTER TABLE rentals ADD CONSTRAINT PK_rentals PRIMARY KEY (student_id,instrument_id,rental_date);


CREATE TABLE siblings (
 student_id INT NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE siblings ADD CONSTRAINT PK_siblings PRIMARY KEY (student_id);


CREATE TABLE student_parent (
 student_id INT NOT NULL,
 parent_id INT NOT NULL
);

ALTER TABLE student_parent ADD CONSTRAINT PK_student_parent PRIMARY KEY (student_id,parent_id);


CREATE TABLE address (
 id SERIAL NOT NULL,
 street VARCHAR(100),
 city VARCHAR(100),
 zipcode VARCHAR(5),
 contact_details_id INT,
 school_id INT
);

ALTER TABLE address ADD CONSTRAINT PK_address PRIMARY KEY (id);


CREATE TABLE ensemble (
 id SERIAL NOT NULL,
 instructor_id INT NOT NULL,
 date TIMESTAMP(10),
 genre VARCHAR(30) NOT NULL,
 skill VARCHAR(15) NOT NULL,
 min_num_students INT,
 max_num_students INT,
 students_participating INT
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (id);


CREATE TABLE group_lesson (
 id SERIAL NOT NULL,
 instructor_id INT NOT NULL,
 date TIMESTAMP(10),
 instrument VARCHAR(50) NOT NULL,
 skill VARCHAR(15) NOT NULL,
 max_num_students INT,
 min_num_students INT,
 students_participating INT
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (id);


CREATE TABLE application (
 id SERIAL NOT NULL,
 accepted BOOLEAN,
 keep_application BOOLEAN NOT NULL,
 student_id INT NOT NULL,
 is_individual BOOLEAN NOT NULL,
 instrument VARCHAR(50),
 genre VARCHAR(30),
 skill VARCHAR(15) NOT NULL,
 parent_id INT NOT NULL,
 group_lesson_id INT,
 ensemble_id INT
);

ALTER TABLE application ADD CONSTRAINT PK_application PRIMARY KEY (id);


CREATE TABLE audition (
 application_id INT NOT NULL,
 date TIMESTAMP(10) NOT NULL,
 passed BOOLEAN
);

ALTER TABLE audition ADD CONSTRAINT PK_audition PRIMARY KEY (application_id,date);


CREATE TABLE individual_lesson (
 application_id INT NOT NULL,
 instructor_id INT NOT NULL,
 date TIMESTAMP(10)
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (application_id);


ALTER TABLE person ADD CONSTRAINT FK_person_0 FOREIGN KEY (school_id) REFERENCES school (id);


ALTER TABLE pricing_scheme ADD CONSTRAINT FK_pricing_scheme_0 FOREIGN KEY (school_id) REFERENCES school (id) ON DELETE CASCADE;


ALTER TABLE salary_scheme ADD CONSTRAINT FK_salary_scheme_0 FOREIGN KEY (school_id) REFERENCES school (id) ON DELETE CASCADE;


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE;


ALTER TABLE contact_details ADD CONSTRAINT FK_contact_details_0 FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE;


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE;


ALTER TABLE instructs_for ADD CONSTRAINT FK_instructs_for_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE CASCADE;


ALTER TABLE parent ADD CONSTRAINT FK_parent_0 FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE;


ALTER TABLE phone_num ADD CONSTRAINT FK_phone_num_0 FOREIGN KEY (person_id) REFERENCES contact_details (person_id) ON DELETE CASCADE;


ALTER TABLE rentals ADD CONSTRAINT FK_rentals_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;
ALTER TABLE rentals ADD CONSTRAINT FK_rentals_1 FOREIGN KEY (instrument_id) REFERENCES instrument (id);


ALTER TABLE siblings ADD CONSTRAINT FK_siblings_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;
ALTER TABLE siblings ADD CONSTRAINT FK_siblings_1 FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE;


ALTER TABLE student_parent ADD CONSTRAINT FK_student_parent_0 FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;
ALTER TABLE student_parent ADD CONSTRAINT FK_student_parent_1 FOREIGN KEY (parent_id) REFERENCES parent (id) ON DELETE CASCADE;


ALTER TABLE address ADD CONSTRAINT FK_address_0 FOREIGN KEY (contact_details_id) REFERENCES contact_details (person_id);
ALTER TABLE address ADD CONSTRAINT FK_address_1 FOREIGN KEY (school_id) REFERENCES school (id);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE application ADD CONSTRAINT FK_application_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE application ADD CONSTRAINT FK_application_1 FOREIGN KEY (parent_id) REFERENCES parent (id);
ALTER TABLE application ADD CONSTRAINT FK_application_2 FOREIGN KEY (group_lesson_id) REFERENCES group_lesson (id);
ALTER TABLE application ADD CONSTRAINT FK_application_3 FOREIGN KEY (ensemble_id) REFERENCES ensemble (id);


ALTER TABLE audition ADD CONSTRAINT FK_audition_0 FOREIGN KEY (application_id) REFERENCES application (id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (application_id) REFERENCES application (id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


