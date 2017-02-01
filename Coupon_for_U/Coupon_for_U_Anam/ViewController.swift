//
//  ViewController.swift
//  Coupon_for_U_Anam
//
//  Created by cscoi021 on 2017. 1. 11..
//  Copyright © 2017년 dan1002. All rights reserved.
//

import UIKit
import MMCardView
class ViewController: UIViewController, CardCollectionViewDataSource {
    
    @IBOutlet weak var card:CardView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        card.registerCardCell(c: CardACell.classForCoder(), nib: UINib.init(nibName: "CardACell", bundle: nil))
        card.registerCardCell(c: CardBCell.classForCoder(), nib: UINib.init(nibName: "CardBCell", bundle: nil))
        card.registerCardCell(c: CardCCell.classForCoder(), nib: UINib.init(nibName: "CardCCell", bundle: nil))
        card.cardDataSource = self
        let arr = self.generateCardInfo(cardCount: 10)
        card.set(cards: arr)
        
        self.card.showStyle(style: .cover)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func generateCardInfo (cardCount:Int) -> [AnyObject] {
        var arr = [AnyObject]()
        let xibName = ["CardB","CardB","CardB"]
        
        for _ in 1...cardCount {
            let value = Int(arc4random_uniform(3))
            arr.append(xibName[value] as AnyObject)
        }
        
        return arr
    }
    
    func cardView(collectionView:UICollectionView,item:AnyObject,indexPath:IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item as! String, for: indexPath )
        let c = cell as! CardBCell
        if(c.coupon == nil) {
            print(String(indexPath.row) + " - " + "nil");
            
            let coupon = couponList[indexPath.row];
            
            c.imgV.image = UIImage.init(named: "14gram_background")
            c.coupon = coupon
            c.title.text = coupon.storeName;
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
        } else {
            print(String(indexPath.row) + " - " + (c.coupon?.storeName)!);
        }

        return cell
    }
    
    @IBAction func segmentAction(seg:UISegmentedControl) {
        if (seg.selectedSegmentIndex == 0) {
            self.card.showStyle(style: .cover)
        } else {
            self.card.showStyle(style: .normal)
        }
    }
    
    @IBAction func filterAction () {
        let sheet = UIAlertController.init(title: "Filter", message: "Select you want to show in View", preferredStyle: .actionSheet)
        
        let cellA = UIAlertAction(title: "1", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.card.filterAllDataWith(isInclued: { (idex, obj) -> Bool in
                print(String(idex) + " : " + couponList[idex].storeName + ", " + String(couponList[idex].location == "1"))
                return couponList[idex].location == "1"
            })
        })
        
        let cellB = UIAlertAction(title: "2", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.card.filterAllDataWith(isInclued: { (idex, obj) -> Bool in
                print(String(idex) + " : " + couponList[idex].storeName + ", " + String(couponList[idex].location == "2"))
                return couponList[idex].location == "2"
            })
        })
        
        let cellC = UIAlertAction(title: "3", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.card.filterAllDataWith(isInclued: { (idex, obj) -> Bool in
                print(String(idex) + " : " + couponList[idex].storeName + ", " + String(couponList[idex].location == "3"))
                return couponList[idex].location == "3"
            })
        })
        
        let allCell = UIAlertAction(title: "모두 보기", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.card.showAllData()
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        sheet.addAction(cellA)
        sheet.addAction(cellB)
        sheet.addAction(cellC)
        sheet.addAction(allCell)
        sheet.addAction(cancelAction)
        self.present(sheet, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:SecondViewProtocol {
    func removeCard() {
        card.removeSelectCard()
    }
}
