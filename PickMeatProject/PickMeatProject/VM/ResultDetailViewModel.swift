//
//  ResultDetailViewModel.swift
//  PickMeatProject
//
//  Created by 박정민 on 7/8/24.
//

import SwiftUI
import SQLite3

class ResultDetailViewModel: ObservableObject{
    var db: OpaquePointer?
    var meatFreshList: [ResultDetailModel] = []

    
    init(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "MeatFreshData.sqlite")
        // 주소 연산자라서 & 를 사용해서 db 를 찾음
        
        if sqlite3_open(fileURL.path(percentEncoded: true), &db) != SQLITE_OK{
            print("error opening database")
        }
        
        
        //Table 만들기
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS meatFresh(id INTEGER PRIMARY KEY AUTOINCREMENT, meatImage BLOB, date Text, meatFresh Text)", nil,nil,nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db))
            print("error creating table : \(errMsg)")
        }
    
    }
    
    func queryDB() -> [ResultDetailModel]{
        var stmt: OpaquePointer?
        let queryString = "SELECT * FROM meatFresh"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db))
            print("error creating table : \(errMsg)")
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let date = String(cString: sqlite3_column_text(stmt, 1))
            let meatFresh = String(cString: sqlite3_column_text(stmt, 2))
            let meatImage: UIImage = UIImage()
            
            
            
            meatFreshList.append(ResultDetailModel(id: id, meatImage: meatImage, date: date, meatFresh: meatFresh))
            
        }
        
        return meatFreshList
        
    }//---
    
    func insertDB(meatImage: UIImage, date: String, meatFresh: String) -> Bool{
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        let queryString = "INSERT INTO meatFresh (meatImage, date, meatFresh) VALUES (?, ?, ?)"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        sqlite3_bind_text(stmt, 1, date, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, meatFresh, -1, SQLITE_TRANSIENT)
        
        let imageData = meatImage.jpegData(compressionQuality: 0.4)! as NSData
        sqlite3_bind_blob(stmt, 3, imageData.bytes, Int32(imageData.length), SQLITE_TRANSIENT)
        
        
        if sqlite3_step(stmt) == SQLITE_DONE{
            return true
        } else {
            return false
        }
        
    }
    func deleteDB(id: Int32) -> Bool{
        var stmt: OpaquePointer?
//        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        let queryString = "DELETE FROM meatFresh where sid = ?"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        sqlite3_bind_int(stmt, 1, id)
        
        if sqlite3_step(stmt) == SQLITE_DONE{
            return true
        } else {
            return false
        }
        
    }

    
    
}

