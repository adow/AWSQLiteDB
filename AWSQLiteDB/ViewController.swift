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
        let rows_2 = db.execute(sql_select_2)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController {
    private func test_c(){
        let cache_dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let db_filename = "\(cache_dir)/test.db"
        NSLog("db_filename:%@", db_filename)
        var err_message : UnsafeMutablePointer<Int8> = nil
        var db :COpaquePointer = nil
        var rc = sqlite3_open(db_filename,&db)
        NSLog("rc:%d", rc)
        let sql_db = "create table company (id integer PRIMARY KEY AUTOINCREMENT,name CHAR(32) NOT NULL)"
        rc = sqlite3_exec(db, sql_db, nil, nil, &err_message)
        NSLog("rc:%d", rc)
        var m = String.fromCString(err_message)
        print(m)
        let sql_insert = "insert into company (name) values('aaa')"
        rc = sqlite3_exec(db, sql_insert, nil, nil, &err_message)
        NSLog("rc:%d", rc)
        m = String.fromCString(err_message)
        print(m)
        let sql_select = "select * from company"
        rc = sqlite3_exec(db, sql_select, nil, nil, &err_message)
        NSLog("rc:%d", rc)
        m = String.fromCString(err_message)
        print(m)
        var statement : COpaquePointer = nil
        rc = sqlite3_prepare_v2(db, "insert into company (name) values (?)", -1, &statement, nil)
        NSLog("rc:%d", rc)
        rc = sqlite3_bind_text(statement, 1, "adow", -1, SQLITE_TRANSIENT)
//        rc = sqlite3_bind_text(statement, 1, NSString(string: "adow").UTF8String, -1, nil)
//        rc = sqlite3_bind_text(statement, 1, "adow", -1, nil)
        NSLog("rc:%d", rc)
        rc = sqlite3_step(statement)
        NSLog("rc:%d", rc)
        m = String.fromCString(sqlite3_errmsg(db))
        print(m)
        
        var statement_query : COpaquePointer = nil
        rc = sqlite3_prepare_v2(db, "select * from company", -1, &statement_query, nil)
        sqlite3_step(statement_query)
        
    }
}

