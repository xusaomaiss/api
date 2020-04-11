*** Settings ***
Documentation                           翔宇签到相关接口业务关键字
Resource                                ../Common/Common.robot

*** Variables ***
${SIGNINFO_URI}                         /amuc/api/sign/signInfo
${YUNSITEID}                            12

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

