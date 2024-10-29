<?php

namespace App\DataFixtures;

use App\Entity\Person;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class PersonFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        $person1 = new Person();
        $person1->setFirstName('John');
        $person1->setLastName('Doe');
        $person1->setAge(30);
        $person1->setEmail('john.doe@example.com');
        $manager->persist($person1);

        $person2 = new Person();
        $person2->setFirstName('Jane');
        $person2->setLastName('Smith');
        $person2->setAge(25);
        $person2->setEmail('jane.smith@example.com');
        $manager->persist($person2);

        // Add more sample persons if needed

        $manager->flush();
    }
}
