from behaving.web.steps import *
from behaving.sms.steps import *
from behaving.mail.steps import *
from behaving.notifications.gcm.steps import *
from behaving.personas.steps import *
from behaving.personas.persona import persona_vars

# @step(u'I fill field with class "{klass}" with the text "{text}"')
# @persona_vars
# def i_fill_in_field_with_class(context, xpath, text):
#     field = context.browser.find_by_xpath(xpath)
#     assert field, u'Element not found'
#     context.browser.fill(name, value)

@step('I set the value of the text area with class "{klass}" to "{contents}"')
@persona_vars
def set_text_value_of_element_with_class(context, klass, contents):
    assert context.browser.evaluate_script("document.getElementsByClassName('%s')[0].value = '%s'" % (klass, contents)), \
        u'Element not found or could not set value'


@step('I enable the submit feedback button')
@persona_vars
def enable_button_with_class(context):
    context.browser.evaluate_script("document.getElementsByClassName('btn btn-primary')[1].removeAttribute('disabled')")
    context.browser.evaluate_script("document.getElementsByClassName('btn btn-primary')[1].click()")