//
//  LJSQLiteManager.swift
//  ceshiFmdb
//
//  Created by ljkj on 2018/8/8.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit
import FMDB

/// 数据库最大存放时间
private let maxDBCacheTime = -5*24*60*60

/// sqlite 管理器
/**
 1.数据库本质上保存在沙河中的一个文件，首先需要创建和打开数据库
    fmdb.db
 2.创建数据表
 3.增删改查
 提示:数据库开发，程序代码几乎是一致的，区别在sqlit语句
 开发数据库功能的时候，一定要在测试sqlit的正确性
 */

class LJSQLiteManager {
    
    /// 单例， 全局数据库访问点
    static let shared = LJSQLiteManager()
    /// 数据库队列
    let queue:FMDatabaseQueue
    
    /// 避免外部访问 构造函数
    private init() {
        
        // 数据的路径
        let dbname = "status.db"
        var path =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        path = (path as NSString).appendingPathComponent(dbname)
        print("数据库的路径+\(path)")
       // 创建数据库队列,同时创建打开表
        queue = FMDatabaseQueue(path: path)
        // 创建sql
        createTable()
        
        NotificationCenter.default.addObserver(self, selector: #selector(clearDBCache), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
        
    }
    
    
    /// 清理数据缓存
    @objc func clearDBCache(){
        
        print("清缓存")
        let dateStr = Date.lj_dataString(time: TimeInterval(maxDBCacheTime))
        // ssql
        
        let sql = "DELETE FROM status WHERE createTime < ?;"
        //执行
        queue.inDatabase { (db) in
            
            if db.executeUpdate(sql, withArgumentsIn: [dateStr]) == true {
                
                print("删除了\(db.changes)个数") 
            }
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: - 创建数据表，及其他方法
private extension LJSQLiteManager {
    /// 创建数据表
    func createTable() {
        // 准备sql
        guard let path = Bundle.main.path(forResource: "status.sql", ofType: nil),
        let sql = try? String(contentsOfFile: path)
        else {
            return
        }
        print(sql)
        
        // 执行sql fmdb 的内部队列 是串行队列,同步执行的函数
        // 可以保证同一时间内，只有一个任务操作数据库，从而保证数据库的读写安全
        queue.inDatabase { (db) in
            if db.executeStatements(sql) == true {
                print("创表成功")
            }else{
                print("创表失败")
            }
        }
        
        print("over")
    }
}

// MARK: - 数据操作
extension LJSQLiteManager {
    
    func loadStatus(userid:String,since_id: Int64=0,max_id: Int64=0) ->[[String:Any]] {
        
        // 准备sql
        var sql = "SELECT statusid,userid,status FROM status \n"
        sql += "WHERE userid = \(userid) \n"
        // 上拉 下拉
        if since_id > 0 { // 下拉
            sql += "AND statusid > \(since_id) \n"
        }else if max_id > 0 { // 下拉
            sql += "AND statusid < \(max_id) \n"
        }
        sql += "ORDER BY statusid DESC LIMIT 20;"
        // 执行sql
        print("\(sql)")
        let array = execRecordSet(sql: sql)
        var result = [[String:Any]]()
        // 遍历数组，将数组中的 status 反序列化-> 数组字典
        for dict in array {
            
            guard let jsonData = dict["status"] as? Data,
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any]
            else {
                continue
            }
           // 追加数组
            result.append(json ?? [:])
            
        
        }
        
        return result
    }

    /// 执行一个sql，返回字典的数组
    ///
    /// - Parameter sql: sql
    /// - Returns: 字典的数组
    func execRecordSet(sql:String) -> [[String:Any]] {
        // 结果数组
        var result = [[String:Any]]()
        queue.inDatabase { (db) in
            
            guard let rs = db.executeQuery(sql, withArgumentsIn: []) else {
                return
            }
            
            // 逐行 --遍历结果集合
            while rs.next(){
                
                // 1.列数
                let colCount = rs.columnCount
                // 遍历所有列
                for col in 0..<colCount {
                    // 列名--key
                  guard  let name = rs.columnName(for: col),
                    // 值--value
                    let value = rs.object(forColumnIndex: col) else {
                        continue
                    }
                    print("\(name)-----\(value)")
                    // 追加结果
                    result.append([name:value])
                    
                }
            }
            
        }
        return result
        
    }
    
    
    // 新增或者修改数据，数据在刷新的时候，可能会出现重叠
    func updateStatus(userid:String,array:[[String:Any]]) {
        
        // 1.准备sqlte
        /**
         1. userid: 当前登录用户的id
         2. statusid: 用保存数据的id
         3. status: 数据
         */
        let sql = "INSERT OR REPLACE INTO status (statusid,userid,status) VALUES (?,?,?);"
        // 执行sql
        queue.inTransaction { (db, rollback) in
            // 遍历数组，逐条插入
            for dic in array {
                
                // 将字典序列化成二进制数据
                guard let statusid = dic["idstr"] as? String,
                    let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: []) else {
                        continue
                }
                
                // 执行sqlte
                if db.executeUpdate(sql, withArgumentsIn: [statusid,userid,jsonData]) == false {
                    // 需要回滚 oc中 *rollback = yes
                    print("插入失败")
                    rollback.pointee = true
                    break
                }else {
                    
//                    rollback.pointee = true
//                    break
                    print("插入成功")
                }
            }
            
        }
        
    }
    
}



