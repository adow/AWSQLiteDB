# AWSQLiteDB

SQLiteDB wrapper in Swift 2.0

## 安装

### Carthage

`Carthage` 是一个去中心化的包管理工具。

安装 Carthage

	$ brew update
	$ brew install carthage
	
集成 AWSQLiteDB 到 iOS 项目

1. 在项目中创建 `Cartfile` 文件，并添加下面内容

		git "https://github.com/adow/AWSQLiteDB.git" >= 0.1.1
		
2. 运行 `Carthage update`, 获取 AWSQLiteDB;
3. 拖动 `Carthage/Build/iOS` 下面的 `AWSQLiteDB.framwork` 到项目 `Targets`, `General` 设置标签的 `Linked Frameworks and Linraries` 中；
4. 在 `Targes` 的 `Build Phases` 设置中，点击 `+` 按钮，添加 `New Run Script Phase` 来添加脚本:

		/usr/local/bin/carthage copy-frameworks
		
	同时在下面的 `Input Files` 中添加:

		$(SRCROOT)/Carthage/Build/iOS/AWSQLiteDB.framework

### Cocoapods

	source 'https://github.com/CocoaPods/Specs.git'
	platform :ios, '8.0'
	use_frameworks!
	
	pod 'AWSQLiteDB', '~> 0.1.1'

### 手动安装

#### 通过 Git Submodule 集成

通过 Submodule 将 SecrecySwift 作为 Embedded Framework 添加到项目中。

1. 首先确保项目已经在 git 仓库中;
2. 添加 `AWSQLiteDB` 作为 Submodule:

		git submodule add https://github.com/adow/AWSQLiteDB.git

3. 在 Xcode 中打开项目，将 AWSQLiteDB.xcodeproj 拖放到你的项目的根目录下;
4. 在你的项目下，选择 `Targets` , `General` 中添加 `Embedded Binaries`, 选择 `AWSQLiteDB.framework`, 确保 `Build Phases` 中的 `Link Binary with Libraries` 中有 `AWSQLiteDB.framework`;

#### 或者直接使用 AWSQLiteDB.swift

1. 复制 AWSQLiteDB.swift 到项目中
2. 在项目的 `Targets` 的 `Build Phases` 的 `Link Binary with Libraries` 中添加 `libsqlite3.0.tbd`;


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

