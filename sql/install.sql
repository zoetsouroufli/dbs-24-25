DROP DATABASE IF EXISTS festivals;
CREATE DATABASE festivals;
USE festivals;

SET GLOBAL event_scheduler = ON;

CREATE TABLE continent (
        continent_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE location (
    location_id INT(50) NOT NULL AUTO_INCREMENT,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
	city VARCHAR(50) NOT NULL,
	country VARCHAR(50) NOT NULL,
    postal_code INT NOT NULL,
    street_number INT NOT NULL,
    street_name VARCHAR(50) NOT NULL,
    continent_id INT NOT NULL,
    UNIQUE (latitude,longitude), /*etsi diasfalizw de tha exoume 2 idies topothesies*/
    PRIMARY KEY (location_id),
    FOREIGN KEY (continent_id) REFERENCES continent (continent_id)
    );
    
CREATE TABLE festival(
    festival_id int(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    start date NOT NULL,
    end date NOT NULL,
    location_id INT (50) NOT NULL , /* total participation me topothesia, me to unique diasfalizw oti allo festival den mporei na ginei sthn idia topothesia*/
    image_url VARCHAR(255) CHECK (image_url IS NULL OR image_url LIKE 'https://%'),
    image_description VARCHAR(255),
    PRIMARY KEY (festival_id),
    FOREIGN KEY (location_id) REFERENCES location (location_id)
    );
   
CREATE TABLE stage (
        stage_id INT NOT NULL AUTO_INCREMENT,
        stage_name VARCHAR(50) NOT NULL UNIQUE,
        stage_description VARCHAR (50) NOT NULL,
        capacity INT NOT NULL,
        image_url VARCHAR(255) CHECK (image_url IS NULL OR image_url LIKE 'https://%'),
		image_description VARCHAR(255),
        PRIMARY KEY (stage_id)
    );
    
    CREATE TABLE event (
        event_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
        event_name VARCHAR(50) NOT NULL UNIQUE,
        event_date date NOT NULL,
        start_time time NOT NULL,
        end_time time NOT NULL,
        festival_id INT NOT NULL,  
        stage_id INT NOT NULL , 
        image_url VARCHAR(255) CHECK (image_url IS NULL OR image_url LIKE 'https://%'),
        image_description VARCHAR(255),
        PRIMARY KEY (event_id),
        FOREIGN KEY (festival_id) REFERENCES festival(festival_id), 
        FOREIGN KEY (stage_id) REFERENCES stage (stage_id) 
    );

CREATE TABLE equipment (
  equipment_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL UNIQUE,
  image_url VARCHAR(255) CHECK (image_url IS NULL OR image_url LIKE 'https://%'),
  image_description VARCHAR(255),
  PRIMARY KEY (equipment_id)
);

CREATE TABLE stage_equipment (
  stage_id INT NOT NULL,
  equipment_id INT NOT NULL,
  PRIMARY KEY (stage_id, equipment_id),
  FOREIGN KEY (stage_id) REFERENCES stage(stage_id),
  FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);

CREATE TABLE role (
    role_id INT NOT NULL AUTO_INCREMENT,
    role VARCHAR (50) NOT NULL UNIQUE,	
    PRIMARY KEY (role_id)
);

CREATE TABLE experience (
    experience_id INT NOT NULL AUTO_INCREMENT,
    experience VARCHAR (50) NOT NULL UNIQUE,
    PRIMARY KEY (experience_id)
);

CREATE TABLE personel (
    personel_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age VARCHAR(50) NOT NULL,
    experience_id INT NOT NULL,
    role_id INT NOT NULL,
    UNIQUE(name, last_name, age),
    PRIMARY KEY (personel_id),
    FOREIGN KEY (experience_id) REFERENCES experience(experience_id),
    FOREIGN KEY (role_id) REFERENCES role (role_id)
);

CREATE TABLE stage_personel ( 
  stage_id INT NOT NULL,
  personel_id INT NOT NULL,
  PRIMARY KEY (stage_id, personel_id),
  FOREIGN KEY (stage_id) REFERENCES stage(stage_id),
  FOREIGN KEY (personel_id) REFERENCES personel(personel_id)
);

CREATE TABLE performance_kind(
    performance_kind_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    kind VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (performance_kind_id)
);

CREATE TABLE band(
    band_id INT AUTO_INCREMENT,
    band_name VARCHAR(50) NOT NULL,
    band_date_creation date NOT NULL,
    band_website VARCHAR(255),
    image_url VARCHAR(255) CHECK (image_url IS NULL OR image_url LIKE 'https://%'),
    image_description VARCHAR(255),
    UNIQUE(band_name, band_date_creation),
	PRIMARY KEY(band_id)
);

CREATE TABLE performance(
    performance_id INT AUTO_INCREMENT,
    performance_name VARCHAR(50) NOT NULL,
    performance_date date NOT NULL,
    performance_start_time time NOT NULL,
    performance_end_time time NOT NULL CHECK(performance_end_time>performance_start_time),
    performance_duration int(11) NOT NULL,
    event_id INT UNSIGNED NOT NULL,   
    performance_kind_id INT UNSIGNED NOT NULL CHECK(performance_kind_id BETWEEN 1 AND 7), 
    band_id INT NULL,
    stage_id INT ,
    image_url VARCHAR(255) CHECK (image_url IS NULL OR image_url LIKE 'https://%'),
    image_description VARCHAR(255),
    PRIMARY KEY (performance_id),    
    FOREIGN KEY (event_id) REFERENCES event(event_id), 
    FOREIGN KEY (performance_kind_id) REFERENCES performance_kind(performance_kind_id),
    FOREIGN KEY (band_id) REFERENCES band(band_id),
    FOREIGN KEY (stage_id) REFERENCES event(stage_id)
);

CREATE TABLE artist(
    artist_id INT AUTO_INCREMENT,
    artist_name VARCHAR(50) NOT NULL,   
    artist_surname VARCHAR(50) NOT NULL,
    artist_pseudonym VARCHAR(50),
    artist_birthdate date NOT NULL,
    artist_website VARCHAR(255),
    artist_insta VARCHAR(50),
    image_url VARCHAR(255) CHECK (image_url IS NULL OR image_url LIKE 'https://%'),
    image_description VARCHAR(255),
	UNIQUE(artist_name, artist_surname, artist_birthdate),
    PRIMARY KEY (artist_id)
);

CREATE TABLE performance_artist(
    performance_id INT NOT NULL,
    artist_id INT NOT NULL,
    PRIMARY KEY (performance_id,artist_id),
    FOREIGN KEY (performance_id) REFERENCES performance(performance_id),
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);

CREATE TABLE artist_band(
    artist_id INT NOT NULL,
    band_id INT NOT NULL,
    PRIMARY KEY (artist_id, band_id),
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
    FOREIGN KEY (band_id) REFERENCES band(band_id)
);

CREATE TABLE music_genre(
  music_genre_id INT auto_increment,
  music_genre VARCHAR(50) NOT NULL UNIQUE,
  image_url VARCHAR(255) CHECK (image_url IS NULL OR image_url LIKE 'https://%'),
  image_description VARCHAR(255),
  PRIMARY KEY (music_genre_id)
);

CREATE TABLE music_subgenre(
    music_subgenre_id INT AUTO_INCREMENT,
    music_subgenre VARCHAR(50) NOT NULL UNIQUE,
    image_url VARCHAR(255) CHECK (image_url IS NULL OR image_url LIKE 'https://%'),
    image_description VARCHAR(255),
    PRIMARY KEY (music_subgenre_id)
    
);

CREATE TABLE artist_genre(
    artist_id INT NOT NULL,
    music_genre_id INT NOT NULL,
    PRIMARY KEY (artist_id,music_genre_id),
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
    FOREIGN KEY (music_genre_id) REFERENCES music_genre(music_genre_id)
);

CREATE TABLE artist_subgenre(
    artist_id INT NOT NULL,
    music_subgenre_id INT NOT NULL,
    PRIMARY KEY (artist_id,music_subgenre_id),
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
    FOREIGN KEY (music_subgenre_id) REFERENCES music_subgenre(music_subgenre_id)
);

CREATE TABLE band_genre(
    band_id INT NOT NULL,
    music_genre_id INT NOT NULL,
    PRIMARY KEY (band_id,music_genre_id),
    FOREIGN KEY (band_id) REFERENCES band(band_id),
    FOREIGN KEY (music_genre_id) REFERENCES music_genre(music_genre_id)
);

CREATE TABLE band_subgenre(
    band_id INT NOT NULL,
    music_subgenre_id INT NOT NULL,
    PRIMARY KEY (band_id,music_subgenre_id),
    FOREIGN KEY (band_id) REFERENCES band(band_id),
    FOREIGN KEY (music_subgenre_id) REFERENCES music_subgenre(music_subgenre_id)
);


CREATE TABLE ticket_category (
  id_ticket_category TINYINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  category_name VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (id_ticket_category)
);


CREATE TABLE payment_method (
  id_payment_method TINYINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  method_name VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (id_payment_method)
);

CREATE TABLE visitor (
  id_visitor INT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  phone CHAR(10) NOT NULL,
  email VARCHAR(50),
  age INT,
  PRIMARY KEY (id_visitor),
  CHECK (LENGTH(phone) = 10),
  UNIQUE (first_name, last_name, phone)
);

CREATE TABLE ticket (
  code_ean13 bigint NOT NULL CHECK (code_ean13 BETWEEN 1000000000000 AND 9999999999999),
  purchase_date DATE NOT NULL,
  purchase_time TIME NOT NULL,
  for_sale TINYINT(1) NOT NULL DEFAULT 0 CHECK(for_sale BETWEEN 0 AND 1),
  activated TINYINT(1) NOT NULL DEFAULT 0  CHECK(activated BETWEEN 0 AND 1),
  cost DECIMAL(5,2) NOT NULL,
  id_ticket_category TINYINT(1) UNSIGNED NOT NULL CHECK(id_ticket_category BETWEEN 1 AND 3),
  id_payment_method TINYINT(1) UNSIGNED NOT NULL CHECK(id_payment_method BETWEEN 1 AND 4),
  event_id INT UNSIGNED NOT NULL,
  id_visitor INT UNSIGNED NOT NULL,
  CHECK (LENGTH(code_ean13) = 13),
  UNIQUE (id_visitor, event_id),
  PRIMARY KEY (code_ean13),
  FOREIGN KEY (id_ticket_category) REFERENCES ticket_category(id_ticket_category),
  FOREIGN KEY (id_payment_method) REFERENCES payment_method(id_payment_method),
  FOREIGN KEY (event_id) REFERENCES event(event_id),
  FOREIGN KEY (id_visitor) REFERENCES visitor(id_visitor)
);

CREATE TABLE buyer(
    buyer_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone CHAR(10) NOT NULL,
    email VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (buyer_id),
	CHECK (LENGTH(phone) = 10),
    UNIQUE (name, last_name, phone)
);

CREATE TABLE resell_queue (
    resell_queue_id INT NOT NULL AUTO_INCREMENT,
    code_ean13 bigint NOT NULL CHECK (code_ean13 BETWEEN 1000000000000 AND 9999999999999),
    timestamp DATETIME NOT NULL DEFAULT NOW(),
    PRIMARY KEY (resell_queue_id),
    foreign key (code_ean13) References ticket(code_ean13)
);

CREATE TABLE buyer_queue (
    buyer_queue_id INT NOT NULL AUTO_INCREMENT,
    event_id  INT UNSIGNED,
    id_ticket_category TINYINT(1) UNSIGNED,
    code_ean13 bigint CHECK (code_ean13 BETWEEN 1000000000000 AND 9999999999999),
    timestamp DATETIME NOT NULL DEFAULT NOW(),
    buyer_id INT NOT NULL,
	CHECK (LENGTH(code_ean13) = 13),
    PRIMARY KEY (buyer_queue_id),
    UNIQUE(buyer_id, event_id),
    UNIQUE(buyer_id, code_ean13),
    Foreign key (event_id) references event(event_id),
    foreign key (id_ticket_category) references ticket_category(id_ticket_category),
    foreign key (buyer_id) references buyer(buyer_id)
    -- foreign key (code_ean13) references resell_queue(code_ean13)
);

CREATE TABLE Likert (
  id_likert TINYINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  likert_category VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (id_likert)
);

CREATE TABLE evaluation (
  artist_performance_rating TINYINT(1) UNSIGNED NOT NULL CHECK(artist_performance_rating BETWEEN 1 AND 5),
  sound_and_light_rating TINYINT(1) UNSIGNED  NOT NULL CHECK(sound_and_light_rating BETWEEN 1 AND 5),
  stage_presentation_rating TINYINT(1) UNSIGNED NOT NULL CHECK(stage_presentation_rating BETWEEN 1 AND 5),
  organization_rating TINYINT(1) UNSIGNED NOT NULL CHECK(organization_rating  BETWEEN 1 AND 5),
  overall_impression_rating TINYINT(1) UNSIGNED NOT NULL CHECK(overall_impression_rating  BETWEEN 1 AND 5),
  id_visitor INT UNSIGNED NOT NULL,
  performance_id INT NOT NULL,
  PRIMARY KEY (id_visitor, performance_id),
  FOREIGN KEY (id_visitor) REFERENCES visitor(id_visitor),
  FOREIGN KEY (performance_id) REFERENCES performance(performance_id)
);

CREATE TABLE match_pending (
  id INT PRIMARY KEY DEFAULT 1,
  is_pending tinyint(1) NOT NULL DEFAULT FALSE,
  last_checked DATETIME DEFAULT NULL
);

INSERT INTO match_pending (id, is_pending) VALUES (1, FALSE);

USE festivals;
DELIMITER ;
    
DELIMITER //
CREATE TRIGGER check_event_overlap
BEFORE INSERT ON event
FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT 1 FROM event
    WHERE stage_id = NEW.stage_id
      AND event_date = NEW.event_date
      AND (
        (NEW.start_time BETWEEN start_time AND end_time)
        OR
        (NEW.end_time BETWEEN start_time AND end_time)
        OR
        (start_time BETWEEN NEW.start_time AND NEW.end_time)
        OR
      (end_time BETWEEN NEW.start_time AND NEW.end_time)
      )
  ) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: Time slot overlaps with existing event on this stage.' ;
  END IF;
END;
//
DELIMITER ;

DELIMITER //
	CREATE TRIGGER prevent_event_delete
BEFORE DELETE ON event
FOR EACH ROW
BEGIN
  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = 'Δεν επιτρέπεται η διαγραφή παράστασης.';
END;
//

CREATE PROCEDURE check_stage_personel(IN p_stage_id INT)
BEGIN
  DECLARE security_count INT DEFAULT 0;
  DECLARE helper_count INT DEFAULT 0;
  DECLARE stage_capacity INT DEFAULT 0;
  DECLARE stage_name2 VARCHAR(50);
  DECLARE err_msg TEXT;


  -- Προσωπικό ασφαλείας (role_id = 3)
  SELECT COUNT(*) INTO security_count
  FROM stage_personel sp
  JOIN personel p ON sp.personel_id = p.personel_id
  WHERE sp.stage_id = p_stage_id AND p.role_id = 3;

  -- Βοηθητικό προσωπικό (role_id = 2)
  SELECT COUNT(*) INTO helper_count
  FROM stage_personel sp
  JOIN personel p ON sp.personel_id = p.personel_id
  WHERE sp.stage_id = p_stage_id AND p.role_id = 2;

  -- Χωρητικότητα σκηνής + όνομα
  SELECT capacity, stage_name
  INTO stage_capacity, stage_name2
  FROM stage
  WHERE stage_id = p_stage_id;

  -- Έλεγχος για προσωπικό ασφαλείας
  IF security_count < stage_capacity * 0.05 THEN
    SET err_msg = CONCAT('Stage "', stage_name2, '" has insufficient security staff (needs ≥5%)');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = err_msg;
  END IF;

  -- Έλεγχος για βοηθητικό προσωπικό
  IF helper_count < stage_capacity * 0.02 THEN
    SET err_msg = CONCAT('Stage "', stage_name2, '" has insufficient helper staff (needs ≥2%)');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = err_msg;
  END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER prevent_festival_delete
BEFORE DELETE ON festival
FOR EACH ROW
BEGIN
  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = 'Δεν επιτρέπεται η διαγραφή φεστιβάλ.';
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE check_all_stages()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE sid INT;
  DECLARE cur CURSOR FOR SELECT stage_id FROM stage;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur;

  stage_loop: LOOP
    FETCH cur INTO sid;
    IF done THEN
      LEAVE stage_loop;
    END IF;
    CALL check_stage_personel(sid);
  END LOOP;

  CLOSE cur;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE check_festival_total_participation()
BEGIN
  DECLARE missing_festival_id INT;
  DECLARE err_msg TEXT;

  SELECT f.festival_id INTO missing_festival_id
  FROM festival f
  WHERE NOT EXISTS (
    SELECT 1
    FROM event e
    WHERE e.festival_id = f.festival_id
  )
  ORDER BY f.festival_id
  LIMIT 1;

  IF missing_festival_id IS NOT NULL THEN
    SET err_msg = CONCAT('Festival ', missing_festival_id, ' has no events assigned.');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = err_msg;
  END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE stage_total_participation_in_technical_equipment()
BEGIN
    DECLARE missing_stage_id INT;
	DECLARE err_msg TEXT;
    SELECT s.stage_id INTO missing_stage_id
    FROM stage s
    WHERE NOT EXISTS (
        SELECT 1
        FROM stage_equipment se
        WHERE se.stage_id = s.stage_id
    )
    ORDER BY stage_id
    LIMIT 1;

    IF missing_stage_id IS NOT NULL THEN
        SET err_msg = CONCAT('Stage ', missing_stage_id, ' has no Technical Equipment.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT=err_msg;
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE check_stage_role_coverage()
BEGIN
  DECLARE missing_stage_id INT DEFAULT NULL;
  DECLARE missing_role_id INT DEFAULT NULL;
  DECLARE role_name VARCHAR(50) DEFAULT NULL;
  DECLARE err_msg TEXT;

  -- Προσπάθεια να φορτωθεί ένα μόνο κενό
  SELECT s.stage_id, r.role_id, r.role
  INTO missing_stage_id, missing_role_id, role_name
  FROM stage s
  CROSS JOIN role r
  WHERE NOT EXISTS (
    SELECT 1
    FROM stage_personel sp
    JOIN personel p ON sp.personel_id = p.personel_id
    WHERE sp.stage_id = s.stage_id AND p.role_id = r.role_id
  )
  ORDER BY s.stage_id, r.role_id
  LIMIT 1;

  -- Εδώ γίνεται η απλή IF
  IF missing_stage_id IS NOT NULL THEN
    SET err_msg = CONCAT('Stage ', missing_stage_id, ' is missing role "', role_name, '" (role_id=', missing_role_id, ')');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = err_msg;
  END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_event_within_festival
BEFORE INSERT ON event
FOR EACH ROW
BEGIN
  DECLARE fest_start DATE;
  DECLARE fest_end DATE;
   DECLARE err_msg TEXT;

  -- Παίρνουμε τις ημερομηνίες του festival
  SELECT start, end
  INTO fest_start, fest_end
  FROM festival
  WHERE festival_id = NEW.festival_id;

  -- Έλεγχος: η ημερομηνία του event πρέπει να είναι εντός των ορίων
  IF NEW.event_date < fest_start OR NEW.event_date > fest_end THEN
  SET err_msg=CONCAT(
      'Event must be within festival period: ',
      DATE_FORMAT(fest_start, '%Y-%m-%d'),
      ' to ',
      DATE_FORMAT(fest_end, '%Y-%m-%d')
    );
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = err_msg;
  END IF;
END;
//
DELIMITER ;

DELIMITER //
-- αυτό είναι ώστε κάθε performance που γίνεται την ίδια ώρα να μην πραγματοποιειίται στην ίδια σκηνή 
CREATE TRIGGER check_performance_stage_overlap
BEFORE INSERT ON performance
FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT 1 FROM performance
    WHERE stage_id = NEW.stage_id
      AND performance_date = NEW.performance_date
      AND (
        (NEW.performance_start_time BETWEEN performance_start_time AND performance_end_time)
        OR
        (NEW.performance_end_time BETWEEN performance_start_time AND performance_end_time)
        OR
        (performance_start_time BETWEEN NEW.performance_start_time AND NEW.performance_end_time)
        OR
      (performance_end_time BETWEEN NEW.performance_start_time AND NEW.performance_end_time)
      )
  ) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: Time slot overlaps with existing performance on this stage.' ;
  END IF;
END;
//
DELIMITER ;

-- εδώ θέλω νσ ελέγχω αν έχει υπάρξει η σωστή πρόβλεψη για διάλειμμα ανάμεσα σε διαδοχικές παραστάσεις στην ίδια σκηνή
DELIMITER //
CREATE TRIGGER check_performance_break
BEFORE INSERT ON performance
FOR EACH ROW
BEGIN
  DECLARE end_time_of_previous TIME;
  DECLARE break_duration INT;
  DECLARE err_msg TEXT;

  SELECT performance_end_time INTO end_time_of_previous FROM performance
  WHERE stage_id = NEW.stage_id
    AND performance_date = NEW.performance_date
    AND performance_end_time <= NEW.performance_start_time
  ORDER BY performance_end_time DESC
  LIMIT 1; 

  IF end_time_of_previous IS NOT NULL THEN
	SET break_duration = (NEW.performance_start_time - end_time_of_previous)/100;
    
    IF break_duration < 5 OR break_duration > 30 THEN
        SET err_msg = CONCAT('break between performances is"', break_duration, '" so it is not allowed');
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = err_msg;     
    END IF;
  END IF;
END;
//
DELIMITER ;

-- μέγιστη διάρκεια παράστασης όχι πάνω από 3 ώρες
DELIMITER //
CREATE TRIGGER check_max_duration_performance
BEFORE INSERT ON performance
FOR EACH ROW
BEGIN
  IF NEW.performance_duration > 180 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Performance duration cannot exceed 3 hours';
  END IF;
END//
DELIMITER ;

CREATE OR REPLACE VIEW list_band_members AS
	SELECT 
		b.band_name,
		GROUP_CONCAT(CONCAT(a.artist_name, ' ', a.artist_surname) SEPARATOR ', ')
	FROM 
		band b
	JOIN artist_band ab ON b.band_id = ab.band_id
	JOIN artist a ON a.artist_id = ab.artist_id
	GROUP BY b.band_id, b.band_name;

DELIMITER //

-- αυτός ο καλλιτέχνης (καλύπτεται και το συγκρότημα) είναι ήδη booked τότε 
DELIMITER //
CREATE TRIGGER check_artist_overlap
BEFORE INSERT ON performance_artist
FOR EACH ROW
BEGIN
  DECLARE p_date DATE;
  DECLARE p_start TIME;
  DECLARE p_end TIME;
  DECLARE p_stage INT;
  DECLARE err_msg TEXT;

  SELECT performance_date, performance_start_time, performance_end_time
  INTO p_date, p_start, p_end
  FROM performance
  WHERE performance_id = NEW.performance_id;

  IF EXISTS (
    SELECT 1
    FROM performance_artist pa
    JOIN performance p ON p.performance_id = pa.performance_id
    WHERE pa.artist_id = NEW.artist_id
      AND p.performance_date = p_date
      AND (
        (p_start BETWEEN p.performance_start_time AND p.performance_end_time)
        OR
        (p_end BETWEEN p.performance_start_time AND p.performance_end_time)
        OR
        (p.performance_start_time BETWEEN p_start AND p_end)
        OR
        (p.performance_end_time BETWEEN p_start AND p_end)
      )
  ) THEN
		SET err_msg = CONCAT('The artist ',
			(SELECT CONCAT(a.artist_name, ' ', a.artist_surname)
			FROM artist a
			WHERE a.artist_id = NEW.artist_id),
			' is already booked at the day ',p_date,' and time ',p_start,' - ',p_end,''
		);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = err_msg; 
  END IF;
END//
DELIMITER ;


CREATE OR REPLACE VIEW artist_participation_years AS
SELECT
  a.artist_id,
  a.artist_name,
  a.artist_surname,
  YEAR(p.performance_date) AS year
FROM artist a
JOIN performance_artist pa ON a.artist_id = pa.artist_id
JOIN performance p ON pa.performance_id = p.performance_id
ORDER BY a.artist_id, year;

DELIMITER //
CREATE TRIGGER check_artist_consecutive_years
BEFORE INSERT ON performance_artist
FOR EACH ROW 
BEGIN 
    DECLARE new_year INT;   -- η χρονιά που τώρα γίνεται nserted και διερευνούμε
    DECLARE problem INT;    -- πάνω από 3 συνεχόμενα χρόνια

    SELECT YEAR(performance_date)
    INTO new_year
    FROM performance
    WHERE performance_id=NEW.performance_id;

    SELECT COUNT(*)
    INTO problem 
    FROM (
        SELECT DISTINCT YEAR(p.performance_date) AS yearss
        FROM performance_artist pa
        JOIN performance p ON pa.performance_id=p.performance_id
        WHERE pa.artist_id=NEW.artist_id
        UNION 
        SELECT new_year
    )  AS year
    WHERE yearss BETWEEN (new_year-3) AND new_year; 

    IF problem = 4 THEN 
        SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Artist 3 consecutive years';
    END IF;
END;
//

-- για να μην γινει λαθος και το αντιστοιχο performance ενος event ειναι αλλη μερα η ωραa
DELIMITER //
CREATE TRIGGER check_performance_event_time
BEFORE INSERT ON performance
FOR EACH ROW
BEGIN
  DECLARE e_date DATE;
  DECLARE e_start TIME;
  DECLARE e_end TIME;

  SELECT event_date, start_time, end_time
  INTO e_date, e_start, e_end
  FROM event
  WHERE event_id = NEW.event_id;

  IF NEW.performance_date <> e_date THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Performance date does not match event date';
  END IF;

  IF NEW.performance_start_time < e_start OR NEW.performance_end_time > e_end THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Performance time is outside event time range';
  END IF;

END;
//
DELIMITER ;

-- απο εδω και περα θα κανω επιτελους τα total partcipation 

-- ενα event πρεπει να εχει τουλαχιστον ενα performance 
DELIMITER $$
CREATE PROCEDURE event_total_participation_performance()
BEGIN
    IF EXISTS (
        SELECT 1 FROM event e
        WHERE NOT EXISTS (
            SELECT 1 FROM performance p
            WHERE e.event_id = p.event_id
        )
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Every Event must have at least one performance.';
    END IF;
END$$
DELIMITER ;

-- ενα band σιγουρα πρπει να εχει artist
DELIMITER $$
CREATE PROCEDURE artist_total_participation_band()
BEGIN
    IF EXISTS (
        SELECT 1 FROM band b
        WHERE NOT EXISTS (
            SELECT 1 FROM artist_band ab
            WHERE ab.band_id = b.band_id
        )
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Every Band must have at least one artist.';
    END IF;
END$$
DELIMITER ;

-- αυτό ειναι για να παιρνει το performance αυτοματα το αντιστοιχο stage απο το αντιστοιχο event
DELIMITER $$
CREATE TRIGGER trg_set_stage_id
BEFORE INSERT ON performance
FOR EACH ROW
BEGIN
  DECLARE stg_id INT;
  SELECT stage_id INTO stg_id FROM event WHERE event_id = NEW.event_id;
  SET NEW.stage_id = stg_id;
END$$
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_ticket_limits
BEFORE INSERT ON ticket
FOR EACH ROW
BEGIN
  DECLARE vip_category_id TINYINT;
  DECLARE stage_capacity INT;
  DECLARE total_tickets INT;
  DECLARE vip_tickets INT;
  DECLARE event_end DATETIME;
  DECLARE purchase_datetime DATETIME;

  -- Απαγόρευση για for_sale ή activated κατά την εισαγωγή
  IF NEW.for_sale = 1 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Tickets cannot be marked as for sale during creation.';
  END IF;

  -- Συνένωση purchase_date και purchase_time() σε DATETIME 
  SET purchase_datetime = TIMESTAMP(NEW.purchase_date, purchase_time());

  -- Έλεγχος: δεν επιτρέπεται η αγορά από το μέλλον
  IF purchase_datetime > NOW() THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Purchase datetime cannot be in the future.';
  END IF;

  -- Πάρε τη χωρητικότητα της σκηνής για το event
  SELECT s.capacity
  INTO stage_capacity
  FROM event e
  JOIN stage s ON e.stage_id = s.stage_id
  WHERE e.event_id = NEW.event_id;

  -- Μέτρησε εισιτήρια που έχουν εκδοθεί ήδη
  SELECT COUNT(*) INTO total_tickets
  FROM ticket
  WHERE event_id = NEW.event_id;

  -- Έλεγχος 1: αν έχει γεμίσει η σκηνή
  IF total_tickets >= stage_capacity THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Stage is full';
  END IF;

  -- Έλεγχος 2: VIP περιορισμός (μέγιστο 10% της χωρητικότητας)
  SELECT id_ticket_category INTO vip_category_id
  FROM ticket_category
  WHERE category_name = 'VIP';

  IF NEW.id_ticket_category = vip_category_id THEN
    SELECT COUNT(*) INTO vip_tickets
    FROM ticket
    WHERE event_id = NEW.event_id
      AND id_ticket_category = vip_category_id;

    IF vip_tickets >= stage_capacity / 10 THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'The maximum number of VIP tickets has been reached for this event.';
    END IF;
  END IF;

  -- Έλεγχος 3: Μην επιτρέπεις εισιτήριο για event που έχει τελειώσει
  SELECT TIMESTAMP(e.event_date, e.end_time)
  INTO event_end
  FROM event e
  WHERE e.event_id = NEW.event_id;

  IF purchase_datetime >= event_end THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Cannot issue ticket for an event that has already ended.';
  END IF;

END;
DELIMITER //

CREATE TRIGGER ticket_update_restrictions
BEFORE UPDATE ON ticket
FOR EACH ROW
BEGIN
  DECLARE stage_capacity INT;
  DECLARE total_tickets INT;
  DECLARE event_end DATETIME;

  -- Απαγόρευση αλλαγής activated από 1 σε 0
  IF OLD.activated = 1 AND NEW.activated = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Activated tickets cannot be deactivated.';
  END IF;

  -- Απαγόρευση να τεθεί for_sale = 1 σε activated εισιτήριο
  IF (OLD.activated = 1 OR NEW.activated = 1) AND NEW.for_sale = 1 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Activated tickets cannot be put for sale.';
  END IF;

  -- Απαγόρευση να τεθεί activated = 1 σε for_sale εισιτήριο
  IF (OLD.for_sale = 1 OR NEW.for_sale = 1) AND NEW.activated = 1 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'For sale tickets cannot be activated.';
  END IF;

  -- Απαγόρευση ενεργοποίησης μετά το τέλος του event
  -- IF NEW.activated = 1 AND OLD.activated = 0 THEN
  --  SELECT TIMESTAMP(e.event_date, e.end_time)
  --  INTO event_end
  --  FROM event e
  --  WHERE e.event_id = NEW.event_id;

  --  IF NOW() > event_end THEN
  --    SIGNAL SQLSTATE '45000'
  --    SET MESSAGE_TEXT = 'Cannot activate ticket after the event has ended.';
  --  END IF;
  -- END IF;

  -- Αν προσπαθεί να βάλει for_sale = 1 → επιτρέπεται ΜΟΝΟ αν η σκηνή είναι γεμάτη
  IF NEW.for_sale = 1 AND OLD.for_sale = 0 THEN
    -- Πάρε χωρητικότητα σκηνής
    SELECT s.capacity INTO stage_capacity
    FROM event e
    JOIN stage s ON e.stage_id = s.stage_id
    WHERE e.event_id = NEW.event_id;

    -- Μέτρησε πόσα εισιτήρια έχουν εκδοθεί για το event
    SELECT COUNT(*) INTO total_tickets
    FROM ticket
    WHERE event_id = NEW.event_id;

    -- Αν η σκηνή δεν είναι γεμάτη → απαγόρευση
    IF total_tickets < stage_capacity THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Tickets can only be marked as for sale after the stage is full.';
    END IF;

    -- Εισαγωγή στην ουρά μεταπώλησης
    INSERT INTO resell_queue (code_ean13, timestamp)
    VALUES (NEW.code_ean13, NOW());
  END IF;
END;
//

CREATE TRIGGER prevent_delete_activated_ticket
BEFORE DELETE ON ticket
FOR EACH ROW
BEGIN
  IF OLD.activated = 1 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Activated tickets cannot be deleted.';
  END IF;
END;
//

CREATE TRIGGER trigger_resell_queue_flag
AFTER INSERT ON resell_queue
FOR EACH ROW
BEGIN
  UPDATE match_pending 
  SET is_pending = is_pending + 1 
  WHERE id = 1;
END;
//

CREATE TRIGGER trigger_buyer_queue_flag
AFTER INSERT ON buyer_queue
FOR EACH ROW
BEGIN
  UPDATE match_pending 
  SET is_pending = is_pending + 1 
  WHERE id = 1;
END;
//

CREATE EVENT event_call_match_resale
ON SCHEDULE EVERY 1 MINUTE
DO
BEGIN
  DECLARE i INT DEFAULT 0;
  DECLARE pending_count INT;

  SELECT is_pending INTO pending_count FROM match_pending WHERE id = 1;

  WHILE i < pending_count DO
    CALL match_resale();
    SET i = i + 1;
  END WHILE;

  UPDATE match_pending 
  SET is_pending = 0, last_checked = NOW() 
  WHERE id = 1;
END;
//

CREATE TRIGGER check_evaluation_validity
BEFORE INSERT ON evaluation
FOR EACH ROW
BEGIN
  DECLARE event_id_of_perf INT;
  DECLARE ticket_activated TINYINT;
  DECLARE performance_end DATETIME;

  -- 1. Πάρε το event_id της performance
  SELECT event_id INTO event_id_of_perf
  FROM performance
  WHERE performance_id = NEW.performance_id;

  -- 2. Έλεγξε αν ο visitor έχει εισιτήριο για το συγκεκριμένο event
  IF NOT EXISTS (
    SELECT 1 FROM ticket
    WHERE id_visitor = NEW.id_visitor AND event_id = event_id_of_perf
  ) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Visitor must have a ticket for the event of the performance.';
  END IF;

  -- 3. Έλεγξε αν το εισιτήριο είναι activated
  SELECT activated INTO ticket_activated
  FROM ticket
  WHERE id_visitor = NEW.id_visitor AND event_id = event_id_of_perf;

  IF ticket_activated != 1 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ticket must be activated to submit an evaluation.';
  END IF;

  -- 4. Υπολόγισε την ώρα λήξης της performance
  SELECT TIMESTAMP(performance_date, performance_end_time)
  INTO performance_end
  FROM performance
  WHERE performance_id = NEW.performance_id;

  -- 5. Έλεγξε αν η ώρα τώρα είναι μετά την ώρα λήξης
  IF NOW() < performance_end THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Evaluation can only be submitted after the performance has ended.';
  END IF;
END;
//

CREATE TRIGGER check_buyer_queue_constraints
BEFORE INSERT ON buyer_queue
FOR EACH ROW
BEGIN
  DECLARE existing_ticket_count INT;
  DECLARE buyer_visitor_id INT;
  DECLARE target_event_id INT;
  DECLARE resale_exists INT;

  -- 1. Ο buyer πρέπει να έχει δηλώσει είτε code_ean13 είτε (event_id και id_ticket_category)
  IF NEW.code_ean13 IS NULL AND (NEW.event_id IS NULL OR NEW.id_ticket_category IS NULL) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'You must either specify a specific ticket code or both event and ticket category.';
  END IF;

  -- 2. Αν έχει δηλώσει code_ean13, τότε αυτό πρέπει να υπάρχει ήδη στο resell_queue
  IF NEW.code_ean13 IS NOT NULL THEN
    IF NOT EXISTS (
      SELECT 1
      FROM resell_queue
      WHERE code_ean13 = NEW.code_ean13
    ) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'The selected ticket code is not currently available for resale.';
    END IF;
  END IF;
  
  -- 3. Βρες το visitor_id του buyer (αν υπάρχει)
  SELECT v.id_visitor INTO buyer_visitor_id
  FROM visitor v
  JOIN buyer b ON b.buyer_id = NEW.buyer_id
  WHERE v.first_name = b.name AND v.last_name = b.last_name AND v.email = b.email
  LIMIT 1;

  -- 4. Αν υπάρχει αντίστοιχος visitor, έλεγξε αν έχει ήδη εισιτήριο για το ζητούμενο event
  IF buyer_visitor_id IS NOT NULL THEN
    IF NEW.code_ean13 IS NOT NULL THEN
      SELECT event_id INTO target_event_id
      FROM ticket
      WHERE code_ean13 = NEW.code_ean13
      LIMIT 1;
    ELSE
      SET target_event_id = NEW.event_id;
    END IF;

    IF EXISTS (
	  SELECT 1
      FROM ticket
	  WHERE id_visitor = buyer_visitor_id AND event_id = target_event_id
   ) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'You already have a ticket for the selected event.';
     END IF;

  END IF;
END;
//

CREATE PROCEDURE match_resale()
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE matched_ticket CHAR(13);
  DECLARE matched_buyer_id INT;
  DECLARE matched_buyer_queue_id INT;
  DECLARE previous_visitor_id INT;
  DECLARE existing_visitor_id INT;
  DECLARE buyer_requests_remaining INT;
  DECLARE tickets_remaining INT;

  -- Cursor: match κατά FIFO, με έλεγχο είτε ανά code_ean13 είτε ανά event & category
  DECLARE cur CURSOR FOR
    SELECT rq.code_ean13, b.buyer_id, bq.buyer_queue_id
    FROM resell_queue rq
    JOIN ticket t ON rq.code_ean13 = t.code_ean13
    JOIN buyer_queue bq
      ON (
        (bq.code_ean13 IS NOT NULL AND bq.code_ean13 = rq.code_ean13)
        OR
        (bq.code_ean13 IS NULL AND bq.event_id = t.event_id AND bq.id_ticket_category = t.id_ticket_category)
      )
    JOIN buyer b ON b.buyer_id = bq.buyer_id
    ORDER BY rq.timestamp, bq.timestamp;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  OPEN cur;

    FETCH cur INTO matched_ticket, matched_buyer_id, matched_buyer_queue_id;

    -- Πάρε τον προηγούμενο visitor που κατείχε το εισιτήριο
    SELECT id_visitor INTO previous_visitor_id
    FROM ticket
    WHERE code_ean13 = matched_ticket;

    -- Δες αν υπάρχει ήδη visitor με τα στοιχεία του buyer
    SELECT v.id_visitor INTO existing_visitor_id
    FROM visitor v
    JOIN buyer b ON b.buyer_id = matched_buyer_id
    WHERE v.first_name = b.name AND v.last_name = b.last_name AND v.email = b.email
    LIMIT 1;

    IF existing_visitor_id IS NOT NULL THEN
      -- Αν υπάρχει, το εισιτήριο περνάει σε αυτόν
      UPDATE ticket
      SET id_visitor = existing_visitor_id,
          for_sale = 0,
          activated = 0
      WHERE code_ean13 = matched_ticket;
    ELSE
      -- Αν όχι, δημιουργούμε νέο visitor με τα στοιχεία του buyer
      INSERT INTO visitor (first_name, last_name, phone, email, age)
      SELECT name, last_name, phone, email, age
      FROM buyer
      WHERE buyer_id = matched_buyer_id;

      SET existing_visitor_id = LAST_INSERT_ID();

      -- Εκχωρούμε το εισιτήριο στον νέο visitor
      UPDATE ticket
      SET id_visitor = existing_visitor_id,
          for_sale = 0,
          activated = 0
      WHERE code_ean13 = matched_ticket;
    END IF;

    -- Αφαίρεση από τις ουρές    
    DELETE FROM buyer_queue WHERE buyer_queue_id = matched_buyer_queue_id;
    DELETE FROM resell_queue WHERE code_ean13 = matched_ticket;

    -- Αν ο buyer δεν έχει άλλα αιτήματα, διαγράφεται
    SELECT COUNT(*) INTO buyer_requests_remaining
    FROM buyer_queue
    WHERE buyer_id = matched_buyer_id;

    IF buyer_requests_remaining = 0 THEN
      DELETE FROM buyer WHERE buyer_id = matched_buyer_id;
    END IF;

    -- Αν ο προηγούμενος visitor δεν έχει πλέον εισιτήρια, διαγράφεται
	SELECT COUNT(*) INTO tickets_remaining
    FROM ticket
    WHERE id_visitor = previous_visitor_id;

     IF tickets_remaining = 0 THEN
       DELETE FROM visitor WHERE id_visitor = previous_visitor_id;
     END IF;
    

  CLOSE cur;
END;
//

DELIMITER //

DELIMITER //

CREATE PROCEDURE clear_expired_resale_queues()
BEGIN
  DECLARE current_ts DATETIME;
  SET current_ts = NOW();

  DELETE rq
  FROM resell_queue rq
  JOIN ticket t ON rq.code_ean13 = t.code_ean13
  JOIN event e ON t.event_id = e.event_id
  WHERE TIMESTAMP(e.event_date, e.end_time) < current_ts;

  DELETE bq
  FROM buyer_queue bq
  JOIN ticket t ON bq.code_ean13 = t.code_ean13
  JOIN event e ON t.event_id = e.event_id
  WHERE bq.code_ean13 IS NOT NULL
    AND TIMESTAMP(e.event_date, e.end_time) < current_ts;

  DELETE bq
  FROM buyer_queue bq
  JOIN event e ON bq.event_id = e.event_id
  WHERE bq.code_ean13 IS NULL
    AND TIMESTAMP(e.event_date, e.end_time) < current_ts;

END;
//

CREATE VIEW evaluation_likert_view AS
SELECT
  e.id_visitor,
  e.performance_id,
  l1.likert_category AS artist_performance,
  l2.likert_category AS sound_and_light,
  l3.likert_category AS stage_presentation,
  l4.likert_category AS organization,
  l5.likert_category AS overall_impression
FROM evaluation e
JOIN Likert l1 ON e.artist_performance_rating = l1.id_likert
JOIN Likert l2 ON e.sound_and_light_rating = l2.id_likert
JOIN Likert l3 ON e.stage_presentation_rating = l3.id_likert
JOIN Likert l4 ON e.organization_rating = l4.id_likert
JOIN Likert l5 ON e.overall_impression_rating = l5.id_likert;
//

CREATE EVENT event_call_total_partcipation
ON SCHEDULE EVERY 6 MONTH
DO
BEGIN
  CALL check_festival_total_participation();
  CALL stage_total_participation_in_technical_equipment();
  CALL event_total_participation_performance();
  CALL artist_total_participation_band();
  CALL clear_expired_resale_queues();
END;
//

