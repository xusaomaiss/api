*** Settings ***
Documentation                           用于会员处业务关键字
Resource                                ../Common/Common.robot
Resource                                ../XY_SSO/Random_Time.robot
Library                                 OperatingSystem
Library                                 String
Library                                 APPSSO.py
Force Tags                              冒烟集-翔宇         会员（张逢琦）
...                                     作者：张鹏

*** Variables ***
${LOGIN_URI}                            /api/login
${REGISTER_URI}                         /api/register
${MODIFY_URI}                           /api/modify
${OAUTHLOGIN_URI}                       /api/oauthLogin
${LOGOUT_URI}                           /api/logout
${LOGINBYPHONE_URI}                     /api/loginByPhone
${FORGETPASSWORD}                       /api/forgetPassword
${CHANGEPHONE_URI}                      /api/changePhone
${OPENACCOUNTS_URI}                     /api/openAccounts
${BIND_URI}                             /api/bind
${UNBIND_URI}                           /api/unbind
${DEVID}                                429A9EC0-58DE-41D6-B79A-4E073350FA38
${TOKEN}                                ${EMPTY}
${VERSION}                              4.0.3
${PHONE}
${PSW}
${PROVIDER}                             tencent_wechat
${OID}                                  okiVGszfVTWUkYxfeLKHTUlnrjlw
${NICKNAME}                             Lz
${HEAD}                                 http://123.jpg
${YUN_SITEID}                           12


*** Keywords ***
    SSO Login Api
    [Documentation]                     登录接口
    [Arguments]                         ${phone}
    ...                                 ${psw}
    ...                                 ${devid}=${DEVID}
    ${random} =                         Random
    ${timestamp} =                      Time
    ${psw1} =                           Md5                 ${psw}
    Fapi Create Session                 ${APPIF_ALIAS}      ${SSO_URL}
    ${secret}=                          Md5                 devid=${devid}&random=${random}&timestamp=${timestamp}&token=${token}&version=${version}
    log                                 ${secret}
    Fapi Params Set                     curVersions         ${CURVERSIONS}
    ${phone1}                           EVALUATE            str(${phone})
#    ${devid1}                          EVALUATE                            str(${devid})
#    ${psw2}                 EVALUATE                            str(${psw1})
    ${bodyData} =                       Create Dictionary
    ...                                 devid               ${devid}
    ...                                 password            ${psw1}
    ...                                 phone               ${phone1}
    ${prosign}=                         Md5                 devid=${devid}&password=${psw1}&phone=${phone1}&secret=${secret}
    ${proParams}                        Set Variable        devid,password,phone
    Fapi Headers Set
    ...                                 program-sign        ${prosign}
    ...                                 devid               ${devid}
    ...                                 random              ${random}
    ...                                 timestamp           ${timestamp}
    ...                                 token               ${TOKEN}
    ...                                 version             ${VERSION}
    ...                                 Content-Type        application/x-www-form-urlencoded
    ...                                 program-params      ${proParams}
    Fapi Post                           ${APPIF_ALIAS}  ${LOGIN_URI}        data=${bodyData}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}

SSO Modify API
    [Documentation]                     修改个人资料
    [Arguments]                         ${nickname}
    ...                                 ${sex}
    ...                                 ${birthday}
    ...                                 ${uid}
    Fapi Create Session                 ${APPIF_ALIAS}  ${SSO_URL}
    ${random} =                         Random
    ${timestamp} =                      Time
    ${secret}=                          Md5                 devid=${devid}&random=${random}&timestamp=${timestamp}&token=${Token}&version=${version}
    ${prosign}=                         Md5                 uid=${uid}&nickname=${nickname}&sex=${sex}&birthday=${birthday}&secret=${secret}
    ${program}                          Set Variable        uid,nickname,sex,birthday
    Fapi Headers Set                    version             ${VERSION}
    ...                                 timestamp           ${timestamp}
    ...                                 program-params      ${program}
    ...                                 devid               ${DEVID}
    ...                                 token               ${TOKEN}
    ...                                 program-sign        ${prosign}
    ...                                 random              ${random}
    Fapi Params Set                     curversions         ${CURVERSIONS}
    ${bodyData} =                       Create Dictionary
    ...                                 nickname            ${nickname}
    ...                                 sex                 ${sex}
    ...                                 birtyday            ${birthday}
    ...                                 uid                 ${uid}
    Fapi Post                           ${APPIF_ALIAS}  ${MODIFY_URI}       data=${bodyData}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}

SSO Register Api
    [Documentation]                     会员注册接口
    [Arguments]                         ${password}
    ...                                 ${phone}
    ...                                 ${siteid}
    ${random} =                         Random
    ${timestamp} =                      Time
    ${password1} =                      Md5                 ${password}
    ${phone1}                           EVALUATE            ${phone}
    Fapi Create Session                 ${APPIF_ALIAS}  ${SSO_URL}
    ${secret} =                         Md5                 devid=${DEVID}&random=${random}&timestamp=${timestamp}&token=${TOKEN}&version=${VERSION}
    ${program}                          Set Variable        password,phone
    ${programsign} =                    Md5                 password=${password1}&phone=${phone1}&secret=${secret}
    Fapi Params Set                     curVersions         ${CURVERSIONS}
    Fapi Headers Set
    ...                                 devid               ${DEVID}
    ...                                 random              ${random}
    ...                                 timestamp           ${timestamp}
    ...                                 token               ${TOKEN}
    ...                                 version             ${VERSION}
    ...                                 program-sign        ${programsign}
    ...                                 Content-Type        application/x-www-form-urlencoded
    ...                                 program-params      ${program}
    ${bodyData} =                       Create Dictionary
    ...                                 password            ${password1}
    ...                                 phone               ${phone1}
    ...                                 siteid              ${siteid}
    Fapi Post                           ${APPIF_ALIAS}      ${REGISTER_URI}         data=${bodyData}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}

SSO Oauth Login
    [Documentation]                     第三方登录接口
    [Arguments]                         ${provider}=${PROVIDER}
    ...                                 ${oid}=${OID}
    ...                                 ${nickname}=${NICKNAME}
    ...                                 ${head}=${HEAD}
    ...                                 ${devid}=${DEVID}
    ...                                 ${siteid}=${YUN_SITEID}
    Fapi Create Session                 ${APPIF_ALIAS}      ${SSO_URL}
    ${random} =                         Random
    ${timestamp} =                      Time
    ${secret} =                         Md5                 devid=${devid}&random=${random}&timestamp=${timestamp}&token=${TOKEN}&version=${VERSION}
    Fapi Params Set                     curVersions         ${CURVERSIONS}
    ${program_sign} =                   Md5                 provider=${provider}&oid=${oid}&nickname=${nickname}&devid=${devid}&head=${head}&siteid=${siteid}&secret=${secret}
    ${program_params}                   Set Variable        provider,oid,nickname,devid,head,siteid
    Fapi Headers Set
    ...                                 devid               ${devid}
    ...                                 random              ${random}
    ...                                 timestamp           ${timestamp}
    ...                                 token               ${TOKEN}
    ...                                 version             ${VERSION}
    ...                                 program-sign        ${program_sign}
    ...                                 Content-Type        application/x-www-form-urlencoded
    ...                                 program-params      ${program_params}
    ${bodyData} =                       Create Dictionary
    ...                                 provider            ${provider}
    ...                                 oid                 ${oid}
    ...                                 nickname            ${nickname}
    ...                                 devid               ${devid}
    ...                                 head                ${head}
    ...                                 siteid              ${siteid}
    Fapi Post                           ${APPIF_ALIAS}      ${OAUTHLOGIN_URI}   data=${bodyData}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}

SSO Login By Phone
    [Documentation]                     手机号快速登录
    [Arguments]                         ${phone}
    ...                                 ${devid}=${DEVID}
    ...                                 ${siteid}=${YUN_SITEID}
    Fapi Create Session                 ${APPIF_ALIAS}      ${SSO_URL}
    ${random} =                         Random
    ${timestamp} =                      Time
    ${secret} =                         Md5                 devid=${devid}&random=${random}&timestamp=${timestamp}&token=${TOKEN}&version=${VERSION}
    Fapi Params Set                     devid               ${devid}
    ...                                 phone               ${phone}
    ...                                 siteid              ${siteid}
    ...                                 curVersions         ${CURVERSIONS}
    ${program_sign} =                   Md5                 devid=${devid}&siteid=${siteid}&phone=${phone}&secret=${secret}
    ${proParams}                        Set Variable        devid,siteid,phone
    Fapi Headers Set
    ...                                 program-sign        ${program_sign}
    ...                                 devid               ${devid}
    ...                                 random              ${random}
    ...                                 timestamp           ${timestamp}
    ...                                 token               ${TOKEN}
    ...                                 version             ${VERSION}
    ...                                 Content-Type        application/x-www-form-urlencoded
    ...                                 program-params      ${proParams}
    Fapi Post                           ${APPIF_ALIAS}      ${LOGINBYPHONE_URI}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}

SSO Logout
    [Documentation]                     退出登录
    [Arguments]                         ${token}
    ...                                 ${uid}
    ...                                 ${devid}=${DEVID}
    ${random} =                         Random
    ${timestamp} =                      Time
    ${secret} =                         Md5                 devid=${devid}&random=${random}&timestamp=${timestamp}&token=${token}&version=${VERSION}
    Fapi Params Set                     curVersions         ${CURVERSIONS}
    ${program_sign} =                   Md5                 devid=${devid}&token=${token}&uid=${uid}&secret=${secret}
    ${proParams}                        Set Variable        devid,token,uid
    Fapi Headers Set
    ...                                 program-sign        ${program_sign}
    ...                                 devid               ${devid}
    ...                                 random              ${random}
    ...                                 timestamp           ${timestamp}
    ...                                 token               ${token}
    ...                                 version             ${VERSION}
    ...                                 Content-Type        application/x-www-form-urlencoded
    ...                                 program-params      ${proParams}
    ${bodyData}                         Create Dictionary
    ...                                 devid               ${devid}
    ...                                 token               ${token}
    ...                                 uid                 ${uid}
    Fapi Post                           ${APPIF_ALIAS}  ${LOGOUT_URI}       data=${bodyData}

SSO Forget Password
    [Documentation]                     重置密码
    [Arguments]                         ${phone}
    ...                                 ${password}
    ...                                 ${token}
    Fapi Create Session                 ${APPIF_ALIAS}  ${SSO_URL}
    ${random} =                         Random
    ${timestamp} =                      Time
    ${password1} =                      Md5                 ${password}
    ${secret} =                         Md5                 devid=${DEVID}&random=${random}&timestamp=${timestamp}&token=${token}&version=${VERSION}
    Fapi Params Set                     curVersions         ${CURVERSIONS}
    ${program_sign} =                   Md5                 phone=${phone}&password=${password1}&secret=${secret}
    ${proParams}                        Set Variable        phone,password
    Fapi Headers Set
    ...                                 program-sign        ${program_sign}
    ...                                 devid               ${DEVID}
    ...                                 random              ${random}
    ...                                 timestamp           ${timestamp}
    ...                                 token               ${token}
    ...                                 version             ${VERSION}
    ...                                 Content-Type        application/x-www-form-urlencoded
    ...                                 program-params      ${proParams}
    ${bodyData} =                       Create Dictionary
    ...                                 phone               ${phone}
    ...                                 password            ${password1}
    Fapi Post                           ${APPIF_ALIAS}      ${FORGETPASSWORD}   data=${bodyData}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data1}    ${data}

SSO Change Phone
    [Documentation]                     修改绑定手机号
    [Arguments]                         ${uid}
    ...                                 ${newphone}
    ...                                 ${token}
    ...                                 ${siteid}=${YUN_SITEID}
    Fapi Create Session                 ${APPIF_ALIAS}      ${SSO_URL}
    ${random} =                         Random
    ${timestamp} =                      Time
    ${secret} =                         Md5                 devid=${DEVID}&random=${random}&timestamp=${timestamp}&token=${token}&version=${VERSION}
    ${program_sign} =                   Md5                 uid=${uid}&newPhone=${newphone}&secret=${secret}
    ${proParams}                        Set Variable        uid,newPhone
    Fapi Params Set                     curVersions         ${CURVERSIONS}
    Fapi Headers Set
    ...                                 program-sign        ${program_sign}
    ...                                 devid               ${DEVID}
    ...                                 random              ${random}
    ...                                 timestamp           ${timestamp}
    ...                                 token               ${token}
    ...                                 version             ${VERSION}
    ...                                 Content-Type        application/x-www-form-urlencoded
    ...                                 program-params      ${proParams}
    ${bodyData} =                       Create Dictionary
    ...                                 uid                 ${uid}
    ...                                 newPhone            ${newphone}
    ...                                 siteid              ${siteid}
    Fapi Post                           ${APPIF_ALIAS}      ${CHANGEPHONE_URI}  data=${bodyData}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data1}    ${data}

Open Accounts
    [Documentation]                     获取第三方关联账号
    [Arguments]                         ${uid}
    Fapi Create Session                 ${APPIF_ALIAS}  ${YUN_SSO_URL}
    ${random} =                         Random
    ${timestamp} =                      Time
    ${secret} =                         Md5                 devid=${EMPTY}&random=${random}&timestamp=${timestamp}&token=${TOKEN}&version=${VERSION}
    ${program_sign} =                   Md5                 uid=${uid}&secret=${secret}
    ${proParams}                        Set Variable        uid
    Fapi Params Set                     curVersions         ${CURVERSIONS}
    Fapi Headers Set
    ...                                 program-sign        ${program_sign}
    ...                                 devid               ${EMPTY}
    ...                                 random              ${random}
    ...                                 timestamp           ${timestamp}
    ...                                 token               ${TOKEN}
    ...                                 version             ${VERSION}
    ...                                 Content-Type        application/x-www-form-urlencoded
    ...                                 program-params      ${proParams}
    ${bodyData} =                       Create Dictionary
    ...                                 uid                 ${uid}
    Fapi Post                           ${APPIF_ALIAS}  ${OPENACCOUNTS_URI}                     data=${bodyData}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}

Bind
    [Documentation]                     本地手机号绑定第三方账号
    [Arguments]                         ${uid}
    ...                                 ${provider}
    ...                                 ${oid}
    ...                                 ${nickname}
    Fapi Create Session                 ${APPIF_ALIAS}      ${SSO_URL}
    ${random} =                         Random
    ${timestamp} =                      Time
    ${secret} =                         Md5                 devid=${EMPTY}&random=${random}&timestamp=${timestamp}&token=${TOKEN}&version=${VERSION}
    ${program_sign} =                   Md5                 uid=${uid}&provider=${provider}&nickname=${nickname}&oid=${oid}&secret=${secret}
    ${proParams}                        Set Variable        uid,provider,nickname,oid
    Fapi Params Set                     curVersions         ${CURVERSIONS}
    Fapi Headers Set
    ...                                 program-sign        ${program_sign}
    ...                                 devid               ${EMPTY}
    ...                                 random              ${random}
    ...                                 timestamp           ${timestamp}
    ...                                 token               ${TOKEN}
    ...                                 version             ${VERSION}
    ...                                 Content-Type        application/x-www-form-urlencoded
    ...                                 program-params      ${proParams}
    ${bodyData} =                       Create Dictionary
    ...                                 uid                 ${uid}
    ...                                 provider            ${provider}
    ...                                 oid                 ${oid}
    ...                                 nickname            ${nickname}
    Fapi Post                           ${APPIF_ALIAS}      ${BIND_URI}         data=${bodyData}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}

Unbind
    [Documentation]                     本队手机号解绑第三方账号
    [Arguments]                         ${uid}
    ...                                 ${provider}
    ...                                 ${oid}
    Fapi Create Session                 ${APPIF_ALIAS}      ${SSO_URL}
    ${random} =                         Random
    ${timestamp} =                      Time
    ${secret} =                         Md5                 devid=${EMPTY}&random=${random}&timestamp=${timestamp}&token=${TOKEN}&version=${VERSION}
    ${program_sign} =                   Md5                 uid=${uid}&provider=${provider}&oid=${oid}&secret=${secret}
    ${proParams}                        Set Variable        uid,provider,oid
    Fapi Params Set                     curVersions         ${CURVERSIONS}
    Fapi Headers Set
    ...                                 program-sign        ${program_sign}
    ...                                 devid               ${EMPTY}
    ...                                 random              ${random}
    ...                                 timestamp           ${timestamp}
    ...                                 token               ${TOKEN}
    ...                                 version             ${VERSION}
    ...                                 Content-Type        application/x-www-form-urlencoded
    ...                                 program-params      ${proParams}
    ${bodyData} =                       Create Dictionary
    ...                                 uid                 ${uid}
    ...                                 provider            ${provider}
    ...                                 oid                 ${oid}
    Fapi Post                           ${APPIF_ALIAS}      ${UNBIND_URI}         data=${bodyData}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}