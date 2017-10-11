import os

import time
import tempfile
try:
    from urlparse import urlparse, urlunsplit
except ImportError:
    from urllib.parse import urlparse, urlunsplit

from behaving import environment as benv
from selenium.webdriver.chrome.options import Options
from datetime import datetime

# Flip this value to 'True' to enable a debugger on step-failure.
BEHAVE_DEBUG_ON_ERROR = os.environ.get('SANITYDEBUG', False)
WORKSPACE_ROOT = os.path.abspath(os.path.dirname(__file__)+"/..")
default_screenshot_dir = os.path.join(WORKSPACE_ROOT, 'reports/screenshots')
SCREENSHOT_DIR = os.environ['SANITYSCREENSHOTDIR'] if os.environ.get('SANITYSCREENSHOTDIR') \
        else os.path.join(WORKSPACE_ROOT, 'reports/screenshots')

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


def create_scenario_screenshot(context, scenario):
    # create_scenario_screenshot(context, scenario)
    now = datetime.now()
    prefix = "%s-%sScenario-%s-%s-" % (
            now.strftime("%Y%m%d_%H%M"),
            scenario.status.title(),
            scenario.feature.name,
            scenario.name)
    try:
        return _create_screenshot(context, prefix, ".png")
    except:
        pass
    return

def create_step_screenshot(context, step):
    now = datetime.now()
    prefix = "%s-%sStep-%s %s%s-" %  (
            now.strftime("%Y%m%d_%H%M"),
            step.status.title(), step.keyword, step.name,
            "_ERROR: %s" % step.error_message if step.status == 'failed' else ""
        )
    return _create_screenshot(context, prefix, ".png")

def _create_screenshot(context, prefix, suffix):
    if not os.path.exists(SCREENSHOT_DIR):
        os.makedirs(SCREENSHOT_DIR)
    (fd, filename) = tempfile.mkstemp(prefix=prefix, suffix=suffix, dir=SCREENSHOT_DIR)
    context.browser.driver.get_screenshot_as_file(filename)
    return filename

def after_step(context, step):
    """
    https://pythonhosted.org/behave/tutorial.html#debug-on-error-in-case-of-step-failures
    """
    if step.status == "failed":
        create_step_screenshot(context, step)
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
        print('Scenario %s Failed. Put a breakpoint here to inspect stuff' % scenario.name)
        if context.screenshots_dir and hasattr(context, 'browser'):
            create_scenario_screenshot(context, scenario)
    if 'persist_browser' not in scenario.tags:
        benv.after_scenario(context, scenario)


def get_base_url(url):
    """
    Get base URL from a URL (i.e. just the scheme & hostname)
    """
    url_parts = urlparse(url)
    base_url = urlunsplit((url_parts.scheme, url_parts.hostname, '', '', ''))
    return base_url
