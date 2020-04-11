*** Settings ***
Documentation                           该文档是:检索某栏目及其子孙栏目的稿件接口用例文档
Resource                                ../Common/Common.robot
#Force Tags                              冒烟集-新福建APP     搜索相关接口(黄羽）
#...                                     作者：黄羽

*** Variables ***
${GETSEARCHALL_URI}                     /searchAll         #查看栏目数据接口
${SITEID}                               1
${ARTICLETYPE}                          -2

*** Keywords ***
Get SearchAll
    [Documentation]                     检索某栏目及其子孙栏目的稿件接口
    [Arguments]                         ${columnid}
    ...                                 ${key}
    ...                                 ${start}
    ...                                 ${count}
    ...                                 ${siteid}=${SITEID}
    ...                                 ${articletype}=${ARTICLETYPE}
    Fapi Params Set                     columnId         ${columnid}
    ...                                 key              ${key}
    ...                                 start            ${start}
    ...                                 count            ${count}
    ...                                 siteid           ${siteid}
    ...                                 articleType      ${articletype}
    ...                                 curVersions         ${CURVERSIONS}
    Fapi Get                            ${APPIF_ALIAS}      ${GETSEARCHALL_URI}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}