# AngelSwing API

AngelSwing API is a Ruby on Rails–based RESTful API built as part of a technical assessment. It provides user authentication and content management functionality, following clean API design practices and a frontend-friendly JSON response structure.

---

## Tech Stack

- **Ruby** (see `.ruby-version`)
- **Ruby on Rails (API mode)**
- **PostgreSQL**
- **JWT-based Authentication**
- **Docker & Docker Compose**

---

## Features

- User Signup & Sign In
- JWT-based Authentication
- Authorized access to protected resources
- Content CRUD APIs
- JSON API–style responses
- Dockerized development setup

---

## API Documentation (Postman)

The complete API documentation is available via Postman and includes:

- **Authentication APIs**
- **Request payloads**
- **Authorization headers**
- **Example responses**

**Postman Collection**  
https://documenter.getpostman.com/view/9878875/2sBXVfirC9

---

## Authentication

Authentication is handled using **JSON Web Tokens (JWT)**.

### Sign In

- On successful sign-in, the API returns a **JWT token**.
- This token must be included in all requests to protected endpoints.

### Authorization Header

Send the token in the `Authorization` header using the **Bearer** scheme:
```http
Authorization: Bearer <JWT_TOKEN>
```

---

## Setup Instructions

### Setup Using Docker

#### 1. Build the containers
```bash
sudo docker compose build
```

#### 2. Run the app
```bash
sudo docker compose up
```

#### 3. Setup database inside container
```bash
sudo docker compose exec web rails db:create db:migrate db:seed
```

---

### Setup Without Docker

#### Clone the repository
```bash
git clone https://github.com/RukeshB/angelswing_api.git
cd angelswing_api
```

#### Install dependencies
```bash
bundle install
```

#### Setup environment variables

1. **Create a `.env` file** in the root directory:
```bash
touch .env
```

2. **Add your environment variables in the `.env` file**. Example:
```bash
SECRET_KEY_BASE=your_secret_key_here
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=password
DATABASE_HOST=localhost
```

#### Setup database
```bash
rails db:create db:migrate db:seed
```

#### Start the server
```bash
rails server
```

---