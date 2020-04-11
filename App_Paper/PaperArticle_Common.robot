*** Settings ***
Documentation                           该文档是读数字报详细页面接口用例文档
Resource                                ../Common/Common.robot
#Force Tags                              冒烟集-新福建APP     数字报相关接口（李昊）
#...                                     作者：温怡春

*** Variables ***
${GETPAPERARTICLE_URI}                  /getPaperArticle
${SITEID}                               1

*** Keywords ***
Get Paper Article
    [Documentation]                     查看数字报详细接口
    [Arguments]                         ${id} 	
    ...                                 ${siteID}=${SITEID}
    Fapi Params Set                     id                  ${id}
    ...  			                    siteID              1
    ...                                 curVersions         ${CURVERSIONS}
    Fapi Get                            ${APPIF_ALIAS}      ${GETPAPERARTICLE_URI}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}