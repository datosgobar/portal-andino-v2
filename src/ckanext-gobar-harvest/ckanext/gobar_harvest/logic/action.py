import ckan.plugins.toolkit as tk
import ckanext.gobar_harvest.logic.schema as schema


@tk.side_effect_free
def gobar_harvest_get_sum(context, data_dict):
    tk.check_access(
        "gobar_harvest_get_sum", context, data_dict)
    data, errors = tk.navl_validate(
        data_dict, schema.gobar_harvest_get_sum(), context)

    if errors:
        raise tk.ValidationError(errors)

    return {
        "left": data["left"],
        "right": data["right"],
        "sum": data["left"] + data["right"]
    }


def get_actions():
    return {
        'gobar_harvest_get_sum': gobar_harvest_get_sum,
    }
