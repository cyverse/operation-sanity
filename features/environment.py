import os

import time

try:
    from urlparse import urlparse, urlunsplit
except ImportError:
    from urllib.parse import urlparse, urlunsplit

from behaving import environment as benv
from selenium.webdriver.chrome.options import Options


# Flip this value to 'True' to enable a debugger on step-failure.
BEHAVE_DEBUG_ON_ERROR = False
WORKSPACE_ROOT = os.path.abspath(os.path.dirname(__file__)+"/..")
SCREENSHOT_DIR = os.path.join(WORKSPACE_ROOT, 'reports/screenshots')

def before_all(context):
    benv.before_all(context)
    context.screenshots_dir = os.environ.get('SANITYSCREENSHOTDIR')
    context.default_browser = os.environ.get('SANITYBROWSER', '')
    if context.default_browser.lower() == 'chrome_headless':
        context.default_browser = 'chrome'
        options = Options()
        options.binary_location = '/usr/bin/google-chrome'
        options.add_argument('headless')
        options.add_argument('diable-gpu')
        context.browser_args = {
            'options': options,
        }
    context.base_url = get_base_url(os.environ['SANITYURL'])

def after_all(context):
    benv.after_all(context)


def after_step(context, step):
    """
    https://pythonhosted.org/behave/tutorial.html#debug-on-error-in-case-of-step-failures
    """
    if step.status == "failed":
        if not os.path.exists(SCREENSHOT_DIR):
            os.makedirs(SCREENSHOT_DIR)
        sshot_prefix = "FailedStep:%s FailedMessage:%s ss_" %  (step.name, step.error_message)
        sshot_path = os.path.join(SCREENSHOT_DIR, sshot_prefix)
        context.browser.screenshot(sshot_path)
        if BEHAVE_DEBUG_ON_ERROR:
            # -- ENTER DEBUGGER: Zoom in on failure location.
            import ipdb
            ipdb.post_mortem(step.exc_traceback)


def before_feature(context, feature):
    benv.before_feature(context, feature)


def after_feature(context, feature):
    benv.after_feature(context, feature)


def before_scenario(context, scenario):
    if 'persist_browser' not in scenario.tags:
        benv.before_scenario(context, scenario)


def after_scenario(context, scenario):
    if scenario.status == 'failed':
        print('Failed. Put a breakpoint here to inspect stuff')
        if context.screenshots_dir and hasattr(context, 'browser'):
            filename = scenario.feature.name + u'-' + \
                       scenario.name + u'-' + \
                       time.strftime("%Y-%m-%d-%H%M%S", time.gmtime(time.time()))
            filename = os.path.join(context.screenshots_dir, filename)
            try:
                context.browser.screenshot(filename)
            except:
                pass
    if 'persist_browser' not in scenario.tags:
        benv.after_scenario(context, scenario)


def get_base_url(url):
    """
    Get base URL from a URL (i.e. just the scheme & hostname)
    """
    url_parts = urlparse(url)
    base_url = urlunsplit((url_parts.scheme, url_parts.hostname, '', '', ''))
    return base_url
