//
//  ViewController.swift
//  TestSqliteSwift
//
//  Created by 秦 道平 on 15/12/4.
//  Copyright © 2015年 秦 道平. All rights reserved.
//

import UIKit

let SQLITE_STATIC = unsafeBitCast(0, sqlite3_destructor_type.self)
let SQLITE_TRANSIENT = unsafeBitCast(-1, sqlite3_destructor_type.self)

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let cache_dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let db_filename = "\(cache_dir)/sql.db"
        NSLog("db_filename:%@", db_filename)
        let db = SQLiteDB(path: db_filename)
        db.open()
        let sql_createtable = "create table test (id INTEGER PRIMARY KEY AUTOINCREMENT, name CHAR(32) NOT NULL)"
        var result = db.execute(sql_createtable)
        print("\(result)")
        let sql_insert = "insert into test (id,name) values (?,?)"
        result = db.execute(sql_insert, parameters:9, "adow")
        print("\(result)")
        let sql_select = "select * from test"
        let rows = db.query(sql_select)
        for r in rows {
            let id = r["id"]!.value!.integer!
            let name = r["name"]!.value!.string!
            print("\(id):\(name)")
        }
        let sql_select_2 = "select * from test"
        db.execute(sql_select_2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
