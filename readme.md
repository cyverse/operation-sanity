##Welcome to Operation Sanity!

Operation Sanity is a set of behavior driven development tests for <a href="https://github.com/iPlantCollaborativeOpenSource/atmosphere">Atmosphere</a> implemented using <a href="https://github.com/behave/behave">Behave</a>, <a href="https://github.com/ggozad/behaving">Behaving</a>, and <a href="https://github.com/vishalm/behave-parallel">Behave-parallel</a>.

##How to run:

###Installation: 
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
To run normally:  
`behave cloud.feature`

To run parallel:  
`time behave --processes 4 --parallel-element scenario`

##To do:

###Easy: 
- get phantomJS working: "Given PhantomJS as the default browser"
	- probably have to add to requirements.txt
- how to launch into specific scenario within a big feature?
- parameterize cloud provider and project name as persona attributes

###Hard:

Use scenario outlines to cover all featured images at once

- https://pythonhosted.org/behave/tutorial.html cmnd-f for "Scenario Outlines"
- unique project names per scenario? 
- The process for checking all 5 featured images will look like:
	1. launch
	1. check 
	1. ssh (TBD)
	1. cleanup