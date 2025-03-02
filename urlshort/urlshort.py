import json, re
from typing import Any

from flask import render_template, request, redirect, url_for, flash, abort, session, Blueprint
from .db import db
from .models import ShortenedURL
from .utils import generate_short_code

from sqlalchemy import text

bp = Blueprint('urlshort', __name__)

"""Flags Set:

export FLASK_APP=urlshort; export FLASK_DEBUG=1
"""


@bp.route("/")  # Route for home page
def home():
    return render_template("home.html", codes=session.keys())


@bp.route("/your-url", methods=["GET", "POST"])
def your_url():
    if request.method == "POST":
        short_name = request.form.get("code")
        original_url = request.form.get("url")

        if not original_url:
            flash("No URL provided", "error")
            return redirect(url_for("urlshort.home"))

        if not short_name:
            short_name = generate_short_code()

        else:
            if not re.match("^[-_a-zA-Z0-9]+$", short_name):
                flash("Invalid short name! Use only letters, numbers, and underscores", "error")
                return redirect(url_for("urlshort.home"))

            existing_url = ShortenedURL.query.filter_by(code=short_name).first()
            if existing_url:
                flash("Short name already in use!", "error")
                return redirect(url_for("urlshort.home"))

        new_url = ShortenedURL(code=short_name, url=original_url)
        db.session.add(new_url)
        db.session.commit()

        session[short_name] = original_url
        return render_template("your_url.html", code=short_name)

    else:
        return redirect(url_for("urlshort.home"))


@bp.route("/<string:code>")
def redirector(code) -> Any:
    result = db.session.execute(
        text("SELECT url FROM shortened_url WHERE code = :code"),
        {"code": code}
    ).fetchone()

    if result:
        return redirect(result.url)
    return abort(404)


@bp.errorhandler(404)
def page_not_found(error):
    return render_template("page_not_found.html"), 404
