import os

try:
    from urlparse import urlparse, urlunsplit
except ImportError:
    from urllib.parse import urlparse, urlunsplit

from behaving import environment as benv

def before_all(context):
    benv.before_all(context)
    context.default_browser = os.environ.get('SANITYBROWSER', '')
    context.base_url = get_base_url(os.environ['SANITYURL'])

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


def get_base_url(url):
    """
    Get base URL from a URL (i.e. just the scheme & hostname)
    """
    url_parts = urlparse(url)
    base_url = urlunsplit((url_parts.scheme, url_parts.hostname, '', '', ''))
    return base_url
