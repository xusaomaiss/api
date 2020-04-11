*** Settings ***
Library                                 FATL.FapiKeywords

*** Variables ***
${URL}                                  https://apptest.modaily.cn/app_if
${URI}                                  getArticleContent

*** Keywords ***
Get Articles
#    Fapi Headers Reset
    Fapi Create Session                 get_alias           ${URL}
    Fapi Params Set                     siteID              1
    ...                                 articleId           9330947
    ...                                 curVersions         1
    Fapi Get                            get_alias           ${URI}
    Fapi Request Should Be Succeed
    Fapi Status Should Be Succeed

*** Test Cases ***
aa获取稿件详情
    Get Articles