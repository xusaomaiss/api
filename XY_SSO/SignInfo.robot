*** Settings ***
Documentation                           翔宇签到相关接口业务关键字
Resource                                ../Common/Common.robot

Force Tags                              冒烟集-翔宇         签到（广鹏举）
...                                     作者：张鹏
Suite Setup                             Create Session Common
Suite Teardown                          Fapi Delete All Sessions



*** Variables ***
${SIGNINFO_URI}                         /amuc/api/sign/signInfo
${YUNSITEID}                            12
${UID}                                  31
${INTERVALDAYS}                         1
${RESULT}                               未配置对应的签到规则

*** Keywords ***
Sign Info
    [Documentation]                     签到信息
    [Arguments]                         ${uid}
    ...                                 ${intervaldays}
    ...                                 ${siteid}=${YUNSITEID}
    Fapi Params Set                     uid                 ${uid}
    ...                                 intervalDays        ${intervaldays}
    ...                                 siteID              ${siteid}
    ...                                 curVersions         ${CURVERSIONS}
    Fapi Get                            ${APPIF_ALIAS}      ${SIGNINFO_URI}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}

*** Test Cases ***
未设置规则时查看签到信息，接口提示未配置规则
    Sign Info                           ${UID}
    ...                                 ${INTERVALDAYS}
    Should Be Equal As Strings          ${response_data.msg}                    ${RESULT}
    Fapi Request Should Be Succeed