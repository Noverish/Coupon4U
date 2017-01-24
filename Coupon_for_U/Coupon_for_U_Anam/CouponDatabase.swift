//
//  CouponDatabase.swift
//  Coupon_for_U_Anam
//
//  Created by cscoi020 on 2017. 1. 24..
//  Copyright © 2017년 dan1002. All rights reserved.
//

import Foundation

class Coupon {
    var favorite:Bool
    var nowStamp:Int
    var maxStamp:Int
    var storeName:String
    var checklist:[Int:String]
    var isRcvd:[Int:Bool] = [:]
    var dueDate:String?
    
    init(nowStamp:Int, maxStamp:Int, storeName:String, checklist:[Int:String]) {
        self.favorite = false;
        self.nowStamp = nowStamp;
        self.maxStamp = maxStamp;
        self.storeName = storeName;
        self.checklist = checklist;
        
        for (num, _) in checklist {
            isRcvd[num] = false
        }
    }
    
    init(nowStamp:Int, maxStamp:Int, storeName:String, checklist:[Int:String], isRcvd:[Int:Bool]) {
        self.favorite = false;
        self.nowStamp = nowStamp;
        self.maxStamp = maxStamp;
        self.storeName = storeName;
        self.checklist = checklist;
        self.isRcvd = isRcvd;
    }
    
    init(nowStamp:Int, maxStamp:Int, storeName:String, checklist:[Int:String], dueDate:String) {
        self.favorite = false;
        self.nowStamp = nowStamp;
        self.maxStamp = maxStamp;
        self.storeName = storeName;
        self.checklist = checklist;
        self.dueDate = dueDate;
        
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
}


var rewardHyphen:[Int:String] = [12: "Free Drink"]
var rewardAnouk:[Int:String] = [10: "Free Drink"]
var rewardMoirita:[Int:String] = [6: "아이스티 한 잔", 12: "에이드 두 잔"]
var rewardDeChocolate:[Int:String] = [12: "아메리카노"]
var rewardSandPresso:[Int:String] = [12: "Free Drink"]
var reward103Express:[Int:String] = [10: "Free Coffee"]
var rewardHandsomeBagle:[Int:String] = [10: "Free Bagle"]
var rewardCaffeMotungi:[Int:String] = [10: "아메리카노 1잔 또는 2500원 할인"]
var reward14gram:[Int:String] = [7: "Free Drink", 14:"Free Drink"]
var rewardDearBread:[Int:String] = [12: "5000원 할인"]

var couponHyphen = Coupon(nowStamp: 2, maxStamp: 12, storeName: "Hyphen", checklist: rewardHyphen)
var couponAnouk = Coupon(nowStamp: 2, maxStamp: 10, storeName: "Anouk", checklist: rewardAnouk)
var couponMoirita = Coupon(nowStamp: 2, maxStamp: 12, storeName: "Moirita", checklist: rewardMoirita)
var couponSandPresso = Coupon(nowStamp: 8, maxStamp: 12, storeName: "SandPresso", checklist: rewardSandPresso)
var coupon103Express = Coupon(nowStamp: 6, maxStamp: 10, storeName: "103Express", checklist: reward103Express)
var couponHandsomeBagle = Coupon(nowStamp: 1, maxStamp: 10, storeName: "핸썸 베이글", checklist: rewardHandsomeBagle)
var couponCaffeMotungi = Coupon(nowStamp: 2, maxStamp: 10, storeName: "카페 모퉁이", checklist: rewardCaffeMotungi)
var coupon14gram = Coupon(nowStamp: 4, maxStamp: 14, storeName: "14gram", checklist: reward14gram)
var couponDearBread = Coupon(nowStamp: 6, maxStamp: 12, storeName: "DEAR BREAD", checklist: rewardDearBread)
var couponDeChocolate = Coupon(nowStamp: 3, maxStamp: 12, storeName: "De Chocolate", checklist: rewardDeChocolate, dueDate: "2016-10-21")

let couponList:[Coupon] = [couponHyphen, couponAnouk, couponMoirita, couponSandPresso, coupon103Express, couponHandsomeBagle, couponCaffeMotungi, coupon14gram, couponDearBread, couponDeChocolate]
