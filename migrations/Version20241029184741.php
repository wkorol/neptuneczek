<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

final class Version20241029184741 extends AbstractMigration
{
    public function getDescription(): string
    {
        return 'Creates the person table with id, first_name, last_name, age, and email fields';
    }

    public function up(Schema $schema): void
    {
        // SQLite-compatible table creation
        $this->addSql('CREATE TABLE person (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            first_name VARCHAR(255) NOT NULL, 
            last_name VARCHAR(255) NOT NULL, 
            age INT NOT NULL, 
            email VARCHAR(255) NOT NULL
        )');
    }

    public function down(Schema $schema): void
    {
        // Drop table for SQLite
        $this->addSql('DROP TABLE person');
    }
}
