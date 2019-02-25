# -*- coding: utf-8 -*-


import os
from glob import glob
import uuid


def clear_test_output():
    for filename in glob("test_output/*.pdf"):
        os.remove(filename)

    for filename in glob("test_output/*.png"):
        os.remove(filename)

    for filename in glob("test_output/*.doc"):
        os.remove(filename)


def get_some_uuid():
    value = str(uuid.uuid4())
    return value

