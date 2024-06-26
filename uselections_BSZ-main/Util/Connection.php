<?php

namespace Util;
use PDO;

require_once 'conf/config.zano.php';

class Connection {
    private static PDO $pdo;

    private function __construct() {}

    public static function getInstance(): PDO {
        if (!isset(Connection::$pdo)) {
            $dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8';
            Connection::$pdo = new PDO($dsn, DB_USER, DB_PASSWORD);
        }
        return Connection::$pdo;
    }
}