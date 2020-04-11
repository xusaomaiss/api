*** Settings ***
Documentation                           账号注册
Resource                                ../Common/Common.robot
Resource                                ../XY_SSO/SSOCommon.robot
Force Tags                              冒烟集-翔宇         会员/账号注册（胡勇）
...                                     作者：张鹏

*** Variables ***
${SITEID}                               4
${YUN_SITEID}                           12
${PSW}                                  test123
${PHONE}                                13163211891
${PHONE1}                               13545393436
${RESULT}                               -1

*** Test Case ***
手机号未注册时注册，注册成功并返回账号相关数据(后续优化为动态获取注册手机号)
    SSO Register Api                    ${PSW}
    ...                                 ${PHONE}
    ...                                 ${YUN_SITEID}
    Fapi Request Should Be Succeed

手机号已注册时注册，注册失败并提示手机号已注册
    SSO Register Api                    ${PSW}
    ...                                 ${PHONE1}
    ...                                 ${YUN_SITEID}
    Fapi Status Should Be               ${RESULT}
