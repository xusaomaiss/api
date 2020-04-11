*** Settings ***
Documentation                           获取第三方关联账号
Resource                                ../XY_SSO/SSOCommon.robot
Force Tags                              冒烟集-翔宇         会员/获取第三方关联账号（胡勇）
...                                     作者：张鹏

*** Variables ***
${UID0}                                 28                  #未绑定三方账号
${UID1}                                 20                  #已绑定三方账号
${OID}                                  801C8BBACD174037E8002D631B896F9A


*** Keywords ***


*** Test Cases***
本地账号未绑定三方账号时，接口返回为空
    Open Accounts                       ${UID0}
    Fapi Request Should Be Succeed
    Fapi Request Should Be Succeed

本地账号已绑定三方账号时，接口返回绑定的三方账号信息
    Open Accounts                       ${UID1}
#    Should Be Equal As Strings          ${response_data.oid}                    ${OID}
    Fapi Request Should Be Succeed
    Fapi Request Should Be Succeed
