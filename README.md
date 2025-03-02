# devops-course

## URL Shortener

This project is a URL shortener service built with Python and Flask.
It allows users to shorten long URLs and redirect to the original URLs using the shortened links.

## Features

* Shorten long URLs
* Redirect to the original URLs using the shortened links
* Track and manage shortened links

## Technologies Used

- Python
- Flask
- SQLAlchemy (ORM)
- PostgreSQL (Database)
- Vercel (Deployment)

## Getting Started

### Prerequisites

- Python 3.x (3.9 or higher recommended)
- pip
- PostgreSQL

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/siddharth-shringarpure/URLShortener.git
    cd URLShortener
    ```

2. Create a pipenv environment or a virtual environment:
    ```sh
    pipenv install
    pipenv shell
    ```
   or
    ```sh
    python -m venv venv
    source venv/bin/activate  # On Windows use `venv\Scripts\activate`
    ```


3. Install the required packages:
    ```sh
    pip install -r requirements.txt
    ```

4. Set up the environment variables:
    - Create a `.env` file in the root directory of the project.
    - Add the following environment variables to the `.env` file:
        ```dotenv
        SECRET_KEY=your_secret_key
        ENV=development
        DATABASE_URL=postgresql+psycopg2://<username>:<password>@<localhost>/<dbname>
        ```

5. Initialize the database:
    ```sh
    flask db init
    flask db migrate
    flask db upgrade
    ```

### Running the Application

1. Start the Flask application:
    ```sh
    flask run
    ```

2. The application will be available at `http://127.0.0.1:5000`.

### Deployment

This project is configured to be deployed on Vercel. The `vercel.json` file contains the necessary configuration for
deployment.

1. Install the Vercel CLI:
    ```sh
    npm install -g vercel
    ```

2. Deploy the application:
    ```sh
    vercel
    ```
