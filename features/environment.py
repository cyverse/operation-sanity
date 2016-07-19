import os
from behaving import environment as benv

PERSONAS = {
    'Test_user': dict(
            username=os.environ.get('SANITYUSER'),
            password=os.environ.get('SANITYPASS'),
            Atmosphere="https://atmo.iplantcollaborative.org/application"
        )
}


def before_all(context):
    benv.before_all(context)


def after_all(context):
    benv.after_all(context)


def before_feature(context, feature):
    benv.before_feature(context, feature)


def after_feature(context, feature):
    benv.after_feature(context, feature)


def before_scenario(context, scenario):
    benv.before_scenario(context, scenario)
    context.personas = PERSONAS

def after_scenario(context, scenario):
    benv.after_scenario(context, scenario)
