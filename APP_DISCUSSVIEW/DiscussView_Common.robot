*** Settings ***
Documentation                           该文档是获取评论列表数据接口用例文档
Resource                                ../Common/Common.robot
#Force Tags                              新福建APP     评论列表数据
#...                                     作者：黄羽

*** Variables ***
${DISCUSSVIEW_URI}                      /discussView        #查看评论列表数据
${SITEID}                               1
${SOURCE}                               0
${LASTFILEID}                           1

*** Keywords ***
Get DiscussView
    [Documentation]                     评论列表
    [Arguments]                         ${id}
    ...                                 ${page}
    ...                                 ${siteid}=${SITEID}
    ...                                 ${source}=${SOURCE}
    ...                                 ${lastfileid}=${LASTFILEID}
    Fapi Params Set                     id                  ${id}
    ...                                 source              ${source}
    ...                                 page                ${page}
    ...                                 siteId              ${siteid}
    ...                                 source              ${source}
    ...                                 lastFileId          ${lastfileid}
    ...                                 curVersions         ${CURVERSIONS}
    Fapi Get                            ${APPIF_ALIAS}      ${DISCUSSVIEW_URI}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}