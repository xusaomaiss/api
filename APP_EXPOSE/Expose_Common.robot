*** Settings ***
Documentation                           该文档是举报接口用例文档
Resource                                ../Common/Common.robot
#Force Tags                              新福建APP     举报
#...                                     作者：黄羽

*** Variables ***
${POSTEXPOSE_URI}                       /expose
${SITEID}                               1
${SOURCETYPE}                           0
${TYPE}                                 0

*** Keywords ***
Post Expose
    [Documentation]                     提交举报
    [Arguments]                         ${userid}
    ...                                 ${username}
    ...                                 ${reason}
    ...                                 ${rootid}
    ...                                 ${siteid}=${SITEID}
    ...                                 ${sourcetype}=${SOURCETYPE}
    ...                                 ${type}=${TYPE}
#    ${bodyData} =                       Create Dictionary
#    ...                                 userID              ${userid}
#    ...                                 userName            ${username}
#    ...                                 reason              ${reason}
#    ...                                 rootID              ${rootid}
#    ...                                 siteid              ${siteid}
#    ...                                 sourceType          ${sourcetype}
#    ...                                 type                ${type}
#    ...                                 curVersions         ${CURVERSIONS}

    Fapi Params Set                     userID              ${userid}
    ...                                 userName            ${username}
    ...                                 reason              ${reason}
    ...                                 rootID              ${rootid}
    ...                                 siteid              ${siteid}
    ...                                 sourceType          ${sourcetype}
    ...                                 type                ${type}
    ...                                 curVersions         ${CURVERSIONS}
    Fapi Headers Set
    ...                                 Content-Type=application/x-www-form-urlencoded
#    Fapi Post                           ${APPIF_ALIAS}      ${POSTEXPOSE_URI}   data=${bodyData}
    Fapi Post                           ${APPIF_ALIAS}      ${POSTEXPOSE_URI}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}