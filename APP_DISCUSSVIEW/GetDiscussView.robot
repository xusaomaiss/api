*** Settings ***
Documentation                           评论列表数据接口用例文档
Resource                                ../APP_DISCUSSVIEW/DiscussView_Common.robot
Suite Setup                             Create Session Common
Suite Teardown                          Fapi Delete All Sessions
Force Tags                              新福建APP     评论列表
...                                     作者：黄羽

*** Variables ***
${ROOTID}                               887                     #评论对象，id为887的稿件
${PAGE}                                 1                       #评论的第1次列表
${PAGE1}                                100                     #评论的第100次列表
${RESULT0}                              true
${RESULT1}                              []
${TOTALCOUNT}                           0
${CONTENT}                              评论

*** Keywords ***

*** Test Cases ***
正常获取评论列表数据
    Get DiscussView                     ${ROOTID}
    ...                                 ${PAGE}
    Fapi Request Should Be Succeed
    Should Be True                      ${response_data.totalCount}>${TOTALCOUNT}
    Should Not Be Empty                 ${response_data.list}
#    Log                                 ${response_data.list}
#    Should Be Equal As Strings          ${response_data.list[0].content}        ${CONTENT}

测试不存的页数
    Get DiscussView                     ${ROOTID}
    ...                                 ${PAGE1}
    Fapi Request Should Be Succeed
    Should Be Equal As Strings          ${response_data.list}                   ${RESULT1}