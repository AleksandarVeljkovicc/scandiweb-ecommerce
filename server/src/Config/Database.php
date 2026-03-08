<?php
namespace App\Config;

use PDO;

class Database {
    private static ?PDO $connection = null;

    public static function getConnection(): PDO {
        if (self::$connection === null) {
            $dsn = 'mysql:host=localhost;dbname=ecommerce_db;charset=utf8mb4';
            $username = 'root';
            $password = 'php';
            $options = [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            ];

            self::$connection = new PDO($dsn, $username, $password, $options);
        }
        return self::$connection;
    }
}
