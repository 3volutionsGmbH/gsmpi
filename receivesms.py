#!/usr/bin/env python

from __future__ import print_function
import os, sys, re
from config import *
import sendgrid
from sendgrid.helpers.mail import *

# def get_message():
#     files = [os.path.join('/var/spool/gammu/inbox/', m) for m in sys.argv[1:]]
#     files.sort() # make sure we get the parts in the right order
#     number = re.match(r'^IN\d+_\d+_\d+_(.*)_\d+\.txt', os.path.split(files[0])[1]).group(1) 
#     text = ''
#     for f in files:
#         text += open(f, 'r').read()
#     try:
#         text = text.decode('UTF-8', 'strict')
#     except UnicodeDecodeError:
#         text = text.decode('UTF-8', 'replace')
#     return number, text
# 
# number, text = get_message()

sg = sendgrid.SendGridAPIClient(apikey=sendgrid_api_key)
from_email = Email(sendgrid_from)
to_email = Email(sendgrid_to)
subject = "Sending with SendGrid is Fun"
content = Content("text/plain", "and easy to do anywhere, even with Python")
mail = Mail(from_email, subject, to_email, content)

response = sg.client.mail.send.post(request_body=mail.get())
print(response.status_code)
print(response.body)
print(response.headers)
