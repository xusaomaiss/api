*** Settings ***
Documentation                           该文档是读数字报详细页面接口用例文档
Resource                                PaperArticle_Common.robot
Suite Setup                             Create Session Common
Suite Teardown                          Fapi Delete All Sessions
#Force Tags                              冒烟集-新福建APP     数字报（李昊）
#...                                     作者：温怡春

*** Variables ***
${ID}                                   136                 #数字报稿件存在
${ID0}                                  12138               #数字报稿件不存在
${RESULT0}                              -1
${VERSION} 								1581350400000


*** Test Cases ***
Paper article exist
#数字报稿件存在时查看详情，接口返回数据成功
    Get Paper Article                   ${ID}
    Should Be Equal As Strings          ${response_data.version}       
    ... 							    ${version}

Paper article doesn't exist
#数字报稿件不存在时查看详情，接口返回失败
    Get Paper Article                   ${ID0}
    Fapi Status Should Be 				${RESULT0}