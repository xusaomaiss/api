# -*- coding: utf-8 -*-
import time
import platform
# import pytesseract
# from PIL import Image

def generate_stamp(prefix = '', suffix = ''):
    t = time.localtime(time.time())
    stamp = time.strftime('%Y%m%d%H%M%S', t)
    return prefix + stamp + suffix

def get_value_from_string(value):
    length = len(value)
    newValue = int(value[1:length-1])
    return newValue

def get_current_system():
    return platform.system()

def get_sum(num1, num2):
    num2 = int(num2)
    return num1 + num2

def get_result(num1):
    return (num1-1)*2 - 1

def get_substring(str, startnum = '', endnum = ''):
    substring = str[int(startnum):int(endnum)]
    return substring

def string_startswith(str1, str2):
    return str1.startswith(str2)

def split_string(str3, num3=''):
    string = str3[int(num3):]
    return string

def equal(value1, value2):
    if value1 == value2:
        return "0"
    else:
        return "1"

def change_id(num1):
    num1 = int(num1)
    return num1 + 1

def generate_time(prefix = '', suffix = ''):
    t = time.localtime(time.time())
    stamp = time.strftime('%H%M%S', t)
    return prefix + stamp + suffix

def generate_column(prefix = '', suffix = ''):
    t = time.localtime(time.time())
    stamp = time.strftime('%m%d%H%M%S', t)
    return prefix + stamp + suffix

def input_date(prefix = '', suffix = ''):
    t = time.localtime(time.time())
    stamp = time.strftime('%Y-%m-%d', t)
    return prefix + stamp + suffix

# def get_code(img):
#     image = Image.open(img)
#     vcode = pytesseract.image_to_string(image)
#     return vcode

if __name__ == '__main__':
    print generate_stamp('Stamp', '!!!')

