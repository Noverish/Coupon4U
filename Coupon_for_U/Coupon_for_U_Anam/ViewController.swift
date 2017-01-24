//
//  ViewController.swift
//  Coupon_for_U_Anam
//
//  Created by cscoi021 on 2017. 1. 11..
//  Copyright © 2017년 dan1002. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var storeName:String?
    var nowStamp:Int?
    var maxStamp:Int?
    var favorite:Bool?
    
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var nowStampLabel: UILabel!
    @IBOutlet weak var maxStampLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        storeNameLabel.text = storeName
        nowStampLabel.text = "현재 스탬프 갯수 : " + String(nowStamp!)
        maxStampLabel.text = "완료 스탬프 갯수 : " + String(maxStamp!)
        favoriteLabel.text = (favorite!) ? "관심쿠폰" : "관심쿠폰 아님"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

