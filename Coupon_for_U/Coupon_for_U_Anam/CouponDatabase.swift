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
    var couponTemplates:[Coupon] = []
    
    var filePath:String { get{
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory + "/" + fileName
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
        
        couponTemplates = [
            getTemplate(storeName: "Hyphen"),
            getTemplate(storeName: "Moirita"),
            getTemplate(storeName: "SandPresso"),
            getTemplate(storeName: "103Express"),
            getTemplate(storeName: "HandsomeBagle"),
            getTemplate(storeName: "cafe motungi"),
            getTemplate(storeName: "14gram"),
            getTemplate(storeName: "DEAR BREAD"),
            getTemplate(storeName: "De Chocolate"),
            getTemplate(storeName: "58도씨"),
            getTemplate(storeName: "cafe de nata"),
            getTemplate(storeName: "Cafe IL Luogo"),
            getTemplate(storeName: "most")
        ]
        
        sort()
    }
    
    func defaultData() -> Array<Coupon> {
        let couponList:[Coupon] = []
        
        return couponList
    }
    
    func addStamp(stamp:Coupon) {
        for coupon in coupons {
            if(coupon.storeName == stamp.storeName) {
                coupon.nowStamp += 1;
                save()
                return
            }
        }
        stamp.nowStamp = 1
        coupons.append(stamp)
        
        sort()
        
        save()
    }
    
    func save(){
        let success = NSKeyedArchiver.archiveRootObject(self.coupons, toFile: self.filePath)
        print(self.filePath)
        print(success)
    }
    
    func getTemplate(storeName:String) -> Coupon {
        switch storeName {
        case "Hyphen": return Coupon(nowStamp: 0, maxStamp: 12, storeName: "Hyphen", checklist: [12: "Free Drink"], location: "정문", lat:37.586510, lng:127.032285)
        case "Moirita": return Coupon(nowStamp: 0, maxStamp: 12, storeName: "Moirita", checklist: [6: "아이스티 한 잔", 12: "에이드 두 잔"], location: "참살이", lat:37.585328, lng:127.029226)
        case "SandPresso": return Coupon(nowStamp: 0, maxStamp: 12, storeName: "SandPresso", checklist: [12: "Free Drink"], location: "이공캠", lat:37.584822, lng:127.026272)
        case "103Express": return Coupon(nowStamp: 0, maxStamp: 10, storeName: "103Express", checklist: [10: "Free Coffee"], location: "정대후문", lat:37.587304, lng:127.029648)
        case "HandsomeBagle": return Coupon(nowStamp: 0, maxStamp: 10, storeName: "HandsomeBagle", checklist: [10: "Free Bagle"], location: "정대후문", lat:37.587202, lng:127.028724)
        case "cafe motungi": return Coupon(nowStamp: 0, maxStamp: 10, storeName: "cafe motungi", checklist: [10: "아메리카노 1잔 또는 2500원 할인"], location: "참살이", lat:37.585138, lng:127.030360)
        case "14gram": return Coupon(nowStamp: 0, maxStamp: 14, storeName: "14gram", checklist: [7: "Free Drink", 14:"Free Drink"], location: "정대후문", lat:37.586724, lng:127.029928)
        case "DEAR BREAD": return Coupon(nowStamp: 0, maxStamp: 12, storeName: "DEAR BREAD", checklist: [12: "5000원 할인"], location: "정대후문", lat:37.587287, lng:127.028695)
        case "De Chocolate": return Coupon(nowStamp: 0, maxStamp: 12, storeName: "De Chocolate", checklist: [12: "아메리카노"], dueDate: "2016-10-21", location: "정문", lat:37.588438, lng:127.033087)
        case "58도씨": return Coupon(nowStamp: 0, maxStamp: 12, storeName: "58도씨", checklist: [6: "Free Drink", 12: "Free Drink"], location: "참살이", lat:37.584367, lng:127.029757)
        case "cafe de nata": return Coupon(nowStamp: 0, maxStamp: 12, storeName: "cafe de nata", checklist: [10: "Free Drink"], location: "참살이", lat:37.585818, lng:127.030687)
        case "Cafe IL Luogo": return Coupon(nowStamp: 0, maxStamp: 9, storeName: "Cafe IL Luogo", checklist: [9: "아메리카노"], location: "정대후문", lat:37.586187, lng:127.024476)
        case "most": return Coupon(nowStamp: 0, maxStamp: 10, storeName: "most", checklist: [10: "Free Drink"], location: "이공캠", lat:37.584777, lng:127.026665)
        default: return Coupon(nowStamp: 0, maxStamp: 1, storeName: "Unknown", checklist: [1: "unknown"], location: "1234", lat:37.585217, lng:127.026899)
        }
    }
    
    func sort() {
        coupons = coupons.sorted { (c1, c2) -> Bool in
            if(c1.favorite != c2.favorite) {
                return c1.favorite
            } else {
                return (c1.maxStamp - c1.nowStamp) < (c2.maxStamp - c2.nowStamp)
            }
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
    var lat:Double
    var lng:Double
    
    init(nowStamp:Int, maxStamp:Int, storeName:String, checklist:[Int:String], location:String, lat:Double, lng:Double) {
        self.favorite = false;
        self.nowStamp = nowStamp;
        self.maxStamp = maxStamp;
        self.storeName = storeName;
        self.checklist = checklist;
        self.location = location;
        self.lat = lat;
        self.lng = lng;
        
        for (num, _) in checklist {
            isRcvd[num] = false
        }
    }
    
    init(nowStamp:Int, maxStamp:Int, storeName:String, checklist:[Int:String], isRcvd:[Int:Bool], location:String, lat:Double, lng:Double) {
        self.favorite = false;
        self.nowStamp = nowStamp;
        self.maxStamp = maxStamp;
        self.storeName = storeName;
        self.checklist = checklist;
        self.isRcvd = isRcvd;
        self.location = location;
        self.lat = lat;
        self.lng = lng;
    }
    
    init(nowStamp:Int, maxStamp:Int, storeName:String, checklist:[Int:String], dueDate:String, location:String, lat:Double, lng:Double) {
        self.favorite = false;
        self.nowStamp = nowStamp;
        self.maxStamp = maxStamp;
        self.storeName = storeName;
        self.checklist = checklist;
        self.dueDate = dueDate;
        self.location = location;
        self.lat = lat;
        self.lng = lng;
        
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
        self.favorite = aDecoder.decodeBool(forKey: "favorite") 
        self.nowStamp = aDecoder.decodeInteger(forKey: "nowStamp")
        self.maxStamp = aDecoder.decodeInteger(forKey: "maxStamp") 
        self.storeName = aDecoder.decodeObject(forKey: "storeName") as! String
        self.checklist = aDecoder.decodeObject(forKey: "checklist") as! [Int:String]
        self.isRcvd = aDecoder.decodeObject(forKey: "isRcvd") as! [Int:Bool]
        self.dueDate = aDecoder.decodeObject(forKey: "dueDate") as! String?
        self.location = aDecoder.decodeObject(forKey: "location") as! String
        self.lat = aDecoder.decodeDouble(forKey: "lat")
        self.lng = aDecoder.decodeDouble(forKey: "lng")
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
        aCoder.encode(self.lat, forKey:"lat")
        aCoder.encode(self.lng, forKey:"lng")
    }
    
    func isNear(lat:Double, lng:Double) -> Bool {
        print(storeName)
        print(String(self.lat - lat) + " " + String(self.lng - lng))
        print(sqrt(pow(self.lat - lat, 2) + pow(self.lng - lng, 2)))
        
        return sqrt(pow(self.lat - lat, 2) + pow(self.lng - lng, 2)) < 0.001
    }
}
