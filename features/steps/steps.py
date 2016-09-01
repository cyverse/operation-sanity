from behaving.web.steps import *
from behaving.sms.steps import *
from behaving.mail.steps import *
from behaving.notifications.gcm.steps import *
from behaving.personas.steps import *
from behaving.personas.persona import persona_vars
import time

APPLICATION_BACKDOOR = '/application_backdoor'


@step(u'I wait for instance to become active')
def i_wait_for_instance(context):
    if context.browser.is_element_present_by_css("[class='instance-status-light']"):
        while True:
            if context.browser.is_element_present_by_css("[class='instance-status-light active']") or context.browser.is_element_present_by_css("[class='instance-status-light inactive']"):
                assert context.browser.is_element_present_by_css("[class='instance-status-light active']"), u'Instance failed to deploy'
                break
            time.sleep(15)

@step(u'I type slowly "{value}" to "{index}" index of class "{klass}"')
def i_type_to_index_of_class(context, klass, value, index):
    name = "temp_form_name" + str(index)
    assert context.browser.evaluate_script("document.getElementsByClassName('%s')[%s].name = '%s'" % (klass, index, name)), \
        u'Element not found or could not set name'
    for key in context.browser.type(name, value, slowly=True):
        assert key

@step(u'I ask for "{resources}" resources for "{reason}" reason')
def i_request_resources(context, resources, reason):
    klass = "form-control" # this is the class for both of the textarea elements

    # fill in resources
    name1 = "resource-box"
    assert context.browser.evaluate_script("document.getElementsByClassName('%s')[0].name = '%s'" % (klass, name1)), \
        u'Element not found or could not set name'
    for key in context.browser.type(name1, resources, slowly=True):
        assert key

    # fill in request reason
    name2 = "reason-box"
    assert context.browser.evaluate_script("document.getElementsByClassName('%s')[2].name = '%s'" % (klass, name2)), \
        u'Element not found or could not set name'
    for key in context.browser.type(name2, reason, slowly=True):
        assert key

@step(u'I press span "{span}"')
def i_press_span(context, span):
    element = context.browser.find_by_xpath( "//*[@class='section-link']//span[contains(string(), '%s')]" % (span))
    assert element, u'Element not found'
    element.first.click()

@step(u'I press Options span')
def i_press_options(context):
    element = context.browser.find_by_xpath( "//*//span[contains(string(), 'Options')]")
    assert element, u'Element not found'
    element.first.click()

@step(u'I press Delete span')
def i_press_delete(context):
    element = context.browser.find_by_xpath( "//*[@class='section-link danger']")
    assert element, u'Element not found'
    element.first.click()

@step(u'I should see and press "{name}" within {timeout:d} seconds')
def i_should_see_and_press_within_timeout(context, name, timeout):
    assert context.browser.is_text_present(name, wait_time=timeout), u'Text not found'
    element = context.browser.find_by_xpath(
        ("//*[@id='%(name)s']|"
         "//*[@name='%(name)s']|"
         "//button[contains(string(), '%(name)s')]|"
         "//input[@type='button' and contains(string(), '%(name)s')]|"
         "//input[@type='button' and contains(@value, '%(name)s')]|"
         "//input[@type='submit' and contains(@value, '%(name)s')]|"
         "//a[contains(string(), '%(name)s')]") % {'name': name})
    assert element, u'Element not found'
    element.first.click()

@step(u'I double-check that I press "{name}"')
def i_should_see_and_press_within_timeout(context, name):
    element = context.browser.find_by_xpath(
        ("//*[@id='%(name)s']|"
         "//*[@name='%(name)s']|"
         "//button[contains(string(), '%(name)s')]|"
         "//input[@type='button' and contains(string(), '%(name)s')]|"
         "//input[@type='button' and contains(@value, '%(name)s')]|"
         "//input[@type='submit' and contains(@value, '%(name)s')]|"
         "//a[contains(string(), '%(name)s')]") % {'name': name})
    if element:
        element.first.click()

@step(u'I login to Atmosphere')
def i_login_to_atmo(context):
    # visit URL
    context.browser.visit(os.environ['SANITYURL'])
    # Only press login if we're not using a backdoor
    if os.environ['SANITYURL'].endswith(APPLICATION_BACKDOOR):
        return
    # press login
    assert context.browser.is_text_present('Login', wait_time=10), u'Text not found'
    name = 'Login'
    element = context.browser.find_by_xpath(
        ("//*[@id='%(name)s']|"
         "//*[@name='%(name)s']|"
         "//button[contains(string(), '%(name)s')]|"
         "//input[@type='button' and contains(string(), '%(name)s')]|"
         "//input[@type='button' and contains(@value, '%(name)s')]|"
         "//input[@type='submit' and contains(@value, '%(name)s')]|"
         "//a[contains(string(), '%(name)s')]") % {'name': name})
    assert element, u'Element not found'
    element.first.click()
    # enter info
    context.browser.fill("username", os.environ.get('SANITYUSER'))
    context.browser.fill("password", os.environ.get('SANITYPASS'))
    # press LOGIN
    name = "LOGIN"
    element = context.browser.find_by_xpath(
        ("//*[@id='%(name)s']|"
         "//*[@name='%(name)s']|"
         "//button[contains(string(), '%(name)s')]|"
         "//input[@type='button' and contains(string(), '%(name)s')]|"
         "//input[@type='button' and contains(@value, '%(name)s')]|"
         "//input[@type='submit' and contains(@value, '%(name)s')]|"
         "//a[contains(string(), '%(name)s')]") % {'name': name})
    assert element, u'Element not found'
    element.first.click()

@step(u'I choose "{value}" from Project dropdown')
def i_choose_in_project_dropdown(context, value):
    name = "bdd-project"
    assert context.browser.evaluate_script("document.getElementsByClassName('form-control')[2].name = '%s'" % (name)), \
        u'Element not found or could not set name'
    elem = context.browser.driver.find_element_by_name(name)
    assert elem, u'Element not found'
    select = Select(elem)
    select.select_by_visible_text(value)

@step(u'I choose provider "{provider}" from Provider dropdown')
def i_choose_in_provider_dropdown(context, provider):
    name = "bdd-provider"
    assert context.browser.evaluate_script("document.getElementsByClassName('form-control')[3].name = '%s'" % (name)), \
        u'Element not found or could not set name'
    elem = context.browser.driver.find_element_by_name(name)
    assert elem, u'Element not found'
    select = Select(elem)
    # sometimes a non-printing space unicode character gets appended
    if not provider[-1].isalpha():
        provider = provider[:-1]
    select.select_by_visible_text(provider)    

@step(u'I enter the Web Shell')
def i_enter_web_shell(context):
    name = "Open Web Shell"
    assert context.browser.evaluate_script("document.getElementsByTagName('a')[25].target = '_self'"), \
        u'Element not found or could not set name'
    element = context.browser.find_by_xpath("//*[contains(., 'Open Web Shell')]")
    assert element, u'Element not found'
    element.first.click()

@step(u'I scroll down {pixels} pixels')
def i_scroll_down(context, pixels):
    #while not find_visible_by_css(context, (("a[href*='%s']") % ID)):
    #    context.browser.evaluate_script("window.scrollBy(0, 100)")
    context.browser.evaluate_script("window.scrollBy(0, %s);" % pixels)

# This step is a monster because behave-parallel does not have context.execute_steps implemented
# otherwise this function is about 10 lines
@step(u'I create project "{project}" if necessary')
def i_create_project(context, project):
    #see and press "Projects"
    name = 'Projects'
    assert context.browser.is_text_present(name, wait_time=10), u'Text not found'
    element = context.browser.find_by_xpath(
        ("//*[@id='%(name)s']|"
         "//*[@name='%(name)s']|"
         "//button[contains(string(), '%(name)s')]|"
         "//input[@type='button' and contains(string(), '%(name)s')]|"
         "//input[@type='button' and contains(@value, '%(name)s')]|"
         "//input[@type='submit' and contains(@value, '%(name)s')]|"
         "//a[contains(string(), '%(name)s')]") % {'name': name})
    assert element, u'Element not found'
    element.first.click()

    if not context.browser.is_element_present_by_xpath("//h2[contains(., '%s')]" % project):
        # Then I should see and press "Create New Project" within 10 seconds
        name = "Create New Project"
        assert context.browser.is_text_present(name, wait_time=10), u'Text not found'
        element = context.browser.find_by_xpath(
            ("//*[@id='%(name)s']|"
            "//*[@name='%(name)s']|"
            "//button[contains(string(), '%(name)s')]|"
            "//input[@type='button' and contains(string(), '%(name)s')]|"
            "//input[@type='button' and contains(@value, '%(name)s')]|"
            "//input[@type='submit' and contains(@value, '%(name)s')]|"
            "//a[contains(string(), '%(name)s')]") % {'name': name})
        assert element, u'Element not found'
        element.first.click()

        # Then I should see "Project Name" within 10 seconds
        name = "Create New Project"
        assert context.browser.is_text_present(name, wait_time=10), u'Text not found'

        # And I type slowly "%s" to "0" index of class "form-control"
        name = "temp_form_name_0"
        assert context.browser.evaluate_script("document.getElementsByClassName('form-control')[0].name = '%s'" % (name)), \
            u'Element not found or could not set name'
        for key in context.browser.type(name, project, slowly=True):
            assert key
        
        # And I type slowly "%s" to "1" index of class "form-control"
        name = "temp_form_name_1"
        assert context.browser.evaluate_script("document.getElementsByClassName('form-control')[1].name = '%s'" % (name)), \
            u'Element not found or could not set name'
        for key in context.browser.type(name, project, slowly=True):
            assert key

        # And I press "submitCreateProject"
        name = "submitCreateProject"
        element = context.browser.find_by_xpath(
            ("//*[@id='%(name)s']|"
            "//*[@name='%(name)s']|"
            "//button[contains(string(), '%(name)s')]|"
            "//input[@type='button' and contains(string(), '%(name)s')]|"
            "//input[@type='button' and contains(@value, '%(name)s')]|"
            "//input[@type='submit' and contains(@value, '%(name)s')]|"
            "//a[contains(string(), '%(name)s')]") % {'name': name})
        assert element, u'Element not found'
        element.first.click()

        # Then I should see "%s" within 10 seconds
        assert context.browser.is_text_present(project, wait_time=10), u'Text not found'