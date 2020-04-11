*** Settings ***
Documentation                           第三方登录(强制绑定)
Library                                 Collections
Resource                                ../App_Sso/Sso_Common.robot
Suite Setup                             Create Sso Session Common
Suite Teardown                          Fapi Delete All Sessions
Force Tags                              冒烟集-新福建APP     sso-app接口/第三方登录(强制绑定)
...                                     作者：张鹏

*** Variables ***
${FILE_PATH}                            Login_Data/OauthLogin_Data.json
${RESULT_SUCCESS}                       1
${RESULT_FAIL}                          0

${PROVIDER_WEIBO}                       sina_weibo
${OID_WEIBO}                            7126945184
${NICKNAME_WEIBO}                         用户7126945184

${PROVIDER_WECHAT}                      tencent_wechat
${OID_WECHAT}                           o7jOUwwSR2ecmE_wXxsofN7cYbmY
${NICKNAME_WECHAT}                           tester~『测试』

${PROVIDER_QQ}                          tencent_QQ
${OID_QQ}                               E66F9648D22AEF90FAF657DB25CC275B
${NICKNAME_QQ}                               lili

${PROVIDER_APPLE}                       apple
${OID_APPLE}                            001587
${NICKNAME_APPLE}                            APPLE001587



*** Keywords ***

*** Test Cases ***
第三方登录(非强制绑定)11
    SSO Oauth Login                     ${PROVIDER_WEIBO}
    ...                                 ${OID_WEIBO}
    ...                                 ${NICKNAME_WEIBO}
    Fapi Request Should Be Succeed
    Fapi Status Should Be Succeed
    Should Be Equal As Strings          ${response_data.nickname}
    ...                                 ${NICKNAME_WEIBO}
第三方登录(非强制绑定)
    ${json}                             Get File            ${FILE_PATH}
    ${js}                               To Json             ${json}
    ${count}                            Get From Dictionary                     ${js}               count
    ${list}                             Get From Dictionary                     ${js}               list
    FOR                                 ${i}                IN RANGE            ${count}
    \                                   ${str_provider}     Get From Dictionary                     ${list[${i}]}       provider
    \                                   ${str_oid}          Get From Dictionary                     ${list[${i}]}       oid
    \                                   ${str_nickname}     Get From Dictionary                     ${list[${i}]}       nickname
    \                                   ${str_result}       Get From Dictionary                     ${list[${i}]}       code
    \                                   Oauth Login         ${str_provider}
                                        ...                 ${str_oid}
                                        ...                 ${str_nickname}
    \                                   Should Be Equal As Strings              ${response_data.code}                   ${str_result}

