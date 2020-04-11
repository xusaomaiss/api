*** Settings ***
Documentation                           该文档是获取稿件详情模块接口用例文档
Resource                                ../App_ArticleContent/ArticleContent_Common.robot
Suite Setup                             Create Session Common
Suite Teardown                          Fapi Delete All Sessions
Force Tags                              冒烟集-新福建APP     栏目接口/读取子栏目（张进）
...                                     作者：张鹏

*** Variables ***
${ID}                                   346                 #稿件存在
${ID0}                                  12138               #稿件不存在
${RESULT0}                              empty


*** Keywords ***


*** Test Cases ***
稿件存在时查看稿件详情，接口返回数据成功
    Get Article Content                 ${ID}
    Should Be Equal As Strings          ${response_data.fileId}        ${ID}

稿件不存在时查看稿件详情，接口返回为空
    Get Article Content                 ${ID0}
    Should Be Equal As Strings          ${response_data}               ${RESULT0}