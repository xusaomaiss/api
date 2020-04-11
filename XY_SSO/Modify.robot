*** Settings ***
Documentation                           修改个人资料
Resource                                ../Common/Common.robot
Resource                                ../XY_SSO/SSOCommon.robot
Library                                 OperatingSystem
Library                                 String
Library                                 APPSSO.py
Force Tags                              冒烟集-翔宇         会员/修改个人资料（胡勇）
...                                     作者：张鹏

*** Variables ***
${MODIFY_URI}                           /api/modify
${DEVID}                                429A9EC0-58DE-41D6-B79A-4E073350FA38
${TOKEN}                                20e460aa3de68b172250dc54e3309ec1
${VERSION}                              4.0.3
${PHONE}                                13545396666
${PSW}                                  test123
${UID}                                  14
${SEX}                                  1
${BIR}                                  2000-01-01
${NAME}                                 工号9527


*** Test Case ***
修改个人资料：信息重复
    SSO Modify Api                      ${NAME}
    ...                                 ${SEX}
    ...                                 ${BIR}
    ...                                 ${UID}
    Fapi Request Should Be Succeed
