# coding=utf-8
from __future__ import absolute_import
from __future__ import unicode_literals

from FATL.Json2Object import Json2Object
from robot.utils import RERAISED_EXCEPTIONS


class Data(object):
    def field_count(self, pointer):
        return self.__get_length(pointer)

    def __get_length(self, item):
        try:
            return len(item)
        except RERAISED_EXCEPTIONS:
            raise
        except Exception:
            raise RuntimeError("Could not get length of '%s'." % item)


if __name__ == '__main__':
    testData = Data()
    toObject = Json2Object()
    content = u"""{"status":0, "message":"操作成功。", "data": {"groupDesc":["公司所有人员", "公司所有人员组"]}}"""
    obj = toObject.json_to_object(content)
    count = testData.field_count(obj.data.groupDesc)
    assert count == 2
    assert count != 3
