from behaving.web.steps import *
from behaving.sms.steps import *
from behaving.mail.steps import *
from behaving.notifications.gcm.steps import *
from behaving.personas.steps import *
from behaving.personas.persona import persona_vars

@when(u'I login to Atmosphere')
@persona_vars
def i_login_to_atmo(context):
    context.execute_steps(u'''
        When I visit "$Atmosphere"
        And I press "Login"
        And I fill in "username" with "$username"
        And I fill in "password" with "$password"
        And I press "LOGIN"
    ''')

@step(u'I type "{value}" to class "{klass}"')
@persona_vars
def i_type_to_class(context, klass, value):
    name = "temp_form_name"
    assert context.browser.evaluate_script("document.getElementsByClassName('%s')[0].name = '%s'" % (klass, name)), \
        u'Element not found or could not set name'
    for key in context.browser.type(name, value, slowly=True):
        assert key

@step(u'I type slowly "{value}" to "{index}" index of class "{klass}"')
@persona_vars
def i_type_to_index_of_class(context, klass, value, index):
    name = "temp_form_name" + str(index)
    assert context.browser.evaluate_script("document.getElementsByClassName('%s')[%s].name = '%s'" % (klass, index, name)), \
        u'Element not found or could not set name'
    for key in context.browser.type(name, value, slowly=True):
        assert key

@step(u'I ask for "{resources}" resources for "{reason}" reason')
@persona_vars
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
@persona_vars
def i_press_span(context, span):
    element = context.browser.find_by_xpath( "//*[@class='section-link']//span[contains(string(), '%s')]" % (span))
    assert element, u'Element not found'
    element.first.click()

@step(u'I press Options span')
@persona_vars
def i_press_options(context):
    element = context.browser.find_by_xpath( "//*//span[contains(string(), 'Options')]")
    assert element, u'Element not found'
    element.first.click()

@step(u'I press Delete span')
@persona_vars
def i_press_delete(context):
    element = context.browser.find_by_xpath( "//*[@class='section-link danger']")
    assert element, u'Element not found'
    element.first.click()

@step(u'I should see and press "{name}" within {timeout:d} seconds')
@persona_vars
def should_see_and_press_within_timeout(context, name, timeout):
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

@step(u'I enter my Atmosphere username and password')
@persona_vars
def i_fill_in_atmo_credentials(context):
        context.browser.fill("username", os.environ.get('SANITYUSER'))
        context.browser.fill("password", os.environ.get('SANITYPASS'))

@step(u'I choose "{value}" from Project dropdown')
@persona_vars
def i_choose_in_radio(context, value):
    name = "temp-bdd-name"
    assert context.browser.evaluate_script("document.getElementsByClassName('form-control')[2].value = '%s'" % (value)), \
        u'Element not found or could not set name'
    #assert context.browser.evaluate_script("document.getElementsByClassName('form-control')[2].name = '%s'" % (name)), \
    #    u'Element not found or could not set name'
    #context.browser.choose(name, value)


@step(u'I enter the Web Shell')
@persona_vars
def i_enter_web_shell(context):
    name = "Open Web Shell"
    assert context.browser.evaluate_script("document.getElementsByTagName('a')[25].target = '_self'"), \
        u'Element not found or could not set name'
    element = context.browser.find_by_xpath("//a[contains(string(), 'Open Web Shell')]")
    assert element, u'Element not found'
    element.first.click()

# this function is broken
@step(u'I enter instance name "{name}"')
@persona_vars
def i_enter_instance_name(context, name):
    assert context.browser.evaluate_script('document.getElementById("instanceName").innerHMTL = "%s"' % name), \
        u'Element not found or could not set name'
    assert True
