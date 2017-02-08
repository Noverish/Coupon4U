//
//  CardBCell.swift
//  MMCardView
//
//  Created by MILLMAN on 2016/9/21.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import MMCardView

class DearBreadCard: CardCell,CardCellProtocol {
    var coupon:Coupon?
    var delegate:DeleteDelegate?
    @IBOutlet weak var imgV:UIImageView!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var img01: UIImageView!
    @IBOutlet weak var img02: UIImageView!
    @IBOutlet weak var img03: UIImageView!
    @IBOutlet weak var img04: UIImageView!
    @IBOutlet weak var img05: UIImageView!
    @IBOutlet weak var img06: UIImageView!
    @IBOutlet weak var img07: UIImageView!
    @IBOutlet weak var img08: UIImageView!
    @IBOutlet weak var img09: UIImageView!
    @IBOutlet weak var img10: UIImageView!
    
    public static func cellIdentifier() -> String {
        return "DEAR BREAD"
    }
    
    @IBAction func clickAction() {
        delegate?.delete()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        imgV.layer.cornerRadius = 8.0
        imgV.clipsToBounds = true
        // Initialization code
    }
    
    func setNowStamp(nowstamp:Int) {
        var imgList:[UIImageView] = [img01,img02,img03,img04,img05,img06,img07,img08,img09,img10]
        
        for i in 0...9{
            imgList[i].image = (i<nowstamp) ? UIImage(named: "DearBread_stamp") : UIImage(named: "DearBread_empty")
        }
    }
}
