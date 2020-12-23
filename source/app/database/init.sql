SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `spotifydb` DEFAULT CHARACTER SET utf8 ;
USE `spotifydb` ;

CREATE TABLE IF NOT EXISTS `spotifydb`.`live_spotify` (
  `artist` VARCHAR(45) NOT NULL,
  `timesListened` INT NOT NULL,
  PRIMARY KEY (`artist`))

ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Needs to be replaced with valid artist names and timesListened
START TRANSACTION;
USE `spotifydb`;
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');
INSERT INTO `spotifydb`.`live_spotify` (`artist`, `timesListened`) VALUES ('test', '100');

COMMIT;
