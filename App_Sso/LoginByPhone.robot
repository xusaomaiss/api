*** Settings ***
Documentation                           该文档是获取App配置模块接口用例文档
Resource                                ../App_Sso/Sso_Common.robot
Suite Setup                             Create Sso Session Common
Suite Teardown                          Fapi Delete All Sessions
Force Tags                              冒烟集-新福建APP     sso-app接口/手机号快捷登录（孙安）
...                                     作者：张鹏

*** Variables ***
${PHONE}                                13545396666
${PHONE0}                               12345678901
${PHONE1}                               DADADADASDA
${RESULT}                               -1

*** Keywords ***

*** Test Cases ***
输入正确的手机号进行快捷登录，登录成功接口返回账号相关数据
    Login By Phone                      ${PHONE}
    Should Be Equal As Strings          ${response_data.phone}                  ${PHONE}


输入不存在的手机号进行快捷登录，接口返回手机号格式不正确
    Login By Phone                      ${PHONE0}
    Fapi Status Should Be               ${RESULT}


输入字符进行快捷登录，接口返回手机号格式不正确
    Login By Phone                      ${PHONE1}
    Fapi Status Should Be               ${RESULT}
