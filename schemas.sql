CREATE TABLE IF NOT EXISTS `clothes_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '**NIL**',
  `data` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;