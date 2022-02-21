Feature: CreateToken
  Background: 
    * url 'https://account.testinium.com'
    @POST @createToken
    Scenario: CreateToken
      * path '/uaa/oauth/token'
      * param grant_type = 'password'
      * param username = 'mahir.avci@testinium.com'
      * param password = 'Testinium123'
      * header Authorization = 'Basic dGVzdGluaXVtU3VpdGVUcnVzdGVkQ2xpZW50OnRlc3Rpbml1bVN1aXRlU2VjcmV0S2V5'
      * method POST
      * status 200
      * def token = response.access_token