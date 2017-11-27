
where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include $(REQUIRE_TOOLS)/driver.makefile

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
#SOURCES += $(APPSRC)/scanProg.st
SOURCES += $(APPSRC)/req_file.c
SOURCES += $(APPSRC)/recDynLink.c
SOURCES += $(APPSRC)/sscanRecord.c
SOURCES += $(APPSRC)/scanparmRecord.c
#SOURCES   += $(APPSRC)/scanProg.st


DBDS += $(APPSRC)/sscanSupport.dbd
DBDS += $(APPSRC)/sscanProgressSupport.dbd
DBDS += $(APPSRC)/menuSscan.dbd

vpath %.dbd   $(where_am_I)/$(APPSRC)


scanparmRecord$(DEP): sscanRecord.h scanparmRecord.h menuSscan.h

USR_DBDFLAGS += -I . -I ..


%.h: %.dbd
	$(DBTORECORDTYPEH)  $(USR_DBDFLAGS) -o $@ $<


menuSscan.h: menuSscan.dbd
	$(DBTOMENUH) $(USR_DBDFLAGS) -o $@ $<
