# coding=utf-8
from __future__ import absolute_import
from __future__ import unicode_literals

from robot.utils import DotDict


class Headers(DotDict):
    def set(self, *key_value_pairs, **items):
        if len(key_value_pairs) % 2 != 0:
            raise ValueError(
                "Adding data to a dictionary failed. There should be even number of key-value-pairs.")
        for i in range(0, len(key_value_pairs), 2):
            self[key_value_pairs[i]] = key_value_pairs[i + 1]
        self.update(items)

    def to_dictionary(self):
        return self.copy()

    def reset(self):
        self.clear()
