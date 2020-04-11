*** Settings ***
Documentation                           该文档是获取App配置模块接口用例文档
Resource                                ../App_Settings/App_Common.robot
Suite Setup                             Create Session Common
Suite Teardown                          Fapi Delete All Sessions
Force Tags                              冒烟集-新福建APP     app配置（林升）
...                                     作者：张鹏

*** Variables ***
${APPID}                                1                   #正确的值
${APPID0}                               0                   #错误的值
${APPID1}                               好                  #输入中文字符
${SITEID}                               1                   #正确的值
${SITEID0}                              0                   #错误的值
${SITEID1}                              好                  #输入中文
${RESULT}                               -1

*** Keywords ***

*** Test Case ***
传入正确的参数,接口返回数据
    Get Config                          ${APPID}
    ...                                 ${SITEID}
    Fapi Status Should Be Succeed

传入错误的APPID和正确SITEID,接口返回数据失败
    Get Config                          ${APPID0}
    ...                                 ${SITEID}
    Fapi Status Should Be               ${RESULT}

传入正确的APPID和错误SITEID,接口返回数据
    Get Config                          ${APPID}
    ...                                 ${SITEID0}
    Fapi Status Should Be Succeed

传入错误的APPID和错误SITEID，接口返回数据失败
    Get Config                          ${APPID0}
    ...                                 ${SITEID0}
    Fapi Status Should Be               ${RESULT}