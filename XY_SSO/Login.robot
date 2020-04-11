*** Settings ***
Documentation                           登录
Resource                                ../Common/Common.robot
Resource                                Random_Time.robot
Resource                                SSOCommon.robot
Library                                 OperatingSystem
Library                                 String
Library                                 APPSSO.py
Force Tags                              冒烟集-翔宇         会员/账号登录（胡勇）
...                                     作者：张鹏

*** Variables ***
${DEVID}                                429A9EC0-58DE-41D6-B79A-4E073350FA38
${TOKEN}                                ${EMPTY}
${VERSION}                              4.0.3
${PHONE}                                13545393436
${PHONE1}                               13545390000
${PSW}                                  test123
${RESULT}                               -1

*** Test Case ***
账号已注册时登录,登录成功接口返回账号相关信息
    SSO Login Api                       ${PHONE}
    ...                                 ${PSW}
    Should Be Equal As Strings          ${response_data.phone}                  ${PHONE}

账号未注册时登录，提示账号未注册
    SSO Login Api                       ${PHONE1}
    ...                                 ${PSW}
    Fapi Status Should Be               ${RESULT}

账号已注册，输入错误的密码，登录失败
    SSO Login Api                       13545393436
    ...                                 test123456
    Fapi Status Should Be               ${RESULT}