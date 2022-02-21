Feature: EnvironmentController
Background:
  * url 'https://testinium.io/Testinium.RestApi'
  * def postScenario = read('CreateToken.feature@createToken')
  * def result = call postScenario
  * def token = result.response.access_token

  And header Authorization = 'Bearer ' + token

  @env
  Scenario: GetAllEnvironments
    And path '/api/environments'
    #And header content-type = 'application/json'
    #And headers read('classpath:Json/deneme.json')
    When method GET
    Then status 200
    Then print response
    * def envId = response[0].id

  Scenario: GetEnvironmentById
    * def postScenarioEnv = read('EnvironmentController.feature@env')
    * def resultEnv = call postScenarioEnv
    * def envId = resultEnv.response[0].id
    And path '/api/environments/'+envId
    When method GET
    Then status 200
    Then print response

  Scenario: GetDevicesOfSpecificEnvironmentGroup
    And path '/api/environments/2514/devices'
    When method GET
    Then status 200
    Then print response

  Scenario: GetAllActiveEnvironments
    And path '/api/environments/actives'
    When method GET
    Then status 200
    Then print response

  Scenario: GetEnvironmentForAutomateById
    And path '/api/environments/actives'
    When method GET
    Then status 200
    Then print response

  Scenario: GetAllDesktopEnvironments
    And path '/api/environments/desktop'
    When method GET
    Then status 200
    Then print response

  Scenario: GetAllMobileEnvironments
    And path '/api/environments/mobile'
    When method GET
    Then status 200
    Then print response