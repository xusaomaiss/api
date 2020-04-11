*** Settings ***
Documentation                           该文档是获取App配置模块接口用例文档
Resource                                ../Common/Common.robot
Force Tags                              冒烟集-新福建APP     app配置（林升）
...                                     作者：张鹏

*** Variables ***
${GETCONFIG_URI}                        /getConfig          #APP配置接口
${SITECONF_URI}                         /siteConf           #启动接口


*** Keywords ***
Get Config
    [Documentation]                     获取APP配置信息
    [Arguments]                         ${appid}
    ...                                 ${siteid}
    Fapi Params Set                     appID               ${appid}
    ...                                 siteId              ${siteid}
    ...                                 curVersions         ${CURVERSIONS}
    Fapi Get                            ${APPIF_ALIAS}      ${GETCONFIG_URI}
    ${data}                             Fapi Data To Object
    Set Suite Variable                  ${response_data}    ${data}
