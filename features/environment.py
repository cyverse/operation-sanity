import os

from behaving import environment as benv

def before_all(context):
    benv.before_all(context)
    context.default_browser = os.environ.get('SANITYBROWSER', '')

def after_all(context):
    benv.after_all(context)


def before_feature(context, feature):
    benv.before_feature(context, feature)


def after_feature(context, feature):
    benv.after_feature(context, feature)


def before_scenario(context, scenario):
    if 'persist_browser' not in scenario.tags:
        benv.before_scenario(context, scenario)


def after_scenario(context, scenario):
    if 'persist_browser' not in scenario.tags:
        benv.after_scenario(context, scenario)
