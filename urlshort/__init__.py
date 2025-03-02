from flask import Flask
from .db import db
from .urlshort import bp
import os
from dotenv import load_dotenv
from flask_migrate import Migrate

load_dotenv()

def create_app(test_config=None):
    my_app = Flask(__name__)
    my_app.secret_key = os.getenv("SECRET_KEY")

    # Database configuration
    my_app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv("DATABASE_URL")
    my_app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    db.init_app(my_app)
    my_app.register_blueprint(bp)

    migrate = Migrate(my_app, db)

    with my_app.app_context():
        try:
            db.create_all()
            print("Tables created")
        except Exception as e:
            print(f"Error creating tables: {e}")
        print(f"Current working directory: {os.getcwd()}")
        print(f"Database URI: {my_app.config['SQLALCHEMY_DATABASE_URI']}")

    return my_app

app = create_app()

if __name__ == "__main__":
    app = create_app()
    app.run()