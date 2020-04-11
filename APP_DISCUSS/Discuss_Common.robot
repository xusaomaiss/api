*** Settings ***
Documentation                           该文档是评论提交接口用例文档
Resource                                ../Common/Common.robot
#Force Tags                              新福建APP     评论提交接口
#...                                     作者：黄羽

*** Variables ***
${DISCUSS_URI}                          /discuss            #提交评论
${SITEID}                               1
${SOURCETYPE}                           0
${CHANNEL}                              2
${LONGITUDE}                            116.397128
${LATITUDE}                             39.916527
${LOCATION}                             北京
${USERID}                               103
${USERNAME}                             用户108

*** Keywords ***
Post Discuss
    [Documentation]                     提交评论，为简化，只需要输入评论的稿件ID和评论内容
    [Arguments]                         ${rootid}
    ...                                 ${content}
    ...                                 ${userid}=${USERID}
    ...                                 ${username}=${USERNAME}
    ...                                 ${longitude}=${LONGITUDE}
    ...                                 ${latitude}=${LATITUDE}
    ...                                 ${location}=${LOCATION}
    ...                                 ${siteid}=${SITEID}
    ...                                 ${sourcetype}=${SOURCETYPE}
    ...                                 ${channel}=${CHANNEL}
    ${bodyData} =                       Create Dictionary
    ...                                 rootID              ${rootid}
    ...                                 content             ${content}
    ...                                 userID              ${userid}
    ...                                 userName            ${username}
    ...                                 longitude           ${longitude}
    ...                                 latitude            ${latitude}
    ...                                 location            ${location}
    ...                                 siteid              ${siteid}
    ...                                 sourceType          ${sourcetype}
    ...                                 channel             ${channel}
    ...                                 curVersions         ${CURVERSIONS}
    Fapi Headers Set
    ...                                 Content-Type=application/x-www-form-urlencoded
    Fapi Post                           ${APPIF_ALIAS}      ${DISCUSS_URI}      data=${bodyData}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}