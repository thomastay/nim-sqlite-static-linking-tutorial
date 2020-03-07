# A guide to static linking sqlite3 in Nim

This is currently WIP

Static linking is possible with the command static\_sqlite in the config.nims file.

This is the command that makes it work:

```
nim c --dynlibOverride:sqlite3 --passL:"sqlite.o -lm -pthread" sql_test.nim
```
