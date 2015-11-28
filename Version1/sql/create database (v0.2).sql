-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema clashtrack
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `clashtrack` ;

-- -----------------------------------------------------
-- Schema clashtrack
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clashtrack` DEFAULT CHARACTER SET utf8mb4 ;
USE `clashtrack` ;

-- -----------------------------------------------------
-- Table `clashtrack`.`clan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clashtrack`.`clan` ;

CREATE TABLE IF NOT EXISTS `clashtrack`.`clan` (
  `clan_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `date_made` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `clan_name` VARCHAR(45) NOT NULL COMMENT '',
  `clan_name_img` BLOB NOT NULL COMMENT '',
  `clan_tag` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`clan_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clashtrack`.`profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clashtrack`.`profile` ;

CREATE TABLE IF NOT EXISTS `clashtrack`.`profile` (
  `profile_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `player_tag` VARCHAR(45) NULL COMMENT '',
  `player_name1` VARCHAR(45) NULL COMMENT '',
  `player_name2` VARCHAR(45) NULL COMMENT '',
  `player_name1_img` BLOB NULL COMMENT '',
  `player_name2_img` BLOB NULL COMMENT '',
  PRIMARY KEY (`profile_id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clashtrack`.`member_snapshot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clashtrack`.`member_snapshot` ;

CREATE TABLE IF NOT EXISTS `clashtrack`.`member_snapshot` (
  `member_snapshot_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `clan_id` INT NOT NULL COMMENT '',
  `profile_id` INT NOT NULL COMMENT '',
  `snapshot_date` DATETIME NULL COMMENT '',
  `clan_rank` INT NULL COMMENT '',
  `player_xp` INT NULL COMMENT '',
  `war_preference` TINYINT(1) NULL COMMENT '',
  `troops_donated` INT NULL COMMENT '',
  `troops_recieved` INT NULL COMMENT '',
  `trophees` INT NULL COMMENT '',
  PRIMARY KEY (`member_snapshot_id`, `clan_id`, `profile_id`)  COMMENT '',
  CONSTRAINT `fk_member_clan`
    FOREIGN KEY (`clan_id`)
    REFERENCES `clashtrack`.`clan` (`clan_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_member_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `clashtrack`.`profile` (`profile_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_member_clan_idx` ON `clashtrack`.`member_snapshot` (`clan_id` ASC)  COMMENT '';

CREATE INDEX `fk_member_profile1_idx` ON `clashtrack`.`member_snapshot` (`profile_id` ASC)  COMMENT '';


-- -----------------------------------------------------
-- Table `clashtrack`.`war`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clashtrack`.`war` ;

CREATE TABLE IF NOT EXISTS `clashtrack`.`war` (
  `war_id` INT NOT NULL COMMENT '',
  `home_clan_id` INT NOT NULL COMMENT '',
  `visitor_clan_id` INT NOT NULL COMMENT '',
  `war_date` DATE NULL COMMENT '',
  `war_participants` INT NULL COMMENT '',
  `home_stars` INT NULL COMMENT '',
  `visitor_stars` INT NULL COMMENT '',
  `home_level` INT NULL COMMENT '',
  `visitor_level` INT NULL COMMENT '',
  `xp_gain` INT NULL COMMENT 'Total Experienc point gain for home team\n',
  `xp_possible` INT NULL COMMENT 'Experince points possible in this war for home team',
  `xp_base` INT NULL COMMENT 'Experience points gained by getting at least one star on a base. For home team.\n',
  `xp_base_possible` INT NULL COMMENT 'Experience points possible for attacking bases. For home team\n',
  `xp_40p` INT NULL COMMENT '10 points for getting 40% of available stars.  For home Team.\n',
  `xp_60p` INT NULL COMMENT '25 points for getting 60% of available stars. For home team.\n',
  `xp_warwin` INT NULL COMMENT '50 points for winning the war. For home team or null.',
  PRIMARY KEY (`war_id`, `home_clan_id`, `visitor_clan_id`)  COMMENT '',
  CONSTRAINT `fk_war_clan1`
    FOREIGN KEY (`home_clan_id`)
    REFERENCES `clashtrack`.`clan` (`clan_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_war_clan2`
    FOREIGN KEY (`visitor_clan_id`)
    REFERENCES `clashtrack`.`clan` (`clan_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_war_clan1_idx` ON `clashtrack`.`war` (`home_clan_id` ASC)  COMMENT '';

CREATE INDEX `fk_war_clan2_idx` ON `clashtrack`.`war` (`visitor_clan_id` ASC)  COMMENT '';


-- -----------------------------------------------------
-- Table `clashtrack`.`war_player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clashtrack`.`war_player` ;

CREATE TABLE IF NOT EXISTS `clashtrack`.`war_player` (
  `player_id` INT NOT NULL COMMENT '',
  `clan_clan_id` INT NOT NULL COMMENT '',
  `war_war_id` INT NOT NULL COMMENT '',
  `profile_profile_id` INT NULL COMMENT 'If null then visiting team.',
  `player_rank` INT NULL COMMENT 'Player\'s rank in the current war.\n',
  PRIMARY KEY (`player_id`, `war_war_id`, `clan_clan_id`)  COMMENT '',
  CONSTRAINT `fk_player_profile1`
    FOREIGN KEY (`profile_profile_id`)
    REFERENCES `clashtrack`.`profile` (`profile_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_clan1`
    FOREIGN KEY (`clan_clan_id`)
    REFERENCES `clashtrack`.`clan` (`clan_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_war1`
    FOREIGN KEY (`war_war_id`)
    REFERENCES `clashtrack`.`war` (`war_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_player_profile1_idx` ON `clashtrack`.`war_player` (`profile_profile_id` ASC)  COMMENT '';

CREATE INDEX `fk_player_clan1_idx` ON `clashtrack`.`war_player` (`clan_clan_id` ASC)  COMMENT '';

CREATE INDEX `fk_player_war1_idx` ON `clashtrack`.`war_player` (`war_war_id` ASC)  COMMENT '';


-- -----------------------------------------------------
-- Table `clashtrack`.`war_event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clashtrack`.`war_event` ;

CREATE TABLE IF NOT EXISTS `clashtrack`.`war_event` (
  `war_event_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `war_id` INT NOT NULL COMMENT '',
  `attacker_player_id` INT NOT NULL COMMENT '',
  `defender_player_id` INT NOT NULL COMMENT '',
  `time_till_war_end` TIME NULL COMMENT '',
  `percent_destruction` INT NULL COMMENT '',
  `stars` INT NULL COMMENT '',
  `new_stars` INT NULL COMMENT '',
  `xp` INT NULL COMMENT '',
  PRIMARY KEY (`war_event_id`, `war_id`, `attacker_player_id`, `defender_player_id`)  COMMENT '',
  CONSTRAINT `fk_war_event_player1`
    FOREIGN KEY (`attacker_player_id`)
    REFERENCES `clashtrack`.`war_player` (`player_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_war_event_war1`
    FOREIGN KEY (`war_id`)
    REFERENCES `clashtrack`.`war` (`war_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_war_event_player2`
    FOREIGN KEY (`defender_player_id`)
    REFERENCES `clashtrack`.`war_player` (`player_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_war_event_player1_idx` ON `clashtrack`.`war_event` (`attacker_player_id` ASC)  COMMENT '';

CREATE INDEX `fk_war_event_war1_idx` ON `clashtrack`.`war_event` (`war_id` ASC)  COMMENT '';

CREATE INDEX `fk_war_event_player2_idx` ON `clashtrack`.`war_event` (`defender_player_id` ASC)  COMMENT '';


-- -----------------------------------------------------
-- Table `clashtrack`.`clan_snapshot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clashtrack`.`clan_snapshot` ;

CREATE TABLE IF NOT EXISTS `clashtrack`.`clan_snapshot` (
  `clan_snapshot_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `clan_id` INT NOT NULL COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `screenshot` MEDIUMBLOB NULL COMMENT '',
  `badge_level` INT NULL COMMENT '',
  `total_points` INT NULL COMMENT '',
  `wars_won` INT NULL COMMENT '',
  `num_members` INT NULL COMMENT '',
  `clan_type` VARCHAR(20) NULL COMMENT '',
  `required_trophies` INT NULL COMMENT '',
  `war_frequency` VARCHAR(45) NULL COMMENT '',
  `clan_location` VARCHAR(45) NULL COMMENT '',
  `clan_xp` INT NULL COMMENT '',
  `clan_xp_goal` INT NULL COMMENT '',
  PRIMARY KEY (`clan_snapshot_id`)  COMMENT '',
  CONSTRAINT `fk_clan_snapshot_clan1`
    FOREIGN KEY (`clan_id`)
    REFERENCES `clashtrack`.`clan` (`clan_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `clan_snapshot_id_UNIQUE` ON `clashtrack`.`clan_snapshot` (`clan_snapshot_id` ASC)  COMMENT '';

CREATE INDEX `fk_clan_snapshot_clan1_idx` ON `clashtrack`.`clan_snapshot` (`clan_id` ASC)  COMMENT '';


-- -----------------------------------------------------
-- Table `clashtrack`.`profile_snapshot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clashtrack`.`profile_snapshot` ;

CREATE TABLE IF NOT EXISTS `clashtrack`.`profile_snapshot` (
  `profile_snapshot_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `profile_id` INT NOT NULL COMMENT '',
  `clan_id` INT NULL COMMENT 'Clan Id is null if player is not in a clan when the snapshot is taken.\nProbably only possible if player takes a snapshot of themselves. \nIf the game interface is changed at a later time this will be easier to manage.',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `screenshot` MEDIUMBLOB NULL COMMENT '',
  `player_name` VARCHAR(45) NULL COMMENT 'This is here as an indication of when the player changed names if applicable.\n',
  `trophees` INT NULL COMMENT '',
  `clan_poition` INT NULL COMMENT '0 = Player, 1 = Elder, 2 = Co-Leaer, 3 = Leader\n',
  `war_stars_won` INT NULL COMMENT '',
  `all_time_best` INT NULL COMMENT '',
  `troops_donated` INT NULL COMMENT '',
  `troops_recieved` INT NULL COMMENT '',
  `attacks_won` INT NULL COMMENT '',
  `defenses_won` INT NULL COMMENT '',
  `town_hall` INT NULL COMMENT '',
  `barbarian` INT NULL COMMENT '',
  `archer` INT NULL COMMENT '',
  `giant` INT NULL COMMENT '',
  `goblin` INT NULL COMMENT '',
  `wall_breaker` INT NULL COMMENT '',
  `balloon` INT NULL COMMENT '',
  `wizard` INT NULL COMMENT '',
  `healer` INT NULL COMMENT '',
  `dragon` INT NULL COMMENT '',
  `pekka` INT NULL COMMENT '',
  `minion` INT NULL COMMENT '',
  `hog_rider` INT NULL COMMENT '',
  `valkyrie` INT NULL COMMENT '',
  `Golem` INT NULL COMMENT '',
  `witch` INT NULL COMMENT '',
  `lava_hound` INT NULL COMMENT '',
  `barbarian_king` INT NULL COMMENT '',
  `archer_queen` INT NULL COMMENT '',
  `lightning_spell` INT NULL COMMENT '',
  `heal_spell` INT NULL COMMENT '',
  `rage_spell` INT NULL COMMENT '',
  `jump_spell` INT NULL COMMENT '',
  `freeze_spell` INT NULL COMMENT '',
  `poison_spell` INT NULL COMMENT '',
  `earthquake_spell` INT NULL COMMENT '',
  `haste_spell` INT NULL COMMENT '',
  PRIMARY KEY (`profile_snapshot_id`, `profile_id`)  COMMENT '',
  CONSTRAINT `fk_profile_snapshot_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `clashtrack`.`profile` (`profile_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profile_snapshot_clan1`
    FOREIGN KEY (`clan_id`)
    REFERENCES `clashtrack`.`clan` (`clan_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `profile_snapshot_id_UNIQUE` ON `clashtrack`.`profile_snapshot` (`profile_snapshot_id` ASC)  COMMENT '';

CREATE INDEX `fk_profile_snapshot_profile1_idx` ON `clashtrack`.`profile_snapshot` (`profile_id` ASC)  COMMENT '';

CREATE INDEX `fk_profile_snapshot_clan1_idx` ON `clashtrack`.`profile_snapshot` (`clan_id` ASC)  COMMENT '';


-- -----------------------------------------------------
-- Table `clashtrack`.`clan_profile_note`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clashtrack`.`clan_profile_note` ;

CREATE TABLE IF NOT EXISTS `clashtrack`.`clan_profile_note` (
  `clan_id` INT NOT NULL COMMENT '',
  `profile_id` INT NOT NULL COMMENT '',
  `status` INT NULL COMMENT '0 = active, 1 = Left, 2 = Kicked, 3 = Blacklisted',
  `note` TEXT NULL COMMENT '',
  PRIMARY KEY (`clan_id`, `profile_id`)  COMMENT '',
  CONSTRAINT `fk_clan_profile_notes_clan1`
    FOREIGN KEY (`clan_id`)
    REFERENCES `clashtrack`.`clan` (`clan_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clan_profile_notes_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `clashtrack`.`profile` (`profile_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_clan_profile_notes_profile1_idx` ON `clashtrack`.`clan_profile_note` (`profile_id` ASC)  COMMENT '';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
