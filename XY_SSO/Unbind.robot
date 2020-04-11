*** Settings ***
Documentation                           本地账号解绑第三方账号
Resource                                ../XY_SSO/SSOCommon.robot
Force Tags                              冒烟集-翔宇         会员/本地账号解绑第三方账号（胡勇）
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
${UID}                                  20
${UID1}                                 28
${UID2}                                 48
${RESULT}                               -1

*** Keywords ***


*** Test Cases ***
本地账号未绑定过三方账号时解除绑定,解绑失败接口提示"开放账号位于该用户绑定，无法解绑"
    Unbind                              ${UID2}
    ...                                 ${PROVIDER_QQ}
    ...                                 ${OID_QQ}
    Fapi Status Should Be               ${RESULT}

本地账号绑定三方账号后解绑，接口解绑成功
    Bind                                ${UID2}
    ...                                 ${PROVIDER_SINA}
    ...                                 ${OID_SINA}
    ...                                 ${NICKNAME_SINA}
    Sleep                               3
    Unbind                              ${UID2}
    ...                                 ${PROVIDER_SINA}
    ...                                 ${OID_SINA}
    Fapi Request Should Be Succeed
    Fapi Status Should Be Succeed
