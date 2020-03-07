import db_sqlite

# user, password, database name can be empty.
# These params are not used on db_sqlite module.
let db = open("test.db", "", "", "")
db.exec(sql"""CREATE TABLE IF NOT EXISTS my_table (
                 id   INTEGER,
                 name VARCHAR(50) NOT NULL
              )""")
db.close()
