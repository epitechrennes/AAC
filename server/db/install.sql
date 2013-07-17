SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ANSI';

CREATE DATABASE IF NOT EXISTS `aacdb`;

USE aacdb ;
DROP PROCEDURE IF EXISTS aacdb.drop_user_if_exists ;
DELIMITER $$
CREATE PROCEDURE aacdb.drop_user_if_exists()
BEGIN
  DECLARE foo BIGINT DEFAULT 0 ;
  SELECT COUNT(*)
  INTO foo
    FROM mysql.user
      WHERE User = 'aac' and  Host = '%';
   IF foo > 0 THEN
         DROP USER 'aac'@'%' ;
  END IF;
END ;$$
DELIMITER ;
CALL aacdb.drop_user_if_exists() ;
DROP PROCEDURE IF EXISTS aacdb.drop_users_if_exists ;
SET SQL_MODE=@OLD_SQL_MODE ;