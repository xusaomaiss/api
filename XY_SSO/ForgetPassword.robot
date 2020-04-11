*** Settings ***
Documentation                           忘记密码
Resource                                ../XY_SSO/SSOCommon.robot
Force Tags                              冒烟集-翔宇         会员/忘记密码（胡勇）
...                                     作者：张鹏

*** Variables ***
${PHONE}                                13545393436
${PSW}                                  test123
${NEW_PSW}                              test123
${PHONE1}                               13545393710
${RESULT}                               -1

*** Keywords ***


*** Test Cases ***
登录账号后重新修改密码,变更密码成功
    SSO Login Api                       ${PHONE}
    ...                                 ${PSW}
    Sleep                               3
    SSO Forget Password                 ${PHONE}
    ...                                 ${NEW_PSW}
    ...                                 ${response_data.token}
    Fapi Request Should Be Succeed

登录账号后重新修改密码，无法修改密码
    SSO Login Api                       ${PHONE}
    ...                                 ${PSW}
    Sleep                               3
    SSO Forget Password                 ${PHONE1}
    ...                                 ${NEW_PSW}
    ...                                 ${response_data.token}
    Fapi Status Should Be               ${RESULT}