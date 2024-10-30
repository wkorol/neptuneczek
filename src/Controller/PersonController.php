<?php

namespace App\Controller;

use App\Repository\PersonRepository;
use Psr\Log\LoggerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;

class PersonController extends AbstractController
{
    public function __construct(private LoggerInterface $logger, private readonly PersonRepository $repository)
    {

    }

    #[Route('api/persons', name: 'app_person')]
    public function index(): JsonResponse
    {
        $this->logger->info('Test log message');
        $persons = $this->repository->findAll();
        return $this->json($persons);
    }
}
