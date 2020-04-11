*** Settings ***
Library                                 FATL.FapiKeywords
Library                                 RequestsLibrary
Library                                 Collections


*** Variables ***
${URL}                                  http://appif.xiangyu.test.fzyun.net/app_if
${URI}                                  getColumns

${URL2}                                  http://api.github.com
${URI2}                                  users/bulkan

*** Keywords ***
Get Columns
    Fapi Headers Reset
    Fapi Create Session                 get_alias           ${URL}
    Fapi Params Set                     siteId              2
    ...                                 parentColumnId      0
    ...                                 version             0
    ...                                 columnType          -1
    Fapi Get                            get_alias           ${URI}
    ${data}                             Fapi Data To Object2
    ${dic}                              Get From Dictionary        ${data}         columns
    ${len}                              get length          ${dic}
    log                                 ${len}
    :FOR    ${i}    IN RANGE            0                   ${len}
    \        ${columnName}              Get From Dictionary         ${dic[${i}]}           columnName
    \        Log To Console                        ${columnName}


    Fapi Request Should Be Succeed


Get Columns2
    Create Session                      get_alias           ${URL2}
    ${data}                             Get Request         get_alias           ${URI2}
    Should Be Equal As Strings          ${data.status_code}    200
    log                                 ${data.json()}
    Dictionary Should Contain Value     ${data.json()}      Bulkan Evcimen
    ${value}                            Get Dictionary Values                   ${data.json()}


*** Test Cases ***
获取栏目
    Get Columns2

