//
//  ViewController.swift
//  TestSqliteSwift
//
//  Created by 秦 道平 on 15/12/4.
//  Copyright © 2015年 秦 道平. All rights reserved.
//

import UIKit
import AWSQLiteDB

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.testSharedDB()
        self.testDB()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private lazy var db_filename : String = "\(NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0])/test.db"
}
extension ViewController {
    private func testDB(){
        /// Open database, which will be created if not existed
        guard let _ = try? SQLiteDB.setupSharedDBPath(db_filename) else {
            NSLog("open db failed")
            return
        }
        /// create table
        var sql = "create table test (id INTEGER PRIMARY KEY AUTOINCREMENT, name CHAR(32) NOT NULL)"
        print("create table:\(SQLiteDB.sharedDB.execute(sql))")
        /// insert
        sql = "insert into test (id,name) values (?,?)"
        var result = SQLiteDB.sharedDB.execute(sql, parameters:9, "adow")
        print("insert:\(result)")
        /// update 
        sql = "update test set name=? where id =?"
        result = SQLiteDB.sharedDB.execute(sql, parameters: "reynold qin",9)
        print("update:\(result)")
        /// select 
        sql = "select * from test"
        let rows = SQLiteDB.sharedDB.query(sql)
        for r in rows {
            let id = r["id"]!.value!.integer!
            let name = r["name"]!.value!.string!
            print("\(id):\(name)")
        }
        
    }
}
