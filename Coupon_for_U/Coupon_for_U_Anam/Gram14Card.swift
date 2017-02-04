//
//  CardBCell.swift
//  MMCardView
//
//  Created by MILLMAN on 2016/9/21.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import MMCardView

class Gram14Card: CardCell,CardCellProtocol {
    var delegate:DeleteDelegate?
    var coupon:Coupon?
    @IBOutlet weak var imgV:UIImageView!
    @IBOutlet weak var status: UILabel!
    
    public static func cellIdentifier() -> String {
        return "14gram"
    }

    @IBAction func clickAction(){
        delegate?.delete()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        imgV.layer.cornerRadius = 8.0
        imgV.clipsToBounds = true
        // Initialization code
    }

}
