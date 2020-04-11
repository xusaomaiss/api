*** Settings ***
Documentation                           变更绑定手机号
Resource                                ../XY_SSO/SSOCommon.robot
Force Tags                              冒烟集-翔宇         会员/变更绑定手机号（胡勇）
...                                     作者：张鹏

*** Variables ***
${PHONE}                                13545393436
${PSW}                                  test123
${NEWPHONE0}                            13545398888
${NEWPHONE1}                            qwreqwedqwdq
${RESULT}                               -1

*** Keywords ***


*** Test Cases ***
#变更的新手机号有效时，接口返回成功（变更新的手机号会阻碍其他的测试）
#    SSO Login Api                       ${PHONE}
#    ...                                 ${PSW}
#    Sleep                               3
#    SSO Change Phone                    ${response_data.uid}
#    ...                                 ${NEWPHONE0}
#    ...                                 ${response_data.token}
#    Should Be Equal As Strings          ${responst_data1.phone}                 ${NEWPHONE0}

#变更的新手机号无效时，接口返回成功（接口未对输入的手机号类型作限制）
#    SSO Login Api                       ${PHONE}
#    ...                                 ${PSW}
#    Sleep                               3
#    SSO Change Phone                    ${response_data.uid}
#    ...                                 ${NEWPHONE1}
#    ...                                 ${response_data.token}

变更的新手机号和登录的手机号是同一个时,接口返回手机号已注册
    SSO Login Api                       ${PHONE}
    ...                                 ${PSW}
    Sleep                               3
    SSO Change Phone                    ${response_data.uid}
    ...                                 ${PHONE}
    ...                                 ${response_data.token}
    Fapi Status Should Be               ${RESULT}
