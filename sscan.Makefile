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
# Date    : Tuesday, September 18 11:56:26 CEST 2018
# version : 0.0.3

# LEGACY_RSET should be defined before driver.makefile
# require-ess from 3.0.1
LEGACY_RSET = YES

where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include $(E3_REQUIRE_TOOLS)/driver.makefile
include $(where_am_I)/../configure/DECOUPLE_FLAGS


APP:=sscanApp
APPDB:=$(APP)/Db
APPSRC:=$(APP)/src

USR_INCLUDES += -I$(where_am_I)$(APPSRC)

USR_CFLAGS   += -Wno-unused-variable
USR_CFLAGS   += -Wno-unused-function
USR_CFLAGS   += -Wno-unused-but-set-variable
USR_CPPFLAGS += -Wno-unused-variable
USR_CPPFLAGS += -Wno-unused-function
USR_CPPFLAGS += -Wno-unused-but-set-variable

# menuSscan doesn't have source file
DBDINC_SRCS += $(APPSRC)/scanparmRecord.c
DBDINC_SRCS += $(APPSRC)/sscanRecord.c

DBDINC_DBDS = $(subst .c,.dbd,   $(DBDINC_SRCS:$(APPSRC)/%=%))
DBDINC_HDRS = $(subst .c,.h,     $(DBDINC_SRCS:$(APPSRC)/%=%))
DBDINC_DEPS = $(subst .c,$(DEP), $(DBDINC_SRCS:$(APPSRC)/%=%))

HEADERS += $(APPSRC)/recDynLink.h
HEADERS += $(DBDINC_HDRS)
HEADERS += menuSscan.h

SOURCES += $(APPSRC)/recDynLink.c
SOURCES += $(APPSRC)/req_file.c

# SNCSEQ is always ON
SOURCES += $(APPSRC)/scanProg.st
SOURCES += $(APPSRC)/saveData_writeXDR.c
SOURCES += $(APPSRC)/writeXDR.c
# DBDINC_SRCS should be last of the series of SOURCES
SOURCES += $(DBDINC_SRCS)


DBDS += $(APPSRC)/sscanProgressSupport.dbd
DBDS += $(APPSRC)/sscanSupport.dbd

TEMPLATES += $(wildcard $(APPDB)/*.db)
#TEMPLATES += $(wildcard $(APPDB)/*.template)
#TEMPLATES += $(wildcard $(APPDB)/*.substitutions)

$(DBDINC_DEPS): $(DBDINC_HDRS) menuSscan.h

.dbd.h: 
	$(DBTORECORDTYPEH)  $(USR_DBDFLAGS) -o $@ $<



vpath %.dbd $(where_am_I)$(APPSRC)

menuSscan.h: menuSscan.dbd
	$(DBTOMENUH) $(USR_DBDFLAGS) -o $@ $<

# db rule is the default in RULES_E3, so add the empty one

db:

.PHONY: db
