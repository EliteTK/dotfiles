#!/usr/bin/env python2
from subprocess import check_output

def password(account, domain):
    return check_output("pass mail/" + account + "@" + domain, shell=True).rstrip().split('\n')[0]
