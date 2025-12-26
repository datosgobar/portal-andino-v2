from flask import Blueprint


gobar_harvest = Blueprint(
    "gobar_harvest", __name__)


def page():
    return "Hello, gobar_harvest!"


gobar_harvest.add_url_rule(
    "/gobar_harvest/page", view_func=page)


def get_blueprints():
    return [gobar_harvest]
