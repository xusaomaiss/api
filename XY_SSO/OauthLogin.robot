*** Settings ***
Documentation                           第三方授权登录
Resource                                ../XY_SSO/SSOCommon.robot
Force Tags                              冒烟集-翔宇         会员/第三方授权登录登录（胡勇）
...                                     作者：张鹏

*** Variables ***
${PROVIDER_QQ}                             tencent_QQ
${OID_QQ}                                  F9C1B81FAF40B6F9AFC4B3EB935D2722
${NICKNAME_QQ}                             张鹏
${HEAD_QQ}                                 http://thirdqq.qlogo.cn/g?b=oidb&k=pIYictHiaWJibvOk5WHMURfTQ&s=140&t=1556454545
${PROVIDER_SINA}                        sina_weibo
${OID_SINA}                             2721320961
${NICKNAME_SINA}                        冠森丶
${HEAD_SINA}                            https://tva3.sinaimg.cn/crop.0.0.750.750.180/a2341001jw8evq5e18k8lj20ku0ku0t8.jpg?KID=imgbed,tva&Expires=1575299333&ssig=KSux/5qDU5

*** Keywords ***


*** Test Cases ***
微信第三方授权登录，接口返回三方账号相关数据
    SSO Oauth Login
    Fapi Status Should Be Succeed
    Fapi Request Should Be Succeed

QQ第三方授权登录，接口返回三方账号相关数据
    SSO Oauth Login                     ${PROVIDER_QQ}
    ...                                 ${OID_QQ}
    ...                                 ${NICKNAME_QQ}
    ...                                 ${HEAD_QQ}
    Fapi Status Should Be Succeed
    Fapi Request Should Be Succeed

微博第三方授权登录，接口返回三方账号相关数据
    SSO Oauth Login                     ${PROVIDER_SINA}
    ...                                 ${OID_SINA}
    ...                                 ${NICKNAME_SINA}
    ...                                 ${HEAD_SINA}
    Should Be Equal As Strings          ${response_data.provider}               ${PROVIDER_SINA}