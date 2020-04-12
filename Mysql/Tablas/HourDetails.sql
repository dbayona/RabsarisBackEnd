CREATE TABLE `hours_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_hour` int NOT NULL,
  `id_employee` int NOT NULL,
  `id_date` datetime NOT NULL,
  `start_regular_time` time DEFAULT NULL,
  `end_regular_time` time DEFAULT NULL,
  `start_over_time` time DEFAULT NULL,
  `end_over_time` time DEFAULT NULL,
  `total_regular_time` int DEFAULT '0',
  `total_over_time` int DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FX_ID_HOUR_idx` (`id_hour`),
  CONSTRAINT `FX_ID_HOUR` FOREIGN KEY (`id_hour`) REFERENCES `hours` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci