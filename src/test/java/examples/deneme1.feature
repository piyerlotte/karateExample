Feature: Create User Name

  Scenario: UserName with unique Name

  * def getDate =
  """
  function(){ return java.lang.Math.round(Math.random()*1000) }
"""

  * def time = getDate()

  * def userName = time
    * def requestBody =
    """
    {
    "description": "TEST",
  "enabled": true,
  "repository_path": "EndToEndDeneme",
  "test_framework": "SELENIUM",
  "test_file_type": "SELENIUM_JAVA",
  "test_runner_tool": "MAVEN",
  "company_id": 6289
}
    """
    * requestBody.project_name = userName
    * print requestBody