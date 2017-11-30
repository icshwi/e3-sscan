# e3-sscan

## add new version of sscan

* Edit configure/CONFIG

From tags/R2-10.1 to tags/R2-11
From LIBVERSION 2.10.1 to 2.11.0

* Check version via
```
make env
make init
```

* Build and Install
```
make rebuild
```

```
 tree -L 2 /epics/modules/sscan/
/epics/modules/sscan/
├── [root     4.0K]  2.10.2
│   └── [root     4.0K]  R3.15.5
└── [root     4.0K]  2.11.0
    └── [root     4.0K]  R3.15.5
	```

## Uninstall a version of sscan


* Check the version

```
make env
```
* Run make uninstall to remove that version of sscan

```
make uninstall
make[1]: Entering directory '/home/jhlee/e3/e3-sscan/sscan'
rm -rf /epics/modules/sscan/2.11.0
make[1]: Leaving directory '/home/jhlee/e3/e3-sscan/sscan'

```
