##Welcome to Operation Sanity!

Operation Sanity is a set of behavior driven development tests for <a href="https://github.com/iPlantCollaborativeOpenSource/atmosphere">Atmosphere</a> implemented using <a href="https://github.com/behave/behave">Behave</a>, <a href="https://github.com/ggozad/behaving">Behaving</a>, and <a href="https://github.com/vishalm/behave-parallel">Behave-parallel</a>.

This repo provides tests for:

* Creating and deleting projects
* Launching, reporting, and deleting featured images
* Creating, reporting, and deleting volumes
* Creating and deleting external links
* Testing web shell operation 
* Submitting resource request ticket
* Submitting Atmosphere feedback

##How to run:

###Installation: 
1. Ensure you have firefox 46 installed
1. Clone this repo
1. Go to root of the project
1. Create a virtual env 

* `virtualenv env`
* `source env/bin/activate`
* `pip install -r requirements.txt`

Additionally, you'll also need to add these lines to your ~/.bash_profile:  
`export SANITYUSER=myAtmoUsername`  
`export SANITYPASS=myAtmoPassword`

Then source it:  
`source ~/.bash_profile`

###Run tests:
The test suite has been configured to be run using:  
`bash run.bash 2`  
where 2 is the max number of processes you want run.

###For reference:
To run a single feature:  
`behave launch.feature`

To run multiple scenarios in parallel:  
`time behave --processes 4 --parallel-element scenario`

To run a single scenario:  
`behave -n "Attach a volume"`

To run a single scenario within an outline:
`behave features/launch.feature:38`  
where 38 is the line number.

##To do:
### More urgent:
- automagically launch instances on all providers
- check if all instances are active
- test ssh and stuff in check_featured.feature - paramiko (hard)

### Less urgent:
- Test airport ui
- fix `@step(u'I enter instance name "{name}"')` and use it