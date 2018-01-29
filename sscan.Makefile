#
#  Copyright (c) 2017 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# Author  : Jeong Han Lee
# email   : han.lee@esss.se
# Date    : Tuesday, November 28 16:46:46 CET 2017
# version : 0.0.1

where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include $(E3_REQUIRE_TOOLS)/driver.makefile

APP:=sscanApp
APPDB:=$(APP)/Db
APPSRC:=$(APP)/src

USR_INCLUDES += -I$(where_am_I)/$(APPSRC)

#TEMPLATES += $(wildcard $(APPDB)/*.template)


USR_CFLAGS   += -Wno-unused-variable
USR_CFLAGS   += -Wno-unused-function
USR_CFLAGS   += -Wno-unused-but-set-variable
USR_CPPFLAGS += -Wno-unused-variable
USR_CPPFLAGS += -Wno-unused-function
USR_CPPFLAGS += -Wno-unused-but-set-variable

HEADERS += $(APPSRC)/recDynLink.h
HEADERS += scanparmRecord.h
HEADERS += sscanRecord.h
HEADERS += menuSscan.h


SOURCES += $(APPSRC)/saveData.c
SOURCES += $(APPSRC)/xdr_lib.c
SOURCES += $(APPSRC)/scanProg.st
SOURCES += $(APPSRC)/req_file.c
SOURCES += $(APPSRC)/recDynLink.c
SOURCES += $(APPSRC)/sscanRecord.c
SOURCES += $(APPSRC)/scanparmRecord.c


DBDS += $(APPSRC)/sscanSupport.dbd
DBDS += $(APPSRC)/sscanProgressSupport.dbd
# Warning: skipping duplicate file menuSscan.dbd from command line
# DBDS += $(APPSRC)/menuSscan.dbd

vpath %.dbd   $(where_am_I)/$(APPSRC)


scanparmRecord$(DEP): sscanRecord.h scanparmRecord.h menuSscan.h

USR_DBDFLAGS += -I . -I ..

%.h: %.dbd
	$(DBTORECORDTYPEH)  $(USR_DBDFLAGS) -o $@ $<


menuSscan.h: menuSscan.dbd
	$(DBTOMENUH) $(USR_DBDFLAGS) -o $@ $<





TEMPLATES += $(wildcard $(APPDB)/*.db)
#TEMPLATES += $(wildcard $(APPDB)/*.template)
#TEMPLATES += $(wildcard $(APPDB)/*.substitutions)


# db rule is the default in RULES_E3, so add the empty one

db:
