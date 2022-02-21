Feature: ProjectController
  Background:
    * url 'https://testinium.io/Testinium.RestApi'
    * def postScenario = read('CreateToken.feature@createToken')
    * def result = call postScenario
    * def token = result.response.access_token

    And header Authorization = 'Bearer ' + token
#KODLARIN ÇALIŞMASI İÇİN CREATE PROJECT SENARYOSUNDAKİ BODY KISMINDA PROJECT NAME
  #DEĞERİNİN DEĞİŞTİRİLMESİ GEREKLİ
    @project
    Scenario: CreateProject
    And path '/api/projects'
    And header content-type = 'application/json'
    * def requestBody =
    """
    {
        "project_name": "postmanOlusturuldu12",
        "description": "TEST",
        "enabled": true,
        "repository_path": "deneme",
        "test_framework": "SELENIUM",
        "test_file_type": "SELENIUM_JAVA",
        "test_runner_tool": "MAVEN",
        "company_id": 6289
    }
    """
    And request requestBody
    When method Post
    Then status 200
    Then print response
    Then match $.project_name contains 'postman'

    Scenario: GetAllProjects
    And path '/api/projects'
    And header content-type = 'application/json'
    When method Get
    Then status 200
    Then print response
#Sorgulardaki projectId değeri değiştirilerek gider projelere ulaşılabilir
    Scenario: GetProjectById
    * def projectId = 6354
    And path '/api/projects/'+projectId
    And header content-type = 'application/json'
    When method Get
    Then status 200
    Then print response

    Scenario: UpdateProject
    * def projectId = 6354
    And path '/api/projects/'+projectId
    And header content-type = 'application/json'
    * def requestBody =
    """
    {
    "project_name": "ManuelDenemeProjesi",
    "enabled": true,
    "repository_path": "deneme",
    "test_framework": "SELENIUM",
    "test_file_type": "SELENIUM_JAVA",
    "test_runner_tool": "MAVEN"
    }
    """
    And request requestBody
    When method Put
    Then status 200
    Then print response

    Scenario: DeleteProject
    * def projectId = 6354
    And path '/api/projects/'+projectId
    And header content-type = 'application/json'
    When method Delete
    Then status 200
    Then print response
#500 hatası dönüyor
    Scenario: GetAllPlansByProject
    * def projectId = 6354
    And path '/api/projects/'+projectId+'/allPlans'
    And header content-type = 'application/json'
    When method Get
    Then status 200
    Then print response

    Scenario: DisableProject
    * def projectId = 6354
    And path '/api/projects/'+projectId+'/disable'
    And header content-type = 'application/json'
    When method Put
    Then status 200
    Then print response
    Then match response == '"OK"'

    Scenario: EnableProject
    * def projectId = 6354
    And path '/api/projects/'+projectId+'/enable'
    And header content-type = 'application/json'
    When method Put
    Then status 200
    Then print response
    Then match response == '"OK"'
    @scenario
    Scenario: CreateGroupScenarios
    * def projectId = 6354
    And path '/api/projects/'+projectId+'/groupScenarios'
    And header content-type = 'application/json'
    * def requestBody =
    """
    {
        "scenario_name": "SCENARIO1",
        "enabled": true,
        "testrail_enabled": false,
        "execute_mode": "AUTOMATED",
        "source_file": "com/testinium/TestiniumDemo.java",
        "project_id": 6354,
        "plans": [
            1
        ],
        "java_test_class": "com.testinium.TestiniumDemo",
        "java_test_methods": "testSearch"
    }
    """
    And request requestBody
    When method Post
    Then status 200
    Then print response

    Scenario: GetAllGroupScenarios
    * def projectId = 6354
    And path '/api/projects/'+projectId+'/groupScenarios'
    And header content-type = 'application/json'
    When method Get
    Then status 200
    Then print response

    Scenario: ScanTestMethods
    * def projectId = 6354
    And path '/api/projects/'+projectId+'/methods'
    And header content-type = 'application/json'
    When method Get
    Then status 200
    Then print response

    Scenario: GetAllPlans
    * def projectId = 6354
    And path '/api/projects/'+projectId+'/plans'
    And header content-type = 'application/json'
    When method Get
    Then status 200
    Then print response

    Scenario: CreateTestPlan
    * def projectId = 6354
    And path '/api/projects/'+projectId+'/plans'
    And header content-type = 'application/json'
    * def requestBody =
    """
    {
	"plan_name": "PostmanPlan",
    "group_plan": false,
    "enabled": false,
    "plan_parallel_test_limit": 10,
    "period": {
        "period_type": "MANUAL",
        "scheduled_days_of_week": [
            2,
            3,
            4,
            5,
            6,
            7,
            1
        ],
        "repeat_period": 60
    },
    "project_id": 6354,
    "company_id": 6289,
    "failed_test_retry_count": 0,
    "screenshots_enabled": true,
    "video_enabled": false,
    "environments": [],
    "max_step_duration": 120,
    "performance_data_enabled": false,
    "resolutions": {}
    }
     """
    And request requestBody
    When method Post
    Then status 200
    Then print response
    Then match response.plan_name contains 'PostmanPlan'
#Sorgudaki planId değiştirilerek diğer planlara ulaşılabilir
    Scenario: GetPlanById
    * def projectId = 6354
    * def planId = 12497
    And path '/api/projects/'+projectId+'/plans/'+planId
    And header content-type = 'application/json'
    When method Get
    Then status 200
    Then print response

    Scenario: UpdateTestPlan
    * def projectId = 6354
    * def planId = 12497
    And path '/api/projects/'+projectId+'/plans/'+planId
    And header content-type = 'application/json'
    * def requestBody =
    """
    {
	"plan_name": "PostmanPutIleDegisti",
    "group_plan": false,
    "enabled": false,
    "plan_parallel_test_limit": 10,
    "period": {
        "period_type": "MANUAL",
        "scheduled_days_of_week": [
            2,
            3,
            4,
            5,
            6,
            7,
            1
        ],
        "repeat_period": 60
    },
    "project_id": 6354,
    "company_id": 6289,
    "failed_test_retry_count": 0,
    "screenshots_enabled": true,
    "video_enabled": false,
    "environments": [],
    "max_step_duration": 120,
    "performance_data_enabled": false,
    "resolutions": {}
    }
     """
    And request requestBody
    When method Put
    Then status 200
    Then print response
    Then match response.plan_name contains 'Degisti'

    Scenario: GetScenariosOfPlan
    * def projectId = 6354
    * def planId = 12497
    And path '/api/projects/'+projectId+'/plans/'+planId
    And header content-type = 'application/json'
    When method Get
    Then status 200
    Then print response

    Scenario: GetAllScenarios
    * def projectId = 6354
    And path '/api/projects/'+projectId+'/scenarios'
    And header content-type = 'application/json'
    When method Get
    Then status 200
    Then print response

    Scenario: CreateScenario
    * def projectId = 6354
    And path '/api/projects/'+projectId+'/scenarios'
    And header content-type = 'application/json'
    * def requestBody =
    """
    {
    "has_parameterized_class": false,
    "scenario_name": "postmanSenaryosu",
    "type": "SELENIUM",
    "testrail_enabled": false,
    "childs": [
    ],
    "enabled": true,
    "source_file": "ProductPage.spec",
    "java_test_class": "ProductPage",
    "deleted": false,
    "execute_mode": "AUTOMATED",
    "project_id": 6354,
    "parameterized": false,
    "plans": [
    ]
    }
     """
    And request requestBody
    When method Post
    Then status 200
    Then print response

    Scenario: GetScenarioById
    * def projectId = 6354
    * def scenarioId = 78802
    And path '/api/projects/'+projectId+'/scenarios/'+scenarioId
    And header content-type = 'application/json'
    When method Get
    Then status 200
    Then print response

    Scenario: UpdateScenario
    * def projectId = 6354
    * def scenarioId = 78802
    And path '/api/projects/'+projectId+'/scenarios/'+scenarioId
    And header content-type = 'application/json'
    * def requestBody =
    """
    {
    "has_parameterized_class": false,
    "scenario_name": "postmanSenaryosuDegisti",
    "type": "SELENIUM",
    "testrail_enabled": false,
    "childs": [
    ],
    "enabled": true,
    "source_file": "ProductPage.spec",
    "java_test_class": "ProductPage",
    "deleted": false,
    "execute_mode": "AUTOMATED",
    "project_id": 6354,
    "parameterized": false,
    "plans": [
    ]
    }
    """
    And request requestBody
    When method Put
    Then status 200
    Then print response

    Scenario: GetChildScenarios
    * def projectId = 6354
    * def scenarioId = 78802
    And path '/api/projects/'+projectId+'/scenarios/'+scenarioId+'/childScenarios'
    And header content-type = 'application/json'
    When method Get
    Then status 200
    Then print response