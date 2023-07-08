<?php
header('Content-Type: application/json');
$data = [
    "name" => "John",
    "cars" => [
        [
            "name" => "Ford",
            "model" => "Mustang"
        ],
        [
            "name" => "BMW",
            "model" => "X5"
        ]
    ]
];
echo json_encode($data);
?>
