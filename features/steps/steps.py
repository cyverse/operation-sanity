from behaving.web.steps import *
from behaving.sms.steps import *
from behaving.mail.steps import *
from behaving.notifications.gcm.steps import *
from behaving.personas.steps import *
from behaving.personas.persona import persona_vars

# Working nuclear version
@step(u'I type "{value}" to class "{klass}"')
@persona_vars
def i_type_to_class(context, klass, value):
    name = "temp_form_name"
    assert context.browser.evaluate_script("document.getElementsByClassName('%s')[0].name = '%s'" % (klass, name)), \
        u'Element not found or could not set name'
    for key in context.browser.type(name, value, slowly=True):
        assert key
