#!/bin/ksh

# JBoss EAP stop script for AIX
JBOSS_HOME={{ jboss_home }}

# Stop JBoss domain
$JBOSS_HOME/bin/jboss-cli.sh --connect :shutdown
