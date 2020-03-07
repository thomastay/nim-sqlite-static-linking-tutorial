import strutils
import strformat
mode = ScriptMode.Verbose

let sqlite_CFLAGS = [
  # ----- Standard Flags autogen'd by configure. Can be ignored.
  "-DVERSION=\"3.31.1\"",
  "-DSTDC_HEADERS=1",
  "-DHAVE_SYS_TYPES_H=1",
  "-DHAVE_SYS_STAT_H=1",
  "-DHAVE_STDLIB_H=1",
  "-DHAVE_STRING_H=1",
  "-DHAVE_MEMORY_H=1",
  "-DHAVE_STRINGS_H=1",
  "-DHAVE_INTTYPES_H=1",
  "-DHAVE_STDINT_H=1",
  "-DHAVE_UNISTD_H=1",
  "-DHAVE_DLFCN_H=1",
  "-DHAVE_FDATASYNC=1",
  "-DHAVE_USLEEP=1",
  "-DHAVE_LOCALTIME_R=1",
  "-DHAVE_GMTIME_R=1",
  "-DHAVE_DECL_STRERROR_R=1",
  "-DHAVE_STRERROR_R=1",
  "-DHAVE_READLINE_READLINE_H=1",
  "-DHAVE_READLINE=1",
  "-DHAVE_POSIX_FALLOCATE=1",
  "-DHAVE_ZLIB_H=1",
  "-D_REENTRANT=1",
  # ----- Custom flags for sqlite, See the following links:
  #     https://www.sqlite.org/howtocompile.html
  #     https://www.sqlite.org/compile.html
  "-DSQLITE_THREADSAFE=2",  # Multithreaded, but a single db_conn is not thread safe
  "-DSQLITE_OMIT_LOAD_EXTENSION=1", # Dynamic linking turned off
  "-DSQLITE_DQS=0",   # Disable double quoted string literal bug
  "-DSQLITE_DEFAULT_MEMSTATUS=0",   # Disable memstatus
  "-DSQLITE_LIKE_DOESNT_MATCH_BLOBS",   # Optimize LIKE queries
  "-DSQLITE_MAX_EXPR_DEPTH=0",   # No limits of expression depth
  "-DSQLITE_OMIT_DECLTYPE",   # Optimize prepared statements
  "-DSQLITE_OMIT_DEPRECATED",   # No legacy code here
  "-DSQLITE_OMIT_PROGRESS_CALLBACK",   # Progress handler not used
  "-DSQLITE_OMIT_SHARED_CACHE",   # No shared cache used
  "-DSQLITE_USE_ALLOCA",   # Alloca is available
  "-DSQLITE_DEFAULT_WAL_SYNCHRONOUS=1",   # Use WAL mode
  # "-DSQLITE_HAVE_ZLIB",   # Zlib not used
  # "-DSQLITE_ENABLE_FTS3", # FTS3 not used
  # "-DSQLITE_ENABLE_FTS5", # FTS5 not used
  # "-DSQLITE_ENABLE_JSON1",  # Json not used
  # "-DSQLITE_ENABLE_RTREE",  # Rtree not used
  # "-DSQLITE_ENABLE_GEOPOLY", # Geopoly not used
  ]

let CC = "gcc"
let OPT = "Os"
let sqlite_cfile = "sqlite3.c"
let sqlite_ofile = "sqlite3.o"

# -------------- TASKS HERE ----------------------

task build_sqlite, "compile sqlite3 using custom options":
  if not fileExists(sqlite_cfile):
    echo """Download the sqlite3 file from here: https://www.sqlite.org/download.html"
    Then, run this command. It is not added to this git repo for size reasons"""
    raise newException(OSError, """sqlite3.c not found. 
    Download the sqlite3 file from here: https://www.sqlite.org/download.html"
    Then, run this command. It is not added to this git repo for size reasons""")
  let sqlite_CFLAGS_str = sqlite_CFLAGS.join(" ")
  exec fmt"{CC} -c -o {sqlite_ofile} -{OPT} {sqlite_CFLAGS_str} {sqlite_cfile}"

task static_sqlite, "statically link executable with sqlite3":
  if not fileExists(sqlite_ofile):
    build_sqliteTask()
  let sqlite_LFLAGS =fmt"{sqlite_ofile} -lm -pthread"
  --dynlibOverride:sqlite3
  switch("passL", sqlite_LFLAGS)
  setCommand "c"

