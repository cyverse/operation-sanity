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
`time behave --processes 4 --parallel-element scenario`