#!/usr/bin/env python
# -*- coding: utf-8 -*-
# ==============
#      Main script file
# ==============

import sys
import os
from glob import glob



def clear_test_output():
    for filename in glob("test_output/*.pdf"):
        os.remove(filename)

    for filename in glob("test_output/*.png"):
        os.remove(filename)

    for filename in glob("test_output/*.doc"):
        os.remove(filename)

