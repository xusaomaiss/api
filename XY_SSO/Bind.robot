*** Settings ***
Documentation                           本地账号绑定第三方账号
Resource                                ../XY_SSO/SSOCommon.robot
Force Tags                              冒烟集-翔宇         会员/本地账号绑定第三方账号（胡勇）
...                                     作者：张鹏


*** Variables ***
${PROVIDER_QQ}                          tencent_QQ
${OID_QQ}                               F9C1B81FAF40B6F9AFC4B3EB935D2722
${NICKNAME_QQ}                          张鹏
${PROVIDER_SINA}                        sina_weibo
${OID_SINA}                             2721320961
${NICKNAME_SINA}                        冠森丶
${PROVIDER_WX}                          tencent_wechat
${OID_WX}                               okiVGszfVTWUkYxfeLKHTUlnrjlw
${NICKNAME_WX}                          Lz
${UID}                                  462
${UID1}                                 28
${RESULT}                               -1

*** Keywords ***


*** Test Cases ***
同一个账号已绑定第三方账号，继续绑定该三方账号时接口提示"用户已经绑定该平台其他开放账号"
    Bind                                ${UID}
    ...                                 ${PROVIDER_QQ}
    ...                                 ${OID_QQ}
    ...                                 ${NICKNAME_QQ}
    Fapi Status Should Be               ${RESULT}


同一个账号已绑定第三方账号，继续绑定其他三方账号绑定成功
    Bind                                ${UID}
    ...                                 ${PROVIDER_WX}
    ...                                 ${OID_WX}
    ...                                 ${NICKNAME_WX}
    Should Be Equal As Strings          ${response_data.tencent_wechat.oid}     ${OID_WX}

执行完用例二后解绑微信，以免影响后续测试
    Unbind                              ${UID}
    ...                                 ${PROVIDER_WX}
    ...                                 ${OID_WX}
    Sleep                               3
    Fapi Request Should Be Succeed
    Fapi Status Should Be Succeed

第三方账号已被绑定，新账号去绑定该三方账号时绑定失败接口提示"开放账号已绑定该平台用户"
    Bind                                ${UID1}
    ...                                 ${PROVIDER_QQ}
    ...                                 ${OID_QQ}
    ...                                 ${NICKNAME_QQ}
    Fapi Status Should Be               ${RESULT}

账号未绑定第三方账号时，去绑定三方账号接口返回成功
    Bind                                ${UID1}
    ...                                 ${PROVIDER_SINA}
    ...                                 ${OID_SINA}
    ...                                 ${NICKNAME_SINA}
    Should Be Equal As Strings          ${response_data.sina_weibo.oid}     ${OID_SINA}

执行完用例四后解绑微博，以免影响后续测试
    Unbind                              ${UID1}
    ...                                 ${PROVIDER_SINA}
    ...                                 ${OID_SINA}
    Sleep                               3
    Fapi Request Should Be Succeed
    Fapi Status Should Be Succeed