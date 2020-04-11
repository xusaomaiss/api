*** Settings ***
Documentation                           该文档是获取栏目模块接口用例文档
Resource                                ../App_Article/Article_Common.robot
Suite Setup                             Create Session Common
Suite Teardown                          Fapi Delete All Sessions
Force Tags                              冒烟集-新福建APP     栏目接口/读取子栏目（张进）
...                                     作者：张鹏

*** Variables ***
${ID}                                   5                   #查看头条栏目下的稿件
${ID0}                                  6666                #栏目不存在
${RESULT}                               首页~头条
${RESULT0}                              []
*** Keywords ***

*** Test Cases ***
查看头条栏目下的稿件列表数据，接口成功返回数据
    Get Articles                        ${ID}
    Should Be Equal As Strings          ${response_data.list[0].colName}        ${RESULT}

查看的栏目不存在时，接口返回为空
    Get Articles                        ${ID0}
    Should Be Equal As Strings          ${response_data.list}                   ${RESULT0}