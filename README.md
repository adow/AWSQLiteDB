# AWSQLiteDB

SQLiteDB wrapper in Swift 2.0

## 安装

### Carthage

### Cocoapods

### 手动安装

## 使用

### 打开数据库

	let cache_dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
	let db_filename = "\(cache_dir)/sql.db"
	let db = SQLiteDB(path: db_filename)
    
### 关闭数据库

SQLiteDB 实例被释放的时候会自动关闭数据库

	db.close
	
### 打开单例的数据库

	let cache_dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
	let db_filename = "\(cache_dir)/sql.db"
	guard let _ = try? SQLiteDB.setupSharedDBPath(db_filename) else {
	    return
	}
	
### 执行 Execute

创建数据库

	var sql = "create table test (id INTEGER PRIMARY KEY AUTOINCREMENT, name CHAR(32) NOT NULL)"
	print("create table:\(SQLiteDB.sharedDB.execute(sql))")
	
Insert

	sql = "insert into test (id,name) values (?,?)"
	var result = SQLiteDB.sharedDB.execute(sql, parameters:9, "adow")
	print("insert:\(result)")
	
update

	sql = "update test set name=? where id =?"
	result = SQLiteDB.sharedDB.execute(sql, parameters: "reynold qin",9)
	print("update:\(result)")
	
### 查询 Query

	sql = "select * from test"
	let rows = SQLiteDB.sharedDB.query(sql)
	for r in rows {
	    let id = r["id"]!.value!.integer!
	    let name = r["name"]!.value!.string!
	    print("\(id):\(name)")
	}

