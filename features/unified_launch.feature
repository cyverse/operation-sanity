Feature: Launch instances

  @persist_browser
  Scenario: Log into Atmosphere
    Given a browser
    When I login to Atmosphere

  @persist_browser
  Scenario Outline: Launch instances
    When we skip the scenario outline example based on the tags
    Given a browser
    Then I create project "<project>" if necessary
    And I migrate resources to project "<project>" if necessary
    When I go to "/application/projects"
    Then I should see an element with xpath "//h2[contains(string(), '<project>')]" within 10 seconds
    When I press the element with xpath "//h2[contains(string(), '<project>')]"
    Then I should see an element with xpath "//h1[contains(string(), '<project>')]" within 10 seconds
    And I should skip this scenario if I see an instance with "<instance-name>" and provider "<provider>"
    When I go to "/application/images"
    And I migrate resources to project "<project>" if necessary
    Then I should see "Image Search" within 60 seconds
    And I should see an element with the css selector ".form-control" within 10 seconds
    When I enter "<image-search>" to "0" index of class "form-control"
    Then I should see "<image-name>" within 120 seconds
    When I press the element with xpath "//h2[contains(string(), '<image-name>')]"
    Then I should see an element with the css selector ".launch-button" within 10 seconds
    And element with xpath "//button[contains(@class, 'launch-button')]" should be enabled within 5 seconds
    When I press the element with xpath "//button[contains(@class, 'launch-button')]"
    And I should see "Launch an Instance / Basic Options" within 60 seconds
    And I should see "alloted GBs of Memory" within 10 seconds
    When I choose option "<provider>" from dropdown with label "Provider"
    And I choose option "<size>" from dropdown with label "Instance Size"
    And I choose option "<project>" from dropdown with label "Project"
    And I fill in instance name with "<instance-name>"
    And I press "Launch Instance"
    Then I should see "LAUNCHING" within 5 seconds
    And I should not see "LAUNCHING" within 60 seconds
    And I should see an instance with "<instance-name>" and provider "<provider>" within 10 seconds

    Examples: "Marana Cloud", @cyverse, @cyverse-marana
      | project | image-search              | image-name                     | instance-name           | provider               | size  |
      | BDD-01  | ubuntu 14.04.2 xfce       | Ubuntu 14.04.2 XFCE Base       | ubuntu_14_gui_marana    | CyVerse Cloud - Marana | tiny1 |
      | BDD-01  | cyverse centos 6.8 gui    | CyVerse CentOS 6.8 GUI Base    | centos_6_gui_marana     | CyVerse Cloud - Marana | tiny1 |
      | BDD-01  | ubuntu 16.04 gui xfce     | Ubuntu 16.04 GUI XFCE Base     | ubuntu_16_gui_marana    | CyVerse Cloud - Marana | tiny1 |
      | BDD-01  | ubuntu 14.04 docker 1.7.x | Ubuntu 14.04 with Docker 1.7.x | ubuntu_14_docker_marana | CyVerse Cloud - Marana | tiny1 |
      | BDD-01  | software carpentry        | Software Carpentry 06-07-2016  | soft_carp_marana        | CyVerse Cloud - Marana | tiny1 |


    Examples: "iPlant Workshop Cloud", @cyverse, @cyverse-workshop
      | project | image-search              | image-name                     | instance-name             | provider                       | size  |
      | BDD-02  | ubuntu 14.04.2 xfce       | Ubuntu 14.04.2 XFCE Base       | ubuntu_14_gui_workshop    | iPlant Workshop Cloud - Tucson | tiny1 |
      | BDD-02  | cyverse centos 6.8 gui    | CyVerse CentOS 6.8 GUI Base    | centos_6_gui_workshop     | iPlant Workshop Cloud - Tucson | tiny1 |
      | BDD-02  | ubuntu 16.04 gui xfce     | Ubuntu 16.04 GUI XFCE Base     | ubuntu_16_gui_workshop    | iPlant Workshop Cloud - Tucson | tiny1 |
      | BDD-02  | ubuntu 14.04 docker 1.7.x | Ubuntu 14.04 with Docker 1.7.x | ubuntu_14_docker_workshop | iPlant Workshop Cloud - Tucson | tiny1 |
      | BDD-02  | functional genomics       | functional genomics_v1.0       | func_gen_workshop         | iPlant Workshop Cloud - Tucson | tiny1 |
      | BDD-02  | software carpentry        | Software Carpentry 06-07-2016  | soft_carp_workshop        | iPlant Workshop Cloud - Tucson | tiny1 |


    Examples: "Jetstream Test Cloud", @jetstream-test-cloud
      | project | image-search  | image-name                     | instance-name | provider             | size  |
      | BDD-03  | ubuntu 14 gui | Ubuntu-14.04.3-Development-GUI | ubuntu_gui_14 | Jetstream Test Cloud | small |
      | BDD-03  | centos 7 gui  | CentOS-7.4-Development-GUI     | centos_gui_7  | Jetstream Test Cloud | small |
      | BDD-03  | ubuntu 14     | ubuntu-14.04                   | ubuntu_14     | Jetstream Test Cloud | small |
      | BDD-03  | ubuntu 16     | ubuntu-16.04                   | ubuntu_16     | Jetstream Test Cloud | small |
      | BDD-03  | centos 6      | centos-6                       | centos_6      | Jetstream Test Cloud | small |
      | BDD-03  | centos 7      | centos-7                       | centos_7      | Jetstream Test Cloud | small |


    Examples: "Jetstream IU", @jetstream, @jetstream-indiana
      | project | image-search              | image-name                     | instance-name              | provider                       | size      |
      | BDD-04  | ubuntu 16 devel docker    | Ubuntu 16.04 Devel and Docker  | ubuntu_16_devel_and_docker | Jetstream - Indiana University | m1.small  |
      | BDD-04  | ubuntu 14 development gui | Ubuntu 14.04.3 Development GUI | ubuntu_14_dev_gui          | Jetstream - Indiana University | m1.small  |
      | BDD-04  | centos 7 development gui  | Centos 7 (7.3) Development GUI | centos_7_dev_gui           | Jetstream - Indiana University | m1.small  |
      | BDD-04  | r intel compilers         | R with Intel compilers         | r_with_intel_compilers     | Jetstream - Indiana University | m1.small  |
      | BDD-04  | centos 6 development gui  | CentOS 6 (6.9) Development GUI | centos_6_dev_gui           | Jetstream - Indiana University | m1.small  |
      | BDD-04  | biolinux                  | BioLinux 8                     | biolinux_8                 | Jetstream - Indiana University | m1.small  |
      | BDD-04  | matlab centos             | MATLAB (Based on CentOS 6)     | matlab_centos_6            | Jetstream - Indiana University | m1.medium |


    Examples: "Jetstream TACC", @jetstream, @jetstream-tacc
      | project | image-search              | image-name                     | instance-name              | provider         | size      |
      | BDD-05  | ubuntu 16 devel docker    | Ubuntu 16.04 Devel and Docker  | ubuntu_16_devel_and_docker | Jetstream - TACC | m1.small  |
      | BDD-05  | ubuntu 14 development gui | Ubuntu 14.04.3 Development GUI | ubuntu_14_dev_gui          | Jetstream - TACC | m1.small  |
      | BDD-05  | centos 7 development gui  | Centos 7 (7.3) Development GUI | centos_7_dev_gui           | Jetstream - TACC | m1.small  |
      | BDD-05  | r intel compilers         | R with Intel compilers         | r_with_intel_compilers     | Jetstream - TACC | m1.small  |
      | BDD-05  | centos 6 development gui  | CentOS 6 (6.9) Development GUI | centos_6_dev_gui           | Jetstream - TACC | m1.small  |
      | BDD-05  | biolinux                  | BioLinux 8                     | biolinux_8                 | Jetstream - TACC | m1.small  |
      | BDD-05  | matlab centos             | MATLAB (Based on CentOS 6)     | matlab_centos_6            | Jetstream - TACC | m1.medium |

