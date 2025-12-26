import ckan.plugins.toolkit as tk


def gobar_harvest_required(value):
    if not value or value is tk.missing:
        raise tk.Invalid(tk._("Required"))
    return value


def get_validators():
    return {
        "gobar_harvest_required": gobar_harvest_required,
    }
