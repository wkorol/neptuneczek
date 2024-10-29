<?php

namespace App\Controller;

use App\Repository\PersonRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;

class PersonController extends AbstractController
{
    public function __construct(private readonly PersonRepository $repository)
    {

    }

    #[Route('api/persons', name: 'app_person')]
    public function index(): JsonResponse
    {
        $persons = $this->repository->findAll();
        return $this->json($persons);
    }
}
