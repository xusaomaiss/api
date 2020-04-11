*** Settings ***
Library                                 MyLib
Library                                 Selenium2Library

*** Variables ***
${DEVID}                                429A9EC0-58DE-41D6-B79A-4E073350FA38
${TOKEN}                                ${EMPTY}
${VERSION}                              4.0.3
${PHONE}                                13545396666
${PSW}                                  test123

*** Keywords ***
Random
    ${random}                           EVALUATE            random.randint(0,10000000000)           random
    ${typerandom}                       EVALUATE            str(${random})
#    Log                 ${random}
    [Return]                            ${typerandom}

Time
    ${time}                             EVALUATE            int(time.time()*1000)                   time
    ${typetime}                         EVALUATE            str(${time})
#    Log                 ${time}
    [Return]                            ${typetime}

Type
#    ${devid}            EVALUATE            type(${DEVID})
    ${phone}                            EVALUATE            type(${PHONE})
#    ${psw}              EVALUATE            type(${PSW})

#*** Test Case ***
#打印随机数
#    Random

#打印时间戳
#    Time

#判断传入数值的类型
#    Type


