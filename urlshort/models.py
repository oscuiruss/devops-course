from .db import db


class ShortenedURL(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String(15), unique=True, nullable=False)
    url = db.Column(db.String, nullable=False)
