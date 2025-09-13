
CREATE TABLE IF NOT EXISTS `md_metaldetecting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` text NOT NULL,
  `name` text NOT NULL,
  `citizenid` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
