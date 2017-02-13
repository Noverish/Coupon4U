//
//  ServerClient.swift
//  Coupon_for_U_Anam
//
//  Created by cscoi020 on 2017. 2. 7..
//  Copyright © 2017년 dan1002. All rights reserved.
//

import Foundation
import UIKit

let serverClient:ServerClient = ServerClient()
class ServerClient {
    var used:[String] = []
    
    func stamp(str:String) -> Coupon? {
        if(used.contains(str)) {
            return nil
        } else {
            used.append(str)
            let tmp:Coupon = couponManager.getTemplate(storeName: (str.components(separatedBy: "_"))[0])
            if(tmp.storeName == "Unknown") {
                return nil
            } else {
                return tmp
            }
        }
    }
}
