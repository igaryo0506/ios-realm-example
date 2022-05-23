//
//  MyRealm.swift
//  Database
//
//  Created by 五十嵐諒 on 2022/05/23.
//

import Foundation
import RealmSwift

class MyRealm{
    var memos:Results<Memo>!
    let realm = try! Realm()
    
    func read(){
        memos = realm.objects(Memo.self)
    }
    
    func add(title:String,content:String){
        let memo = Memo()
        memo.title = title
        memo.content = content
        try! realm.write{
            realm.add(memo)
        }
    }
    
    func update(memo:Memo,title:String, content:String){
        try! realm.write{
            memo.title = title
            memo.content = content
        }
    }
    
    func delete(memo:Memo){
        try! realm.write{
            realm.delete(memo)
        }
    }
}
