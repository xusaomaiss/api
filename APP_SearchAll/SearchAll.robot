*** Settings ***
Documentation                           该文档是检索某栏目及其子孙栏目的稿件接口用例文档
Resource                                ../APP_SearchAll/SearchAll_Common.robot
Suite Setup                             Create Session Common
Suite Teardown                          Fapi Delete All Sessions
Force Tags                              冒烟集-新福建APP     搜索接口/检索某栏目及其子孙栏目的稿件
...                                     作者：黄羽

*** Variables ***
${COLUMNID}                             1                   #获取首页所有栏目信息
${COLUMNID1}                            6666                #栏目不存在
${KEY}                                  测试                #正常关键字
${KEY1}                                 null                #非法关键字
${START}                                0                   #稿件起始位置
${COUNT}                                10                  #正常稿件数量测试
${COUNT1}                               -1                  #稿件数量负数测试
${RESULT}                               0
${RESULT1}                              []
${TITLE}                                测试\\\\

*** Keywords ***

*** Test Cases ***
读取首页所有栏目数据,接口返回所有栏目查询结果
    Get SearchAll                       ${COLUMNID}
    ...                                 ${KEY}
    ...                                 ${START}
    ...                                 ${COUNT}
    ${len}                              Get Length          ${response_data}
    Should Be True                      ${len}>${RESULT}


    ${json_data}                        Fapi Response Data
    Log                                 ${json_data}
    ${tag_value}                        Get From Dictionary             ${json_data[0]}        version
    Log                                 ${tag_value}
    ${str_data}                         Convert To String               ${tag_value}
    should not be empty                 ${str_data}


    ${json_data}                        Fapi Response Data
    ${str_data}                         Convert To String               ${json_data}                #把json转成string 通过包含进行判断
    log                                 ${str_data}
    should contain                      ${str_data}                     version


测试不存在栏目ID查询结果为空
    Get SearchAll                       ${COLUMNID1}
    ...                                 ${KEY}
    ...                                 ${START}
    ...                                 ${COUNT}
    ${len}                              Get Length          ${response_data}
    Should Be Equal As Numbers          ${len}              ${RESULT}
    Should Be Equal As Strings          ${response_data}    ${RESULT1}

非法关键字查询结果为空
    Get SearchAll                       ${COLUMNID}
    ...                                 ${KEY1}
    ...                                 ${START}
    ...                                 ${COUNT}
    Should Be Equal As Strings          ${response_data}    ${RESULT1}

查询条件中count=-1 查询结果期望为空，经测试count参数无影响
    Get SearchAll                       ${COLUMNID}
    ...                                 ${KEY}
    ...                                 ${START}
    ...                                 ${COUNT1}
    Should Be Equal As Strings          ${response_data}    ${RESULT1}