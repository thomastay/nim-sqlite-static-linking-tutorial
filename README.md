# A guide to static linking sqlite3 in Nim

This is currently WIP

Static linking is possible with the command static\_sqlite in the config.nims file.

Run this command

```
nim static_sqlite sql_test.nim
```

You need to have the sqlite3.c amalgamation file downloaded and in this repository. If you don't have it, the static\_sqlite task will prompt you on how to download it


If you want to run the command line, this is the command that makes it work:

```
nim c --dynlibOverride:sqlite3 --passL:"sqlite.o -lm -pthread" sql_test.nim
```
