//
//  ViewController.swift
//  Coupon_for_U_Anam
//
//  Created by cscoi021 on 2017. 1. 11..
//  Copyright © 2017년 dan1002. All rights reserved.
//

import UIKit
import MMCardView
class ViewController: UIViewController, CardCollectionViewDataSource,DeleteDelegate ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarDelegate {
    @IBOutlet weak var card:CardView!
    
    @IBOutlet weak var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        card.registerCardCell(c: Express103Card.classForCoder(), nib: UINib.init(nibName: "Express103Card", bundle: nil))
        card.registerCardCell(c: Gram14Card.classForCoder(), nib: UINib.init(nibName: "Gram14Card", bundle: nil))
        card.registerCardCell(c: Do58Card.classForCoder(), nib: UINib.init(nibName: "Do58Card", bundle: nil))
        card.registerCardCell(c: DearBreadCard.classForCoder(), nib: UINib.init(nibName: "DearBreadCard", bundle: nil))
        card.registerCardCell(c: CafeDeNataCard.classForCoder(), nib: UINib.init(nibName: "CafeDeNataCard", bundle: nil))
        card.registerCardCell(c: HyphenCard.classForCoder(), nib: UINib.init(nibName: "HyphenCard", bundle: nil))
        card.registerCardCell(c: MoiritaCard.classForCoder(), nib: UINib.init(nibName: "MoiritaCard", bundle: nil))
        card.registerCardCell(c: SandPressoCard.classForCoder(), nib: UINib.init(nibName: "SandPressoCard", bundle: nil))
        card.registerCardCell(c: HandsomeCard.classForCoder(), nib: UINib.init(nibName: "HandsomeCard", bundle: nil))
        card.registerCardCell(c: CafeMotungiCard.classForCoder(), nib: UINib.init(nibName: "CafeMotungiCard", bundle: nil))
        card.registerCardCell(c: CafeILLungoCard.classForCoder(), nib: UINib.init(nibName: "CafeILLungoCard", bundle: nil))
        card.registerCardCell(c: DeChocolateCard.classForCoder(), nib: UINib.init(nibName: "DeChocolateCard", bundle: nil))
        card.registerCardCell(c: MostCard.classForCoder(), nib: UINib.init(nibName: "MostCard", bundle: nil))
        card.cardDataSource = self
        card.showStyle(style: .normal)
        
        tabBar.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }
    
    func refresh() {
        let arr = self.generateCardInfo(cardCount: couponManager.coupons.count)
        card.set(cards: arr)
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
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
        case let c as Express103Card:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
        case let c as Do58Card:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
        case let c as DearBreadCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
        case let c as CafeDeNataCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
        case let c as HyphenCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
        case let c as MoiritaCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
        case let c as SandPressoCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
        case let c as HandsomeCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
        case let c as CafeMotungiCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
        case let c as CafeILLungoCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
        case let c as DeChocolateCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self                                                                                                 
        case let c as MostCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
        default:
            return UICollectionViewCell()
            
        }
        
        return cell
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let title = item.title ?? "none"
        
        if(title == "전체보기" || title == "none") {
            self.card.showAllData()
        } else {
            self.card.filterAllDataWith(isInclued: { (idex, obj) -> Bool in
                return couponManager.coupons[idex].location == title
            })
        }
    }
    
    func delete() {
        card.removeSelectCard()
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
