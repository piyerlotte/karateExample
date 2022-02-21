Feature: EndToEnd
  Background:
      * url 'https://testinium.io/Testinium.RestApi'
      * def postScenario = read('CreateToken.feature@createToken')
      * def result = call postScenario
      * def token = result.response.access_token
      * def getDate =
    """
  function()
  {
  return java.lang.Math.round(Math.random()*1000)
  }
    """
      * def time = getDate()
      * def userName = time + 'Test'
      And header Authorization = 'Bearer ' + token

    Scenario: Create Project
      And path '/api/projects'
      And header content-type = 'application/json'
      * def requestBody = read('classpath:Json/createProject.json')
      * request requestBody.project_name += userName
      And request requestBody
      When method Post
      Then status 200
      Then print response
      Then match $.project_name contains 'Test'

    Scenario: Update Project
      And path '/api/projects'
      And header content-type = 'application/json'
      When method Get
      Then status 200
      Then print response
      * def projectId = response[1].id
      Given path '/api/projects/' + projectId
      * def updateProject = read('classpath:Json/updateProject.json')
      * request updateProject.project_name += userName
      And request updateProject
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      When method Put
      Then status 200
      Then match $.project_name contains 'Changed'

    Scenario: Disable Project
      And path '/api/projects'
      And header content-type = 'application/json'
      When method Get
      Then status 200
      Then print response
      * def projectId = response[1].id
      Given path '/api/projects/'+projectId+'/disable'
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      When method Put
      Then status 200
      * match response contains 'OK'

    Scenario: Enable Project
      And path '/api/projects'
      And header content-type = 'application/json'
      When method Get
      Then status 200
      Then print response
      * def projectId = response[1].id
      Given path '/api/projects/'+projectId+'/enable'
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      When method Put
      Then status 200
      * match response contains 'OK'
  #gitignore hatası veriyo
    Scenario: Create Group Scenarios
      And path '/api/projects'
      And header content-type = 'application/json'
      When method Get
      Then status 200
      Then print response
      * def projectId = response[0].id
      Given path '/api/projects/'+projectId+'/groupScenarios'
      * def createScenario = read('classpath:Json/createGroupScenario.json')
      * request createScenario.scenario_name += userName
      And request createScenario
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      When method Post
      Then status 200
      Then print response
      * match $.scenario_name contains 'SCENARIO'

    Scenario: Create Test Plan
      And path '/api/projects'
      And header content-type = 'application/json'
      When method Get
      Then status 200
      Then print response
      * def projectId = response[0].id
      Given path '/api/projects/'+projectId+'/plans'
      * def createPlan = read('classpath:Json/createPlan.json')
      * request createPlan.plan_name += userName
      * request createPlan.project_id = projectId
      * request createPlan
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      When method Post
      Then status 200
      Then print response
      * match $.plan_name contains 'PostmanPlan'

    Scenario: Update Test Plan
      And path '/api/projects'
      And header content-type = 'application/json'
      When method Get
      Then status 200
      * def projectId = response[0].id
      Given path '/api/projects/'+projectId+'/plans'
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      When method Get
      Then status 200
      * def planId = response[1].id
      Given path '/api/projects/'+projectId+'/plans/'+planId
      * def updatePlan = read('classpath:Json/createPlan.json')
      * request updatePlan.plan_name += userName
      * request updatePlan.project_id = projectId
      * request updatePlan
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      When method Put
      Then status 200
      Then print response
      * match $.plan_name contains 'PostmanPlan'

    Scenario: Add Scenario To Plan
      And path '/api/projects'
      And header content-type = 'application/json'
      When method Get
      Then status 200
      * def projectId = response[0].id
      Given path '/api/projects/'+projectId+'/plans'
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      When method Get
      Then status 200
      * def planId = response[0].id
      Given path '/api/projects/'+projectId+'/plans/'+planId+'/scenarios'
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      When method Get
      Then status 200
      * def scenariosId = response[0].id
      Given path '/api/projects/'+projectId+'/plans/'+planId+'/scenarios'
      * def addScenarioToPlan = read('classpath:Json/addScenarioToPlan.json')
      * request addScenarioToPlan
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      When method Put
      Then status 200
      Then match response.status == 'SUCCESS'

    Scenario: Delete Plan
      And path '/api/projects'
      And header content-type = 'application/json'
      When method Get
      Then status 200
      * def projectId = response[0].id
      Given path '/api/projects/'+projectId+'/plans'
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      When method Get
      Then status 200
      * def planId = response[1].id
      * print planId
      Given path '/api/plans/'+planId
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      When method Delete
      Then status 200
      Then print response

    Scenario: Create Scenario
      And path '/api/projects'
      And header content-type = 'application/json'
      When method Get
      Then status 200
      * def projectId = response[0].id
      Given path '/api/projects/'+projectId+'/scenarios'
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      * def createScenario = read('classpath:Json/createScenario.json')
      * request createScenario.scenario_name += userName
      * request createScenario.project_id = projectId
      * request createScenario
      * method Post
      * status 200
      * match response.scenario_name contains 'postmanSenaryosu'

    Scenario: Update Scenario
      And path '/api/projects'
      And header content-type = 'application/json'
      When method Get
      Then status 200
      * def projectId = response[0].id
      Given path '/api/projects/'+projectId+'/scenarios'
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      When method Get
      Then status 200
      * def scenarioId = response[3].id
      Given path '/api/projects/'+projectId+'/scenarios/'+scenarioId
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      * def createScenario = read('classpath:Json/createScenario.json')
      * request createScenario.scenario_name += userName
      * request createScenario.project_id = projectId
      * request createScenario
      * method Put
      * status 200
      * match response.scenario_name contains 'postmanSenaryosu'

    Scenario: Delete Scenario
      And path '/api/projects'
      And header content-type = 'application/json'
      When method Get
      Then status 200
      * def projectId = response[0].id
      Given path '/api/projects/'+projectId+'/scenarios'
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      When method Get
      Then status 200
      * def scenarioId = response[2].id
      Given path '/api/scenarios/'+scenarioId
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      * method Delete
      * status 200
      * match response contains 'true'

    Scenario: Delete Project
      And path '/api/projects'
      And header content-type = 'application/json'
      When method Get
      Then status 200
      * def projectId = response[1].id
      Given path '/api/projects/'+projectId
      And header content-type = 'application/json'
      And header Authorization = 'Bearer ' + token
      * method Delete
      * status 200
      * match response contains 'true'