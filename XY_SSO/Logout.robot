*** Settings ***
Documentation                           第三方授权登录
Resource                                ../XY_SSO/SSOCommon.robot
Force Tags                              冒烟集-翔宇         会员/退出登录（胡勇）
...                                     作者：张鹏
Suite Setup                             Create Yun Session Common
Suite Teardown                          Fapi Delete All Sessions

*** Variables ***
${PHONE}                                13545393436
${PSW}                                  test123

*** Keywords ***


*** Test Cases ***
登录账号后退出登录,接口返回成功状态码为1
    SSO Login Api                       ${PHONE}
    ...                                 ${PSW}
    Sleep                               3
    SSO Logout                          ${response_data.token}
    ...                                 ${response_data.uid}
    Fapi Request Should Be Succeed
