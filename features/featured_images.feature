Feature: Launch all featured images

  Background:
    Given "Test_user" as the persona

  Scenario Outline: Test all featured images
    Given I put <thing> in a blender,
    when I switch the blender on
    then it should transform into <other thing>

  Examples: Featured images
    | image                          |
    | Ubuntu 14.04.2 XFCE Base       |
    | Ubuntu 14.04 with Docker 1.7.x |
    | Ubuntu 14.04.3 NoGUI Base      |
    | functional genomics_v1.0       |
    | iPlant Centos 6.5 NoGUI Base3  |
