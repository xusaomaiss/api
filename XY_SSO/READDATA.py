#coding=utf-8

"""通过readlines()读取文件"""

"""防止在python2上出现乱码"""
import random,os,re,sys
reload(sys)
sys.setdefaultencoding("utf-8")


def register(datapath):
    with open(datapath) as f:
        phone=f.readlines()
    ran=random.randint(0,len(phone)-1)
    phones=[]
    for i in phone:
        #通过正则过滤字符串中的非数字字符
        j=re.sub("\D","",i)
        phones.append(j)
    register_phone=phones.pop(int(ran))
    os.remove(datapath)
    for i in phones:
        with open(datapath,'a') as f:
            f.truncate()
            f.write(i+'\n')
#    with open(phonepath,'a') as f:
#        f.write(phone+'\n')
    return int(register_phone)

#def login(phonepath):
#    s=[]
#    with open(phonepath,'r') as f:
#        a=f.readlines()
#    for i in a:
#        j=re.sub('\D','',i)
#        s.append(j)
#    return int(s[random.randint(0,len(s)-1)])








