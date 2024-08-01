*** Settings ***
Documentation       Output a violation when trying to authorize more than 1 transaction for the same merchand and amount in a time window of 2 minutes
Resource            ./environment.resource
Library             Process
Library             OperatingSystem
Suite Teardown      Terminate All Processes    kill=True

*** Variables ***
${expected_output}      {"account": {"client_id": 1234, "active_card": true, "available_limit": 90.00}, "violations": ["doubled-transaction"]}

*** Test Cases ***
Check Output
    ${result}           Run Process     ${application} < ${tests_path}/doubled_transaction.operations  shell=true
    Log                 ${result.stdout}
    Log                 ${result.stderr}
    Should Contain      ${result.stdout}    ${expected_output}
