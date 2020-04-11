*** Settings ***
Documentation                           该文档是获取栏目模块接口用例文档
Resource                                ../App_Column/Column_Common.robot
Suite Setup                             Create Session Common
Suite Teardown                          Fapi Delete All Sessions
Force Tags                              冒烟集-新福建APP     栏目接口/读取子栏目（张进）
...                                     作者：张鹏

*** Variables ***
${ID}                                   0                   #获取所有栏目信息
${ID0}                                  1                   #获取首页下的栏目
${ID1}                                  6666                #栏目不存在
${RESULT}                               首页
${RESULT0}                              头条
${RESULT1}                              []

*** Keywords ***

*** Test Cases ***
读取所有栏目数据,接口返回所有栏目信息
    Get Columns                         ${ID}
    Should Be Equal As Strings          ${response_data.columns[0].columnName}      ${RESULT}

读取首页下的栏目数据，接口返回首页下的所有栏目信息
    Get Columns                         ${ID0}
    Should Be Equal As Strings          ${response_data.columns[0].columnName}      ${RESULT0}

读取的栏目不存在时，接口栏目数据返回为空
    Get Columns                         ${ID1}
    Should Be Equal As Strings          ${response_data.columns}      ${RESULT1}
