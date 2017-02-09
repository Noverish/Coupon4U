//
//  ServerClient.swift
//  Coupon_for_U_Anam
//
//  Created by cscoi020 on 2017. 2. 7..
//  Copyright © 2017년 dan1002. All rights reserved.
//

import Foundation

let serverClient:ServerClient = ServerClient()
class ServerClient {
    var used:[String] = []
    
    func stamp(str:String) -> Coupon? {
        if(used.contains(str)) {
            return nil
        } else {
            used.append(str)
            return couponManager.getTemplate(storeName: (str.components(separatedBy: "_"))[0])
        }
    }
}
