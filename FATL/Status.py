# coding=utf-8
from __future__ import absolute_import
from __future__ import unicode_literals


class Status(object):
    def status_code(self, resp):
        return resp.status
