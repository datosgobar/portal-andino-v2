"""Tests for validators.py."""

import pytest

import ckan.plugins.toolkit as tk

from ckanext.gobar_harvest.logic import validators


def test_gobar_harvest_reauired_with_valid_value():
    assert validators.gobar_harvest_required("value") == "value"


def test_gobar_harvest_reauired_with_invalid_value():
    with pytest.raises(tk.Invalid):
        validators.gobar_harvest_required(None)
