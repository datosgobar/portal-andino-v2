"""Tests for helpers.py."""

import ckanext.gobar_harvest.helpers as helpers


def test_gobar_harvest_hello():
    assert helpers.gobar_harvest_hello() == "Hello, gobar_harvest!"
