*** Settings ***
Library                                 FATL.FapiKeywords

*** Variables ***
${URL}                                  http://appif.xiangyu.test.fzyun.net/app_if
${URI}                                  searchAll

*** Keywords ***
Get Searchall
    Fapi Headers Reset
    Fapi Create Session                 get_alias           ${URL}
    Fapi Params Set                     columnId            0
    ...                                 key                 测试
    ...                                 start               0
    ...                                 articleType         -1
    ...                                 count               20
    ...                                 siteID              2
    Fapi Get                            get_alias           ${URI}
    Fapi Request Should Be Succeed

*** Test Cases ***
搜索稿件
    Get Searchall


