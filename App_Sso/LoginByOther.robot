*** Settings ***
Documentation                           第三方登录(强制绑定)
Resource                                ../App_Sso/Sso_Common.robot
Suite Setup                             Create Sso Session Common
Suite Teardown                          Fapi Delete All Sessions
Force Tags                              冒烟集-新福建APP     sso-app接口/第三方登录(强制绑定)
...                                     作者：张鹏

*** Variables ***
${PROVIDER_QQ}                          tencent_QQ
${OID_QQ}                               F9C1B81FAF40B6F9AFC4B3EB935D2722
${OID_QQ2}                              F9C1B81FAF40B6F9AFC4B3EB22222222
${NICKNAME_QQ}                          张鹏
${NICKNAME_QQ2}                         张鹏2222
${PROVIDER_SINA}                        sina_weibo
${OID_SINA}                             2721320961
${NICKNAME_SINA}                        冠森丶
${PROVIDER_WX}                          tencent_wechat
${OID_WX}                               okiVGszfVTWUkYxfeLKHTUlnrjlw
${NICKNAME_WX}                          Lz
${UID}                                  20
${UID1}                                 28
${RESULT_SUCCESS}                       1
${RESULT_FAIL}                          0

*** Keywords ***

*** Test Cases ***
第三方登录(强制绑定)
    Login By Other                      ${PROVIDER_QQ}      ${OID_QQ2}          ${NICKNAME_QQ2}
    Should Be Equal As Strings          ${response_data.code}                   ${RESULT_SUCCESS}