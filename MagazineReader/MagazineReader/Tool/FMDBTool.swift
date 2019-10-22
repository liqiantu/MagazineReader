//
//  FMDBTool.swift
//  MagazineReader
//
//  Created by liqiantu on 2019/10/22.
//  Copyright © 2019 liqiantu. All rights reserved.
//

import Foundation
import FMDB

typealias executeResualtClosures = (_ res: Bool) -> Void

class FMDBToolSingleton {
    static let sharedInstance = FMDBToolSingleton()
    
    var dataBase: FMDatabase? {
        get {
            let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
            let dbPath = docPath + "/db.db"
            print("dbPath is \(dbPath)")
            let db = FMDatabase.init(path: dbPath)
            let isOpen = db.open()
            if isOpen {
                return db
            }
            print("db open fail")
            return nil
        }
    }
    
    func configDB(){
        guard let db = dataBase else {
            return
        }
        
        let sql = "create table if not exists t_favouriteMagzin ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'magazineguid' TEXT NOT NULL, 'MagazineName' TEXT NOT NULL,'Year' TEXT NOT NULL,'Issue' TEXT NOT NULL,'CoverImage' TEXT NOT NULL)"
        let result = db.executeStatements(sql)
        if !result {
            print("create table success")
        }
    }
    
    func getFavouriteList() -> [favouriteMagzineModel] {
        let sql = "select * from 't_favouriteMagzin'"
        let res = dataBase?.executeQuery(sql, withParameterDictionary: nil)
        var arr: [favouriteMagzineModel] = []
        while (res?.next())! {
            let magazineguid = res?.string(forColumn: "magazineguid")
            let MagazineName = res?.string(forColumn: "MagazineName")
            let Year = res?.string(forColumn: "Year")
            let Issue = res?.string(forColumn: "Issue")
            let CoverImage = res?.string(forColumn: "CoverImage")
            let m = favouriteMagzineModel.init(magazineguid: magazineguid!, MagazineName: MagazineName!, Year: Year!, Issue: Issue!, CoverImage: CoverImage!)
            arr.append(m)
        }
        return arr
    }
    
    func addFavouriteMagzine(model m: favouriteMagzineModel, executeResualt: executeResualtClosures) {
        let sql = "insert into 't_favouriteMagzin'(magazineguid, MagazineName, Year, Issue, CoverImage) values(?,?,?,?,?)"
        let isSucc = dataBase?.executeUpdate(sql, withArgumentsIn: [m.magazineguid,m.MagazineName,m.Year,m.Issue,m.CoverImage])
        guard let r = isSucc else {
            return
        }
        executeResualt(r)
    }
    
    func removeFavouriteMagzine(model m: favouriteMagzineModel, executeResualt: executeResualtClosures) {
        let sql = "delete from 't_favouriteMagzin' where magazineguid = ?"
        let isSucc = dataBase?.executeUpdate(sql, withArgumentsIn: [m.magazineguid])
        guard let r = isSucc else {
            return
        }
        executeResualt(r)
    }
}


