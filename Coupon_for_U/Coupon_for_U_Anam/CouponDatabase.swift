//
//  CouponDatabase.swift
//  Coupon_for_U_Anam
//
//  Created by cscoi020 on 2017. 1. 24..
//  Copyright © 2017년 dan1002. All rights reserved.
//

import Foundation

let couponManager:CouponManager = CouponManager()
let fileName = "BranchData.brch"

class CouponManager {
    var coupons:[Coupon] = []
    
    var filePath:String { get{
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory + fileName
        }}
    
    init() {
        if FileManager.default.fileExists(atPath: self.filePath) {
            //read
            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath) as? [Coupon] {
                coupons += unarchArray
            }
        } else {
            //create
            coupons += defaultData()
        }
    }
    
    func defaultData() -> Array<Coupon> {
        let couponList:[Coupon] = [
            getTemplate(storeName: "Hyphen"),
            getTemplate(storeName: "Anouk"),
            getTemplate(storeName: "Moirita"),
            getTemplate(storeName: "SandPresso"),
            getTemplate(storeName: "103Express"),
            getTemplate(storeName: "HandsomeBagle"),
            getTemplate(storeName: "CaffeMotungi"),
            getTemplate(storeName: "14gram"),
            getTemplate(storeName: "DearBread"),
            getTemplate(storeName: "DeChocolate")
        ]
        
        return couponList
    }
    
    func save(){
        NSKeyedArchiver.archiveRootObject(self.coupons, toFile: self.filePath)
    }
    
    func getTemplate(storeName:String) -> Coupon {
        switch storeName {
        case "Hyphen":
            return Coupon(nowStamp: 0, maxStamp: 12, storeName: "Hyphen", checklist: [12: "Free Drink"], location: "1")
        case "Anouk":
            return Coupon(nowStamp: 0, maxStamp: 10, storeName: "Anouk", checklist: [10: "Free Drink"], location: "2")
        case "Moirita":
            return Coupon(nowStamp: 0, maxStamp: 12, storeName: "Moirita", checklist: [6: "아이스티 한 잔", 12: "에이드 두 잔"], location: "3")
        case "SandPresso":
            return Coupon(nowStamp: 0, maxStamp: 12, storeName: "SandPresso", checklist: [12: "Free Drink"], location: "2")
        case "103Express":
            return Coupon(nowStamp: 0, maxStamp: 10, storeName: "103Express", checklist: [10: "Free Coffee"], location: "3")
        case "HandsomeBagle":
            return Coupon(nowStamp: 0, maxStamp: 10, storeName: "핸썸 베이글", checklist: [10: "Free Bagle"], location: "1")
        case "CaffeMotungi":
            return Coupon(nowStamp: 0, maxStamp: 10, storeName: "카페 모퉁이", checklist: [10: "아메리카노 1잔 또는 2500원 할인"], location: "2")
        case "14gram":
            return Coupon(nowStamp: 0, maxStamp: 14, storeName: "14gram", checklist: [7: "Free Drink", 14:"Free Drink"], location: "3")
        case "DearBread":
            return Coupon(nowStamp: 0, maxStamp: 12, storeName: "DEAR BREAD", checklist: [12: "5000원 할인"], location: "1")
        case "DeChocolate":
            return Coupon(nowStamp: 0, maxStamp: 12, storeName: "De Chocolate", checklist: [12: "아메리카노"], dueDate: "2016-10-21", location: "2")
        default:
            return Coupon(nowStamp: 0, maxStamp: 1, storeName: "Unknown", checklist: [1: "unknown"], location: "2")
        }
    }
}

class Coupon : NSObject, NSCoding {
    var favorite:Bool
    var nowStamp:Int
    var maxStamp:Int
    var storeName:String
    var checklist:[Int:String]
    var isRcvd:[Int:Bool] = [:]
    var dueDate:String?
    var location:String
    
    init(nowStamp:Int, maxStamp:Int, storeName:String, checklist:[Int:String], location:String) {
        self.favorite = false;
        self.nowStamp = nowStamp;
        self.maxStamp = maxStamp;
        self.storeName = storeName;
        self.checklist = checklist;
        self.location = location;
        
        for (num, _) in checklist {
            isRcvd[num] = false
        }
    }
    
    init(nowStamp:Int, maxStamp:Int, storeName:String, checklist:[Int:String], isRcvd:[Int:Bool], location:String) {
        self.favorite = false;
        self.nowStamp = nowStamp;
        self.maxStamp = maxStamp;
        self.storeName = storeName;
        self.checklist = checklist;
        self.isRcvd = isRcvd;
        self.location = location;
    }
    
    init(nowStamp:Int, maxStamp:Int, storeName:String, checklist:[Int:String], dueDate:String, location:String) {
        self.favorite = false;
        self.nowStamp = nowStamp;
        self.maxStamp = maxStamp;
        self.storeName = storeName;
        self.checklist = checklist;
        self.dueDate = dueDate;
        self.location = location;
        
        for (num, _) in checklist {
            isRcvd[num] = false
        }
    }
    
    func addStamp() -> Void {
        if (nowStamp != maxStamp - 1) {
            nowStamp += 1;
        }
    }
    
    func isFull() -> Bool {
        return nowStamp == maxStamp
    }
    
    func rcvd(num:Int) {
        if isRcvd.keys.contains(num) {
            isRcvd[num] = true;
        }
    }
    
    func setFavorite(b:Bool) {
        self.favorite = b;
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.favorite = aDecoder.decodeObject(forKey: "favorite") as! Bool
        self.nowStamp = aDecoder.decodeObject(forKey: "nowStamp") as! Int
        self.maxStamp = aDecoder.decodeObject(forKey: "maxStamp") as! Int
        self.storeName = aDecoder.decodeObject(forKey: "storeName") as! String
        self.checklist = aDecoder.decodeObject(forKey: "checklist") as! [Int:String]
        self.isRcvd = aDecoder.decodeObject(forKey: "isRcvd") as! [Int:Bool]
        self.dueDate = aDecoder.decodeObject(forKey: "dueDate") as! String?
        self.location = aDecoder.decodeObject(forKey: "location") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.favorite, forKey:"favorite")
        aCoder.encode(self.nowStamp, forKey:"nowStamp")
        aCoder.encode(self.maxStamp, forKey:"maxStamp")
        aCoder.encode(self.storeName, forKey:"storeName")
        aCoder.encode(self.checklist, forKey:"checklist")
        aCoder.encode(self.isRcvd, forKey:"isRcvd")
        aCoder.encode(self.dueDate, forKey:"dueDate")
        aCoder.encode(self.location, forKey:"location")
    }
}
