#!/usr/bin/env python
import gammu

sm = gammu.StateMachine()
sm.ReadConfig()
sm.Init()
print "Initiated!"
status = sm.GetSMSStatus()
used = status['SIMUsed'] + status['PhoneUsed']

start = True
while used > 0:
    if start:
        sms = sm.GetNextSMS(Start=True, Folder=0)
        start=False
    else:
        #print sms[0]
        sms = sm.GetNextSMS(Location=sms[0]['Location'], Folder=0)
        used = used-len(sms)
        
    #print sms[len(sms)-1]

    for m in sms:
        if m['InboxFolder']==1:
            print m
