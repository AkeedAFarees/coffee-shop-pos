# Coffee Shop POS

## Prerequisites

- Docker and Docker Compose installed

## Running the application locally with Docker

1. Clone the repository:
   ```bash
    git clone https://github.com/AkeedAFarees/coffee-shop-pos.git
    cd coffee-shop-pos
   ```

2. Build and start the containers:
   ```bash
   docker-compose up --build
   ```

3. Set up the database:
   ```bash
   docker-compose run web rake db:create db:migrate db:seed
   ```

4. Open your browser and go to http://localhost:3000 to view the app.


## Stopping the application
   ```bash
   docker-compose down
   ```