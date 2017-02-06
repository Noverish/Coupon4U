//
//  ViewController.swift
//  Coupon_for_U_Anam
//
//  Created by cscoi021 on 2017. 1. 11..
//  Copyright © 2017년 dan1002. All rights reserved.
//

import UIKit
import MMCardView
class ViewController: UIViewController, CardCollectionViewDataSource,DeleteDelegate ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var card:CardView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        card.registerCardCell(c: Express103Card.classForCoder(), nib: UINib.init(nibName: "Express103Card", bundle: nil))
        card.registerCardCell(c: Gram14Card.classForCoder(), nib: UINib.init(nibName: "Gram14Card", bundle: nil))
        card.registerCardCell(c: Do58Card.classForCoder(), nib: UINib.init(nibName: "Do58Card", bundle: nil))
        card.registerCardCell(c: DearBreadCard.classForCoder(), nib: UINib.init(nibName: "DearBreadCard", bundle: nil))
        card.registerCardCell(c: CafeDeNataCard.classForCoder(), nib: UINib.init(nibName: "CafeDeNataCard", bundle: nil))
        card.cardDataSource = self
        refresh()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func generateCardInfo (cardCount:Int) -> [AnyObject] {
        var arr = [AnyObject]()
        
        for coupon in couponManager.coupons {
            arr.append(coupon.storeName as AnyObject)
        }
        
        return arr
    }
    
    func cardView(collectionView:UICollectionView,item:AnyObject,indexPath:IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item as! String, for: indexPath )
        let coupon = couponManager.coupons[indexPath.row];

        switch cell {
        case let c as Gram14Card:
            c.coupon = coupon
            c.status.text = "1/10"
            c.delegate = self
        case let c as Express103Card:
            c.coupon = coupon
            c.status.text = "2/10"
            c.delegate = self
        case let c as Do58Card:
            c.coupon = coupon
            c.status.text = "3/10"
            c.delegate = self
        case let c as DearBreadCard:
            c.coupon = coupon
            c.status.text = "4/10"
            c.delegate = self
        case let c as CafeDeNataCard:
            c.coupon = coupon
            c.status.text = "5/10"
            c.delegate = self
        default:
            return UICollectionViewCell()
            
        }
        
        return cell
    }
    
    @IBAction func filterAction () {
        let sheet = UIAlertController.init(title: "Filter", message: "Select you want to show in View", preferredStyle: .actionSheet)
        
        let cellA = UIAlertAction(title: "1", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.card.filterAllDataWith(isInclued: { (idex, obj) -> Bool in
                print(String(idex) + " : " + couponManager.coupons[idex].storeName + ", " + String(couponManager.coupons[idex].location == "1"))
                return couponManager.coupons[idex].location == "1"
            })
        })
        
        let cellB = UIAlertAction(title: "2", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.card.filterAllDataWith(isInclued: { (idex, obj) -> Bool in
                print(String(idex) + " : " + couponManager.coupons[idex].storeName + ", " + String(couponManager.coupons[idex].location == "2"))
                return couponManager.coupons[idex].location == "2"
            })
        })
        
        let cellC = UIAlertAction(title: "3", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.card.filterAllDataWith(isInclued: { (idex, obj) -> Bool in
                print(String(idex) + " : " + couponManager.coupons[idex].storeName + ", " + String(couponManager.coupons[idex].location == "3"))
                return couponManager.coupons[idex].location == "3"
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
    
    func refresh() {
        let arr = self.generateCardInfo(cardCount: couponManager.coupons.count)
        card.set(cards: arr)
        self.card.showStyle(style: .normal)
    }
    
    func delete() {
        card.removeSelectCard()
    }
    
    @IBAction func useCamera(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension ViewController:SecondViewProtocol {
    func removeCard() {
        card.removeSelectCard()
    }
}

protocol DeleteDelegate: class {
    func delete()
}
