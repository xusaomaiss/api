*** Settings ***
Documentation                           第三方授权登录
Resource                                ../XY_SSO/SSOCommon.robot
Force Tags                              冒烟集-翔宇         会员/退出登录（胡勇）
...                                     作者：张鹏

*** Variables ***
${PHONE}                                13545396666
${PHONE1}                               EYQUEYUQ
${RESULT}                               -1

*** Keywords ***


*** Test Cases ***
输入正确的手机号进行快速登录，接口返回成功并账号相关信息
    SSO Login By Phone                  ${PHONE}
    Should Be Equal As Strings          ${response_data.phone}                  ${PHONE}

输入错误格式的手机号进行快速登录，接口返回失败
    SSO Login By Phone                  ${PHONE1}
    Fapi Status Should Be               ${RESULT}