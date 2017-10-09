#!/usr/bin/env python
import os
import sys
import getpass
import argparse
from subprocess import (
    Popen, PIPE,
    check_output, CalledProcessError
)

# CONSTANTS -- Update these values as more features, environments,
# and/or browsers are added to Operation Sanity
BROWSERS = ['chrome_headless', 'chrome', 'firefox']
ENVIRONMENTS = [
    "cyverse",
    "cyverse-marana",
    "cyverse-workshop",
    "jetstream",
    "jetstream-indiana",
    "jetstream-tacc",
    "jetstream-test-cloud"
]
FEATURES = [
    "unified_launch.feature",
    "delete-instances.feature"
]


def select_from_choices(title, choice_list):
    while True:
        total = len(choice_list) - 1
        for idx, choice in enumerate(choice_list):
            print "%d: %s" % (idx, choice)
        selection = raw_input(
            "Select a choice for '%s' [0 - %d, q to quit]" % total)
        try:
            if 'q' in selection:
                sys.exit(1)
            selection = int(selection)
        except ValueError:
            print "Invalid Selection: '%s'" % selection
            continue
        if idx < 0 or idx >= len(choice_list):
            continue
        selected_item = choice_list[selection]
        break
    return selected_item


def main():
    # Argparse
    parser = argparse.ArgumentParser(
        description="Add a new cloud provider and adminstrator")

    parser.add_argument(
        "server_url",
        help="Select the Servers URL where tests will be executed.")
    parser.add_argument(
        "username",
        help="Select the Username to execute tests with.")
    parser.add_argument(
        "--browser",
        help="Select the browser where tests will be executed.")
    parser.add_argument(
        "--feature",
        help="Select the feature-set of tests will be executed.")
    parser.add_argument(
        "--environment",
        help="Select the environment where tests will be executed.")
    parser.add_argument(
        "--screenshot-dir", default="/tmp",
        help="Screenshots stored here in the event of a test failure.")
    parser.add_argument(
        "--skip-checks", action='store_true',
        help="Skip pre-flight checks (Xvfb process running, etc.)")
    arguments = parser.parse_args()
    # Pre-flight checks (validation, system tests)
    if '://' not in arguments.server_url:
        raise Exception("Error: Missing 'scheme://' prefix for server_url: %s"
                        % arguments.server_url)
    if not arguments.skip_checks:
        _run_preflight_tests()
    arguments = _request_user_input(arguments)
    if not arguments.skip_checks:
        _run_argument_validation(arguments)
    return _run_behave_tests(arguments)


def _run_argument_validation(arguments):
    """
    This might be overkill. Open to removal.
    """
    selected_environment = arguments.environment.lower()
    selected_server = arguments.server_url.lower()
    if 'jetstreamtestcloud' in selected_server \
            and 'jetstream-test-cloud' not in selected_environment:
        raise Exception(
            "Error: Selected server includes 'jetstreamtestcloud', "
            "but not using a jetstream-test-cloud test environment.")
    elif 'jetstream' in selected_server \
            and 'jetstream' not in selected_environment:
        raise Exception(
            "Error: Selected server includes 'jetstream', "
            "but not using a jetstream test environment.")
    elif 'cyverse' in selected_server \
            and 'cyverse' not in selected_environment:
        raise Exception(
            "Error: Selected server includes 'cyverse', "
            "but not using a cyverse test environment.")
    return True


def _run_preflight_tests():
    xvfb_running = _is_process_running('Xvfb')
    if not xvfb_running:
        raise Exception(
            "Runtime Error: Xvfb was not found running on this machine."
            "Please start Xvfb or run with '--skip-checks' to continue.")
    return True


def _is_process_running(process_name):
    """
    Verify whether or not celery workers are running
    return True/False
    """
    if not process_name:
        raise ValueError("No process_name provided. Nothing to grep for.")

    ps = Popen(
        ['ps', 'aux'], stdout=PIPE)
    try:
        grepable_process_name = "[%s]%s" % (process_name[0], process_name[1:])
        output = check_output(
            ['grep', grepable_process_name], stdin=ps.stdout)
        return output is not ""
    except CalledProcessError:
        # Grep returns exit-code 1 if no match
        return False


def _request_user_input(arguments):
    if not getattr(arguments, 'browser'):
        arguments.browser = select_from_choices(
            'Browser', BROWSERS)
    if not getattr(arguments, 'feature'):
        arguments.feature = select_from_choices(
            'Feature', FEATURES)

    # Allows omission of 'features/'
    if 'features/' not in arguments.feature:
        arguments.feature = 'features/' + arguments.feature

    if not getattr(arguments, 'environment'):
        arguments.environment = select_from_choices(
            'Environment', ENVIRONMENTS)
    if 'SANITYPASS' in os.environ:
        arguments.password = os.environ['SANITYPASS']
    else:
        arguments.password = getpass.getpass(
            "Password for user %s:" % arguments.username)
    return arguments


def _run_behave_tests(arguments):
    script_environ = os.environ.copy()
    script_environ['SANITYURL'] = arguments.server_url
    script_environ['SANITYBROWSER'] = arguments.browser
    script_environ['SANITYUSER'] = arguments.username
    script_environ['SANITYPASS'] = arguments.password
    script_environ['SANITYSCREENSHOTDIR'] = arguments.screenshot_dir

    behave_test_command = [
        'behave', '--tags',
        "@persist_browser,@%s" % arguments.environment,
        arguments.feature
    ]

    print "Executing Command: %s" % " ".join(behave_test_command)
    proc = Popen(behave_test_command, shell=True, env=script_environ)
    returncode = proc.wait()
    if returncode != 0:
        print "Warning: Behave returned a non-zero exit status"
        sys.exit(returncode)


if __name__ == "__main__":
    main()
