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
    func stamp(str:String) -> Coupon {
        return couponManager.getTemplate(storeName: str)
    }
}
