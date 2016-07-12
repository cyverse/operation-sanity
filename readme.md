##Welcome to Operation Sanity!

Operation Sanity is a set of behavior driven development tests for <a href="https://github.com/iPlantCollaborativeOpenSource/atmosphere">Atmosphere</a> implemented using <a href="https://github.com/behave/behave">Behave</a>, <a href="https://github.com/ggozad/behaving">Behaving</a>, and <a href="https://github.com/vishalm/behave-parallel">Behave-parallel</a>.

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
To run normally:  
`behave cloud.feature`

To run parallel:  
`time behave --processes 4 --parallel-element scenario`

To run a single scenario:
`behave -n "Attach a volume"`


##To do:

###Easy: 
- get phantomJS working instead of firefox: "Given PhantomJS as the default browser"
	- probably have to add to requirements.txt
	- this is maybe hard
	- maybe make the browser choice a persona attribute
- make launch instance scenario also name the instance "BDD-Instance"
- parameterize cloud provider and project name as persona attributes
- Test airport ui


###Hard:

Use scenario outlines to cover all featured images at once

- https://pythonhosted.org/behave/tutorial.html cmnd-f for "Scenario Outlines"
- unique project names per scenario? 
- not sure how well the outlines would play with our parallelization
	- maybe outlines are a poor choice
- The process for checking all 5 featured images will look like:
	1. launch
	1. check 
	1. ssh <--hard to do item
	1. cleanup