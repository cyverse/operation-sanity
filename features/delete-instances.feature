Feature: Delete specified running instances

  @persist_browser
  Scenario: Log into Atmosphere
    Given a browser
    When I login to Atmosphere

  @persist_browser
  Scenario Outline: Delete instances
    When we skip the scenario outline example based on the tags
    Given a browser
    When I go to "/application/projects"
    Then I should see an element with xpath "//h2[contains(string(), '<project>')]" within 10 seconds
    When I press the element with xpath "//h2[contains(string(), '<project>')]"
    Then I should see an element with xpath "//h1[contains(string(), '<project>')]" within 10 seconds
    And I wait for 2 seconds
    And I should skip this scenario if I do not see an instance with name "<instance-name>" and provider "<provider>"
    When I press the checkbox for name "<instance-name>" and provider "<provider>"
    And I press the delete button
    Then I should see an element with xpath "//h1[contains(string(), 'Delete Instance')]" within 2 seconds
    And I should see "The following instance will be shut down and all data will be permanently lost"
    When I press "Yes, delete this instance"
    Then I wait for instance with name "<instance-name>" and provider "<provider>" to start deleting

    Examples: "Marana Cloud", @cyverse, @cyverse-marana
      | project | image-search           | image-name                    | instance-name           | provider               | size  |
      | BDD-01  | ubuntu 14.04.2 xfce    | Ubuntu 14.04.2 XFCE Base      | ubuntu_14_gui_marana    | CyVerse Cloud - Marana | tiny1 |
      | BDD-01  | cyverse centos 6.8 gui | CyVerse CentOS 6.8 GUI Base   | centos_6_gui_marana     | CyVerse Cloud - Marana | tiny1 |
      | BDD-01  | ubuntu 16.04 gui xfce  | Ubuntu 16.04 GUI XFCE Base    | ubuntu_16_gui_marana    | CyVerse Cloud - Marana | tiny1 |
      | BDD-01  | ubuntu 14_04 docker ce | Ubuntu 14_04 w Docker CE      | ubuntu_14_docker_marana | CyVerse Cloud - Marana | tiny1 |
      | BDD-01  | software carpentry     | Software Carpentry 06-07-2016 | soft_carp_marana        | CyVerse Cloud - Marana | tiny1 |


    Examples: "iPlant Workshop Cloud", @cyverse, @cyverse-workshop
      | project | image-search           | image-name                    | instance-name             | provider                       | size  |
      | BDD-02  | ubuntu 14.04.2 xfce    | Ubuntu 14.04.2 XFCE Base      | ubuntu_14_gui_workshop    | iPlant Workshop Cloud - Tucson | tiny1 |
      | BDD-02  | cyverse centos 6.8 gui | CyVerse CentOS 6.8 GUI Base   | centos_6_gui_workshop     | iPlant Workshop Cloud - Tucson | tiny1 |
      | BDD-02  | ubuntu 16.04 gui xfce  | Ubuntu 16.04 GUI XFCE Base    | ubuntu_16_gui_workshop    | iPlant Workshop Cloud - Tucson | tiny1 |
      | BDD-02  | ubuntu 14_04 docker ce | Ubuntu 14_04 w Docker CE      | ubuntu_14_docker_workshop | iPlant Workshop Cloud - Tucson | tiny1 |
      | BDD-02  | functional genomics    | functional genomics_v1.0      | func_gen_workshop         | iPlant Workshop Cloud - Tucson | tiny1 |
      | BDD-02  | software carpentry     | Software Carpentry 06-07-2016 | soft_carp_workshop        | iPlant Workshop Cloud - Tucson | tiny1 |


    Examples: "Jetstream Test Cloud", @jetstream-test-cloud
      | project | image-search  | image-name                     | instance-name | provider             | size  |
      | BDD-03  | ubuntu 14 gui | Ubuntu-14.04.3-Development-GUI | ubuntu_gui_14 | Jetstream Test Cloud | small |
      | BDD-03  | centos 7 gui  | CentOS-7.4-Development-GUI     | centos_gui_7  | Jetstream Test Cloud | small |
      | BDD-03  | ubuntu 14     | ubuntu-14.04                   | ubuntu_14     | Jetstream Test Cloud | small |
      | BDD-03  | ubuntu 16     | ubuntu-16.04                   | ubuntu_16     | Jetstream Test Cloud | small |
      | BDD-03  | centos 6      | centos-6                       | centos_6      | Jetstream Test Cloud | small |
      | BDD-03  | centos 7      | centos-7                       | centos_7      | Jetstream Test Cloud | small |


    Examples: "Jetstream IU", @jetstream, @jetstream-indiana
      | project | image-search               | image-name                     | instance-name              | provider                       | size      |
      | BDD-04  | ubuntu 16 devel docker     | Ubuntu 16.04 Devel and Docker  | ubuntu_16_devel_and_docker | Jetstream - Indiana University | m1.small  |
      | BDD-04  | ubuntu 14 development gui  | Ubuntu 14.04.3 Development GUI | ubuntu_14_dev_gui          | Jetstream - Indiana University | m1.small  |
      | BDD-04  | centos 7 development gui   | Centos 7 (7.4) Development GUI | centos_7_dev_gui           | Jetstream - Indiana University | m1.small  |
      | BDD-04  | r intel compilers          | R with Intel compilers         | r_with_intel_compilers     | Jetstream - Indiana University | m1.small  |
      | BDD-04  | centos 6.9 development gui | CentOS 6 (6.9) Development GUI | centos_6_dev_gui           | Jetstream - Indiana University | m1.small  |
      | BDD-04  | biolinux                   | BioLinux 8                     | biolinux_8                 | Jetstream - Indiana University | m1.small  |
      | BDD-04  | matlab centos              | MATLAB (Based on CentOS 6)     | matlab_centos_6            | Jetstream - Indiana University | m1.medium |


    Examples: "Jetstream TACC", @jetstream, @jetstream-tacc
      | project | image-search               | image-name                     | instance-name              | provider         | size      |
      | BDD-05  | ubuntu 16 devel docker     | Ubuntu 16.04 Devel and Docker  | ubuntu_16_devel_and_docker | Jetstream - TACC | m1.small  |
      | BDD-05  | ubuntu 14 development gui  | Ubuntu 14.04.3 Development GUI | ubuntu_14_dev_gui          | Jetstream - TACC | m1.small  |
      | BDD-05  | centos 7 development gui   | Centos 7 (7.4) Development GUI | centos_7_dev_gui           | Jetstream - TACC | m1.small  |
      | BDD-05  | r intel compilers          | R with Intel compilers         | r_with_intel_compilers     | Jetstream - TACC | m1.small  |
      | BDD-05  | centos 6.9 development gui | CentOS 6 (6.9) Development GUI | centos_6_dev_gui           | Jetstream - TACC | m1.small  |
      | BDD-05  | biolinux                   | BioLinux 8                     | biolinux_8                 | Jetstream - TACC | m1.small  |
      | BDD-05  | matlab centos              | MATLAB (Based on CentOS 6)     | matlab_centos_6            | Jetstream - TACC | m1.medium |
