from behaving.mail.steps import *
from behaving.personas.persona import persona_vars
from behaving.personas.steps import *
from behaving.web.steps import *
from behaving.web.steps.basic import _retry

APPLICATION_BACKDOOR = '/application_backdoor'


@step(u'I wait for instance to become active')
def i_wait_for_instance(context):
    if context.browser.is_element_present_by_css("[class='instance-status-light']"):
        while True:
            if context.browser.is_element_present_by_css("[class='instance-status-light active']") or context.browser.is_element_present_by_css("[class='instance-status-light inactive']"):
                assert context.browser.is_element_present_by_css("[class='instance-status-light active']"), u'Instance failed to deploy'
                break
            time.sleep(15)


@step(u'I wait up to {timeout:d} seconds for instance with name "{name}" and provider "{provider}" to finish building')
@step(u'I wait for instance with name "{name}" and provider "{provider}" to finish building')
def wait_for_instance_to_finish_building(context, name, provider, timeout=60):
    xpath_no_status = "//tr[contains(td[2], '{}') and contains(td[7], '{}')]".format(name, provider)
    assert context.browser.is_element_present_by_xpath(xpath_no_status, wait_time=20), u'No such instance'
    building_status = 'build'
    xpath_with_status = "//tr[contains(td[2], '{}') and contains(td[7], '{}') and contains(td[3], '{}')]".format(name,
                                                                                                                 provider,
                                                                                                                 building_status)
    assert context.browser.is_element_present_by_xpath(xpath_with_status), u'Instance is not building'
    assert context.browser.is_element_not_present_by_xpath(xpath_with_status,
                                                           wait_time=timeout), u'Instance has not finished building'


@step(u'I should skip this scenario if I see an instance with "{name}" and provider "{provider}"')
def skip_if_see_instance(context, name, provider):
    xpath = "//tr[contains(td[2], '{}') and contains(td[7], '{}')]".format(name, provider)
    if context.browser.is_element_present_by_xpath(xpath):
        context.scenario.skip('An instance with name "{}" and provider "{}" already exists'.format(name, provider))



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
    element_xpath = "//*[@id='%(name)s']|" \
                    "//*[@name='%(name)s']|" \
                    "//button[contains(string(), '%(name)s')]|" \
                    "//input[@type='button' and contains(string(), '%(name)s')]|" \
                    "//input[@type='button' and contains(@value, '%(name)s')]|" \
                    "//input[@type='submit' and contains(@value, '%(name)s')]|" \
                    "//a[contains(string(), '%(name)s')]" % {'name': name}
    assert context.browser.is_element_visible_by_xpath(element_xpath, wait_time=10)
    element = context.browser.find_by_xpath(element_xpath)
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
    if not os.environ['SANITYURL'].endswith(APPLICATION_BACKDOOR):
        # Press Login in Troposphere UI
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


@step(u'I login to Jetstream')
def i_login_to_jetstream(context):
    # visit URL
    context.browser.visit(os.environ['SANITYURL'])
    # Only press login if we're not using a backdoor
    if not os.environ['SANITYURL'].endswith(APPLICATION_BACKDOOR):
        # Press Login in Troposphere UI
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
    context.execute_steps(u'''When I press "login-btn"''')
    context.browser.fill('login', os.environ.get('SANITYUSER'))
    context.browser.fill('password', os.environ.get('SANITYPASS'))
    # press: Sign In
    context.execute_steps(u'''When I press "Sign In"''')

@step(u'I choose "{value}" from Project dropdown')
def i_choose_in_project_dropdown(context, value):
    name = "bdd-project"
    assert context.browser.evaluate_script("document.getElementsByClassName('form-control')[2].name = '%s'" % (name)), \
        u'Element not found or could not set name'
    elem = context.browser.driver.find_element_by_name(name)
    assert elem, u'Element not found'
    select = Select(elem)
    select.select_by_visible_text(value)


@step(u'I choose option "{option}" from dropdown with label "{label}"')
def i_choose_in_provider_dropdown(context, option, label):
    elem = context.browser.find_by_xpath(
        "//label[contains(string(), '{}')]/following-sibling::select[1]/option[contains(string(), '{}')]".format(
            label, option))
    option = elem[0]
    option._element.click()

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


@step(u'I migrate resources to project "{project}" if necessary')
def migrate_resources_if_necessary(context, project):
    modal_xpath = "//div[@class='modal-header']//h1[contains(string(), 'Migrate Resources')]"
    modal = context.browser.find_by_xpath(modal_xpath)
    if not modal:
        return
    old_url = context.browser.url
    context.execute_steps(u'''When I choose "{}" from "project"'''.format(project))
    context.execute_steps(u'''When I press "Move resources into project"''')
    context.execute_steps(u'''Then I should not see an element with xpath "{}" within 3 seconds'''.format(modal_xpath))
    context.execute_steps(u'''Then I go to "{}"'''.format(old_url))


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
        assert context.browser.is_element_visible_by_xpath("//div[@class='modal-body']//input[@type='text']",
                                                           wait_time=10)
        element = context.browser.find_by_xpath("//div[@class='modal-body']//input[@type='text']")
        assert element, u'Element not found'
        for key in element.first.type(project, slowly=True):
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


@step(u'"{name}" should be enabled within {timeout:d} seconds')
@persona_vars
def is_enabled(context, name, timeout):
    el = context.browser.find_by_xpath(
        ("//*[@id='%(name)s']|"
         "//*[@name='%(name)s']") % {'name': name})
    assert el, u'Element not found'
    element = el.first

    check = lambda: element._element.is_enabled()
    assert _retry(check, timeout), u'Element is not enabled'


@step(u'element with xpath "{xpath}" should be enabled within {timeout:d} seconds')
@persona_vars
def is_enabled(context, xpath, timeout):
    el = context.browser.find_by_xpath(xpath)
    assert el, u'Element not found'
    element = el.first

    check = lambda: element._element.is_enabled()
    assert _retry(check, timeout), u'Element is not enabled'
