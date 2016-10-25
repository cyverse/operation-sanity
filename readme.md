## Welcome to Operation Sanity!

Operation Sanity is a set of behavior driven development tests for <a href="https://github.com/iPlantCollaborativeOpenSource/atmosphere">Atmosphere</a> implemented using <a href="https://github.com/behave/behave">Behave</a>, <a href="https://github.com/ggozad/behaving">Behaving</a>, and <a href="https://github.com/vishalm/behave-parallel">Behave-parallel</a>.

This repo provides tests for:

* Creating and deleting projects
* Launching all 5 featured images on all 3 providers
* Ensuring those instances launch
* Reporting and deleting featured images
* Creating, reporting, and deleting volumes
* Creating and deleting links
* Testing web shell operation
* Submitting resource request ticket
* Submitting Atmosphere feedback

## How to run:

### Installation:
1. You have a choice of using Firefox or Chromium, and your chosen browser must be installed on the same system you're running Operation Sanity from. If using Firefox and the tests don't run, you may need to downgrade to a version of Firefox supported by Selenium. As of September 1 2016, Firefox 48 works with Linux, but Firefox 46 is required for OS X. You can find older versions of Firefox at https://ftp.mozilla.org/pub/firefox/releases/.
1. Clone this repo
1. Go to root of the project
1. Create a virtual env

* `virtualenv env`
* `source env/bin/activate`
* `pip install -r requirements.txt`

### Set Up Environment Variables

#### Initial Setup
The test suite looks for three environment variables which tell it how to log into Atmosphere. The URL can be any installation of Atmosphere.

You can persistently store the username and URL in your ~/.bash_profile (OS X) or ~/.bashrc (Linux):
`export SANITYUSER=myAtmoUsername`  
`export SANITYURL="https://atmo.cyverse.org"`  

The first time you run the test suite, you'll need to populate the environment with `source ~/.bash_profile` (OS X) or `source ~/.bashrc` (Linux). (In the future, new terminal windows will have the environment populated automatically.)

#### Preparation for Each Run
Before you run the test suite, you also need to populate an environment variable containing your Atmosphere password. Enter this on the command line:

`export SANITYPASS=myAtmoPassword`  

Please do not store your Atmosphere password persistently in plaintext.

If using Chromium, set the SANITYBROWSER environment variable. (Firefox will be used if this is not set.)

`export SANITYBROWSER=chrome`


### Run tests:
The test suite has been configured to be run using:  
`time bash run.bash 2`  
where 2 is the max number of processes you want run.

Alternatively, the script can be used as a guidebook for running each step of the test suite individually. Open run.bash in a text editor and manually copy each step into the command line. You'll have to manually change the `$PROCESSES` variable to the number of processes you want to run, usually 2-4.

### Reference:
To launch a bunch of instances specified by GUID and name:
`behave features/launch-by-guid.feature`

To run a single feature:  
`behave features/launch.feature`

To run multiple scenarios in parallel (good for outlines):  
`behave --processes 4 --parallel-element scenario`

To run multiple features in parallel:  
`behave --processes 4 --parallel-element feature`

To run a single scenario:  
`behave -n "Attach a volume"`

To run a single scenario within an outline:
`behave features/launch.feature:38`  
where 38 is the line number.

## FAQ:

**Q.** The script breaks after a "This application is not authorized to use CAS" page loads after logging in.  
**A.**  Restart your tests. I'm not sure why this happens.

**Q.** I get an error:  
`Instance could not be launched 504:`
`Multiple connection attempts to the provider`
`29ee80ff-ab20-441e-a752-da682e1d40e3 have failed. `
`Please try again later.`  
**A.** This usually happens when you run the script with 4 or more processes. Try re-running run.bash with an argument of 2.

**Q.** My tests are erroring out with:
`Element is not clickable at point (764.683349609375, 25). Other element would receive the click: <div style="display: block;" class="modal fade in" data-reactid=".2"></div>`  
**A.** This is caused by a modal that says: `Looks like you have some resources that aren't in a project!`  This happens when you leave the page soon after launching an instance, or you delete a project soon after deleting an instance within that project. If the problem persists you can add `I wait for 30 seconds` steps after launching or deleting an instance.

**Q.** Why not use personas?  
**A.** Behave-parallel doesn't have `context.execute_steps` implemented, which personas make heavy use of. This is also why some steps in steps.py are enormous.

Some of the scenarios use the `@persist_browser` tag, which does not destroy browser state between scenarios (as configured in `environment.py`).

## To do:
- test ssh functionality in test.feature using paramiko
