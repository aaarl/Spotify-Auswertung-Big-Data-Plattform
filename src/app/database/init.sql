-- MySQL Script generated by MySQL Workbench
-- Tue May 26 08:22:12 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spotifydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema spotifydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spotifydb` DEFAULT CHARACTER SET utf8 ;
USE `spotifydb` ;

-- -----------------------------------------------------
-- Table `spotifydb`.`artists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotifydb`.`artists` (
  `alpha2` VARCHAR(2) NOT NULL,
  `alpha3` VARCHAR(3) NULL,
  `name` VARCHAR(45) NOT NULL,
  `continent` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`alpha2`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `spotifydb`.`artists`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotifydb`;
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('AF', 'AFG', 'Afghanistan', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('AL', 'ALB', 'Albania', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('DZ', 'DZA', 'Algeria', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('AD', 'AND', 'Andorra', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('AO', 'AGO', 'Angola', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('AI', '', 'Anguilla', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('AG', 'ATG', 'Antigua_and_Barbuda', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('AR', 'ARG', 'Argentina', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('AM', 'ARM', 'Armenia', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('AW', 'ABW', 'Aruba', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('AU', 'AUS', 'Australia', 'Oceania');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('AT', 'AUT', 'Austria', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('AZ', 'AZE', 'Azerbaijan', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BS', 'BHS', 'Bahamas', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BH', 'BHR', 'Bahrain', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BD', 'BGD', 'Bangladesh', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BB', 'BRB', 'Barbados', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BY', 'BLR', 'Belarus', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BE', 'BEL', 'Belgium', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BZ', 'BLZ', 'Belize', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BJ', 'BEN', 'Benin', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BM', 'BMU', 'Bermuda', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BT', 'BTN', 'Bhutan', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BO', 'BOL', 'Bolivia', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BQ', '', 'Bonaire', ' Saint Eustatius and Saba');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BA', 'BIH', 'Bosnia_and_Herzegovina', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BW', 'BWA', 'Botswana', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BR', 'BRA', 'Brazil', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('VG', 'VGB', 'British_Virgin_Islands', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BN', 'BRN', 'Brunei_Darussalam', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BG', 'BGR', 'Bulgaria', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BF', 'BFA', 'Burkina_Faso', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('BI', 'BDI', 'Burundi', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('KH', 'KHM', 'Cambodia', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CM', 'CMR', 'Cameroon', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CA', 'CAN', 'Canada', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CV', 'CPV', 'Cape_Verde', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('KY', 'CYM', 'Cayman_Islands', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CF', 'CAF', 'Central_African_Republic', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('TD', 'TCD', 'Chad', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CL', 'CHL', 'Chile', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CN', 'CHN', 'China', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CO', 'COL', 'Colombia', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('KM', 'COM', 'Comoros', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CG', 'COG', 'Congo', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CR', 'CRI', 'Costa_Rica', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CI', 'CIV', 'Cote_dIvoire', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('HR', 'HRV', 'Croatia', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CU', 'CUB', 'Cuba', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CW', 'CUW', 'Curaçao', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CY', 'CYP', 'Cyprus', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CZ', 'CZE', 'Czechia', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CD', 'COD', 'Democratic_Republic_of_the_Congo', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('DK', 'DNK', 'Denmark', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('DJ', 'DJI', 'Djibouti', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('DM', 'DMA', 'Dominica', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('DO', 'DOM', 'Dominican_Republic', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('EC', 'ECU', 'Ecuador', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('EG', 'EGY', 'Egypt', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SV', 'SLV', 'El_Salvador', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('GQ', 'GNQ', 'Equatorial_Guinea', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('ER', 'ERI', 'Eritrea', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('EE', 'EST', 'Estonia', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SZ', 'SWZ', 'Eswatini', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('ET', 'ETH', 'Ethiopia', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('FK', '', 'Falkland_Islands_(Malvinas)', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('FO', 'FRO', 'Faroe_Islands', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('FJ', 'FJI', 'Fiji', 'Oceania');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('FI', 'FIN', 'Finland', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('FR', 'FRA', 'France', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('PF', 'PYF', 'French_Polynesia', 'Oceania');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('GA', 'GAB', 'Gabon', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('GM', 'GMB', 'Gambia', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('GE', 'GEO', 'Georgia', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('DE', 'DEU', 'Germany', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('GH', 'GHA', 'Ghana', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('GI', 'GIB', 'Gibraltar', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('EL', 'GRC', 'Greece', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('GL', 'GRL', 'Greenland', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('GD', 'GRD', 'Grenada', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('GU', 'GUM', 'Guam', 'Oceania');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('GT', 'GTM', 'Guatemala', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('GG', 'GGY', 'Guernsey', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('GN', 'GIN', 'Guinea', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('GW', 'GNB', 'Guinea_Bissau', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('GY', 'GUY', 'Guyana', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('HT', 'HTI', 'Haiti', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('VA', 'VAT', 'Holy_See', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('HN', 'HND', 'Honduras', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('HU', 'HUN', 'Hungary', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('IS', 'ISL', 'Iceland', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('IN', 'IND', 'India', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('ID', 'IDN', 'Indonesia', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('IR', 'IRN', 'Iran', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('IQ', 'IRQ', 'Iraq', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('IE', 'IRL', 'Ireland', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('IM', 'IMN', 'Isle_of_Man', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('IL', 'ISR', 'Israel', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('IT', 'ITA', 'Italy', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('JM', 'JAM', 'Jamaica', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('JP', 'JPN', 'Japan', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('JE', 'JEY', 'Jersey', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('JO', 'JOR', 'Jordan', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('KZ', 'KAZ', 'Kazakhstan', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('KE', 'KEN', 'Kenya', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('XK', 'XKX', 'Kosovo', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('KW', 'KWT', 'Kuwait', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('KG', 'KGZ', 'Kyrgyzstan', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('LA', 'LAO', 'Laos', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('LV', 'LVA', 'Latvia', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('LB', 'LBN', 'Lebanon', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('LS', 'LSO', 'Lesotho', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('LR', 'LBR', 'Liberia', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('LY', 'LBY', 'Libya', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('LI', 'LIE', 'Liechtenstein', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('LT', 'LTU', 'Lithuania', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('LU', 'LUX', 'Luxembourg', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MG', 'MDG', 'Madagascar', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MW', 'MWI', 'Malawi', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MY', 'MYS', 'Malaysia', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MV', 'MDV', 'Maldives', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('ML', 'MLI', 'Mali', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MT', 'MLT', 'Malta', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MR', 'MRT', 'Mauritania', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MU', 'MUS', 'Mauritius', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MX', 'MEX', 'Mexico', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MD', 'MDA', 'Moldova', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MC', 'MCO', 'Monaco', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MN', 'MNG', 'Mongolia', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('ME', 'MNE', 'Montenegro', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MS', 'MSR', 'Montserrat', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MA', 'MAR', 'Morocco', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MZ', 'MOZ', 'Mozambique', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MM', 'MMR', 'Myanmar', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('NA', 'NAM', 'Namibia', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('NP', 'NPL', 'Nepal', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('NL', 'NLD', 'Netherlands', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('NC', 'NCL', 'New_Caledonia', 'Oceania');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('NZ', 'NZL', 'New_Zealand', 'Oceania');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('NI', 'NIC', 'Nicaragua', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('NE', 'NER', 'Niger', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('NG', 'NGA', 'Nigeria', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MK', 'MKD', 'North_Macedonia', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('MP', 'MNP', 'Northern_Mariana_Islands', 'Oceania');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('NO', 'NOR', 'Norway', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('OM', 'OMN', 'Oman', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('PK', 'PAK', 'Pakistan', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('PS', 'PSE', 'Palestine', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('PA', 'PAN', 'Panama', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('PG', 'PNG', 'Papua_New_Guinea', 'Oceania');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('PY', 'PRY', 'Paraguay', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('PE', 'PER', 'Peru', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('PH', 'PHL', 'Philippines', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('PL', 'POL', 'Poland', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('PT', 'PRT', 'Portugal', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('PR', 'PRI', 'Puerto_Rico', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('QA', 'QAT', 'Qatar', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('RO', 'ROU', 'Romania', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('RU', 'RUS', 'Russia', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('RW', 'RWA', 'Rwanda', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('KN', 'KNA', 'Saint_Kitts_and_Nevis', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('LC', 'LCA', 'Saint_Lucia', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('VC', 'VCT', 'Saint_Vincent_and_the_Grenadines', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SM', 'SMR', 'San_Marino', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('ST', 'STP', 'Sao_Tome_and_Principe', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SA', 'SAU', 'Saudi_Arabia', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SN', 'SEN', 'Senegal', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('RS', 'SRB', 'Serbia', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SC', 'SYC', 'Seychelles', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SL', 'SLE', 'Sierra_Leone', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SG', 'SGP', 'Singapore', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SX', 'SXM', 'Sint_Maarten', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SK', 'SVK', 'Slovakia', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SI', 'SVN', 'Slovenia', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SO', 'SOM', 'Somalia', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('ZA', 'ZAF', 'South_Africa', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('KR', 'KOR', 'South_Korea', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SS', 'SSD', 'South_Sudan', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('ES', 'ESP', 'Spain', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('LK', 'LKA', 'Sri_Lanka', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SD', 'SDN', 'Sudan', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SR', 'SUR', 'Suriname', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SE', 'SWE', 'Sweden', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('CH', 'CHE', 'Switzerland', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('SY', 'SYR', 'Syria', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('TW', 'TWN', 'Taiwan', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('TJ', 'TJK', 'Tajikistan', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('TH', 'THA', 'Thailand', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('TL', 'TLS', 'Timor_Leste', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('TG', 'TGO', 'Togo', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('TT', 'TTO', 'Trinidad_and_Tobago', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('TN', 'TUN', 'Tunisia', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('TR', 'TUR', 'Turkey', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('TC', 'TCA', 'Turks_and_Caicos_islands', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('UG', 'UGA', 'Uganda', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('UA', 'UKR', 'Ukraine', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('AE', 'ARE', 'United_Arab_Emirates', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('UK', 'GBR', 'United_Kingdom', 'Europe');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('TZ', 'TZA', 'United_Republic_of_Tanzania', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('US', 'USA', 'United_States_of_America', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('VI', 'VIR', 'United_States_Virgin_Islands', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('UY', 'URY', 'Uruguay', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('UZ', 'UZB', 'Uzbekistan', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('VE', 'VEN', 'Venezuela', 'America');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('VN', 'VNM', 'Vietnam', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('EH', '', 'Western_Sahara', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('YE', 'YEM', 'Yemen', 'Asia');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('ZM', 'ZMB', 'Zambia', 'Africa');
INSERT INTO `spotifydb`.`artists` (`alpha2`, `alpha3`, `name`, `continent`) VALUES ('ZW', 'ZWE', 'Zimbabwe', 'Africa');

COMMIT;

