# coding=utf-8
from __future__ import absolute_import
from __future__ import unicode_literals

import random
import string
from random import randint

import rstr


class Random(object):
    """ ``Random`` object is used to generate random value, including random token
    with specific length, random integer which is less then the given maxValue,
    random email address, random Chinese mobile number, and random string that match
    the given pattern

    """

    def __init__(self):
        pass

    def token(self, len):
        """ Generate a random token with the given length

        ``len`` the expected length of a token

        """
        if len <= 0:
            return u"字符串长度非法"
        else:
            pattern = '[_a-zA-Z]{' + r'1}[a-zA-Z0-9\-\_]{' + str(len - 1) + '}'
            return rstr.xeger(pattern)

    def integer(self, maxValue):
        """ Generate a random integer whose value is less than the given ``maxValue``

        ``maxValue`` the max value of the expected random integer

        """
        return randint(0, maxValue)

    def email(self):
        """ Generate a random email address """
        return rstr.xeger(
            r'[a-zA-Z0-9]{10}\-[a-zA-Z]{2}\_[a-zA-Z]{3}@[a-z]{3}\.com')

    def mobile(self):
        """ Generate a random Chinese mobile number """
        prelist = [
            "130", "131", "132", "133", "134", "135", "136", "137", "138",
            "139", "147", "150", "151", "152", "153", "155", "156", "157",
            "158", "159", "186", "187", "188"
        ]
        return random.choice(prelist) + "".join(
            random.sample(string.digits, 8))

    def string(self, pattern):
        """ Generate a random string that match the given pattern

        ``pattern`` a regular expression used to generate a string

        """
        return rstr.xeger(pattern)
