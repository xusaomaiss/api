*** Settings ***
Documentation                           举报接口用例文档
Resource                                ../APP_EXPOSE/Expose_Common.robot
Suite Setup                             Create Session Common
Suite Teardown                          Fapi Delete All Sessions
#Force Tags                              新福建APP     举报
#...                                     作者：黄羽

*** Variables ***
${USERID}                               103                 #提交人ID
${USERNAME}                             用户108             #提交人
${REASON}                               举报测试            #举报理由
${ROOTID}                               887                 #稿件ID
${ROOTID1}                              1633                #评论ID
${SITEID}                               1                   #站点
${TYPE}                                 0                   #类型
${SOURCETYPE0}                          0                   #对应评论
${SOURCETYPE1}                          1                   #对应稿件
${RESULT0}                              true
${RESULT1}                              flase

*** Keywords ***

*** Test Cases ***
正常稿件提交举报
    Post Expose                         ${USERID}
    ...                                 ${USERNAME}
    ...                                 ${REASON}
    ...                                 ${ROOTID}
    ...                                 ${SITEID}
    ...                                 ${SOURCETYPE1}
    Fapi Request Should Be Succeed
    Should Be Equal As Strings          ${response_data.value}    ${RESULT0}

正常评论提交举报
    Post Expose                         ${USERID}
    ...                                 ${USERNAME}
    ...                                 ${REASON}
    ...                                 ${ROOTID1}
    ...                                 ${SITEID}
    ...                                 ${SOURCETYPE0}
    Fapi Request Should Be Succeed
    Should Be Equal As Strings          ${response_data.value}    ${RESULT0}

测试提交不同类型的举报，正常值为0到4 ，但测试超过4的type 返回也为true
    FOR                                 ${i}                IN RANGE            10
    \                                   ${reason_temp}      Catenate            ${REASON}           ${i}
    \                                   Post Expose         ${USERID}
                                        ...                 ${USERNAME}
                                        ...                 ${reason_temp}
                                        ...                 ${ROOTID}
                                        ...                 ${SITEID}
                                        ...                 ${SOURCETYPE1}
                                        ...                 ${i}
    \                                   Should Be Equal As Strings              ${response_data.value}                  ${RESULT0}

