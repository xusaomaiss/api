*** Settings ***
Documentation                           我的评论查看
Resource                                ../Common/Common.robot
Resource                                ../XY_SSO/SSOCommon.robot
Force Tags                              冒烟集-翔宇         我的/我的评论（张逢琦）
...                                     作者：张鹏

*** Variables ***
${MYDISCUSS}                            /myDiscuss
${USERID}
${SITEID}
${PAGE}                                 0


*** Keywords ***
Get MyDiscuss Api
    [Documentation]                     查看我的评论
    [Arguments]                         ${userid}=${USERID}
    ...                                 ${siteid}=${SITEID}
    ...                                 ${page}=${PAGE}
    Fapi Create Session                 ${APPIF_ALIAS}      ${APPIF_URL}
    Fapi Params Set                     userID              ${userid}
    ...                                 siteID              ${siteid}
    ...                                 page                ${page}
    ...                                 curVersions         ${CURVERSIONS}
    Fapi Get                            ${APPIF_ALIAS}      ${MYDISCUSS}
    ${data} =                           Fapi Data To Object
    Fapi Status Should Be Succeed
    Fapi Request Should Be Succeed

*** Test Case ***
未登录时查看我的评论数据返回为空
    Get MyDiscuss Api                   152
    ...                                 4

登录之后查看我的评论数据返回成功
    SSO Login Api                       13545396666
    ...                                 test123
    Get MyDiscuss Api                   152
    ...                                 4
