#!/bin/bash
# Script to run a feature.
## It sets up the environment variables, including reading the user's password.


# ==========================================================================

## 1. Base URL

### CELERY-1
#export SANITYURL='https://celery-1.cyverse.org'

### ATMO-DEV
#export SANITYURL='https://atmo-dev.cyverse.org'

### ATMO-BETA
#export SANITYURL='https://atmobeta.cyverse.org'

### ATMO-PROD
#export SANITYURL='https://atmo.cyverse.org'

### JETSTREAM
#export SANITYURL='https://use.jetstream-cloud.org'

### JETSTREAM - TEST
export SANITYURL='https://atmosphere-jetstreamtestcloud.cyverse.org'


# ==========================================================================

## 2. Optional backdoor URL when in maintenance

#export SANITYURL=$SANITYURL/application_backdoor


# ==========================================================================

## 3. Browser
export SANITYBROWSER='chrome'
#export SANITYBROWSER='firefox'


# ==========================================================================

## 4. Screenshot directory
export SANITYSCREENSHOTDIR='/tmp/'


# ==========================================================================

## 5. Username

## CyVerse Users:
#export SANITYUSER='test-julianp'

## Jetstream Test Cloud Users:
export SANITYUSER='julianp2'

## Jetstream Users:
#export SANITYUSER='julianp2'


# ==========================================================================

## 6. Password
echo -n Password:
read -s SANITYPASS
echo
export SANITYPASS


# ==========================================================================

## 7. Environment

### Options:

# - All CyVerse Providers: cyverse
# - CyVerse Marana: cyverse-marana
# - CyVerse Workshop: cyverse-workshop
# - Jetstream Test Cloud: jetstream-test-cloud
# - All Jetstream Providers: jetstream
# - Jetstream Indiana: jetstream-indiana
# - Jetstream TACC: jetstream-tacc

echo -n "Environments:
- cyverse
- cyverse-marana
- cyverse-workshop
- jetstream-test-cloud
- jetstream
- jetstream-indiana
- jetstream-tacc

Choice: "
read SANITY_ENVIRONMENT
echo
export SANITY_ENVIRONMENT


# ==========================================================================

## 8. Action/Feature


### Launch instances
#export SANITY_FEATURE=features/unified_launch.feature

### Delete instances
export SANITY_FEATURE=features/delete-instances.feature


# ==========================================================================

## 8. Run features

behave --tags @persist_browser,@$SANITY_ENVIRONMENT $SANITY_FEATURE

