*** Settings ***
Documentation                           该文档是获取栏目模块接口用例文档
Resource                                ../Common/Common.robot
Force Tags                              冒烟集-新福建APP     栏目相关接口（张进）
...                                     作者：张鹏

*** Variables ***
${GETCOLUMNS_URI}                       /getColumns         #查看栏目数据接口
${SITEID}                               1


*** Keywords ***
Get Columns
    [Documentation]                     获取栏目数据接口
    [Arguments]                         ${parentcolumnid}
    ...                                 ${siteid}=${SITEID}
    Fapi Params Set                     parentColumnId      ${parentcolumnid}
    ...                                 siteId              ${siteid}
    ...                                 curVersions         ${CURVERSIONS}
    Fapi Get                            ${APPIF_ALIAS}      ${GETCOLUMNS_URI}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}