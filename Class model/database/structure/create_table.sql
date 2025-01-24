CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    surname VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    git VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    telegram VARCHAR(50)
);
