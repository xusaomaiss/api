# coding=utf-8
from __future__ import absolute_import
from __future__ import unicode_literals

import json


class Dict2Object:
    def __init__(self, d):
        self.__dict__ = d


class Json2Object(object):
    def json_to_object(self, jsonStr):
        return json.loads(jsonStr, object_hook=Dict2Object)


if __name__ == '__main__':
    content2 = """{
        "status": 0,
        "message": "Success.",
        "data": ""
        }
    """
    content1 = """ {
        "status": 0,
        "message": "Success.",
        "data": {
            "pageNumber": 1,
            "pageSize": 20,
            "total": 61,
            "rows": [{
                "groupName": "testGroup",
                "groupDescription": "testGroupDesc",
                "id": "7574882c-fdf0-4059-ab3d-e19445224334",
                "groupType": "everyone",
                "apps": null,
                "users": null
            }]
        }
    }
    """
    content = u""" {
    "status":0,
    "message":"操作成功。",
    "data":
    {
        "id":"6e37f784-629b-432a-9ef3-8914dd35306d",
        "name":"所有人",
        "path":"/所有人",
        "attributes":{
            "groupDescription":["公司所有人员"],
            "groupType":["everyone"]
        },
        "realmRoles":[],
        "clientRoles":{
            "treadstone":["ids-view-profile"],
            "方正OA":["ids-view-profile"]
        },
        "subGroups":[],
        "access":{
            "view":true,
            "manage":true,
            "manageMembership":true
        }
    }
    }
    """
    toObject = Json2Object()
    data = toObject.json_to_object(content2)
    print("data.data is ") + data.data
    # print data.data.rows[0].groupDescription
