#coding=utf-8

import hashlib,time,random,json

def md5(str):
    #md5加密
    m=hashlib.md5()
    m.update(str.encode("utf8"))
    return m.hexdigest()