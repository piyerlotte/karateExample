Feature: upload deneme
##### EVE GİDİNCE DENE
  Scenario: Upload Mobile App
    And path '/api/file/automated-upload/android'
    * header Content-Type = 'multipart/form-data'
    * def json = {}
    * set json.myFile1 = { read: 'classpath:Files/kitapyurdu.apk' , filename: 'kitapyurdu.apk', Content-Type: 'application/vnd.android.package-archive' }
    * multipart files json
    And header Authorization = 'Bearer ' + token
    When method Post
    Then status 200

  Scenario: uploadMobileApp
    And path '/api/file/automated-upload/android'
    And header Content-Type = 'application/vnd.android.package-archive'
    And header Authorization = 'Bearer ' + token
    And header Current-Company-Id = 'multipart/form-data; boundary=<calculated when request is sent>'
    And multipart file myFile = { read: 'classpath:examples/Files/kitapyurdu.apk', filename:'kitapyurdu.apk', contentType: 'multipart/form-data' }
    When method POST
    Then status 200