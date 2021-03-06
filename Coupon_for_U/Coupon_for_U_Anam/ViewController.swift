//
//  ViewController.swift
//  Coupon_for_U_Anam
//
//  Created by cscoi021 on 2017. 1. 11..
//  Copyright © 2017년 dan1002. All rights reserved.
//

import UIKit
import MMCardView
import CoreLocation
class ViewController: UIViewController, CardCollectionViewDataSource, DeleteDelegate ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarDelegate, UsedQRCode, CLLocationManagerDelegate {
    @IBOutlet weak var card:CardView!
    
    @IBOutlet weak var tabBar: UITabBar!
    let locationManager = CLLocationManager()
    var checkedStore:[Coupon] = []
    
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
        tabBar.selectedItem = tabBar.items![2] as UITabBarItem
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        var near:[Coupon] = []
        
        for coupon in couponManager.coupons {
            if coupon.isNear(lat: locValue.latitude, lng: locValue.longitude) {
                print(coupon.storeName)
                near.append(coupon)
            }
        }
        
        near = Array(Set(near).subtracting(checkedStore))
        if(near.count != 0) {
            checkedStore.append(near[0])
            let alert = UIAlertController(title: "주변 카페 알림", message: "혹시 " + near[0].storeName + "에 계신가요?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (uiAlertAction) in
                self.card.filterAllDataWith(isInclued: { (idex, obj) -> Bool in
                    return couponManager.coupons[idex].storeName == near[0].storeName
                })
            }))
            alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }
    
    func refresh() {
        couponManager.sort()
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
            c.setNowStamp(nowstamp: coupon.nowStamp)
            c.setHeart(flag: coupon.favorite)
        case let c as Express103Card:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
            c.setNowStamp(nowstamp: coupon.nowStamp)
            c.setHeart(flag: coupon.favorite)
        case let c as Do58Card:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
            c.setNowStamp(nowstamp: coupon.nowStamp)
            c.setHeart(flag: coupon.favorite)
        case let c as DearBreadCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
            c.setNowStamp(nowstamp: coupon.nowStamp)
            c.setHeart(flag: coupon.favorite)
        case let c as CafeDeNataCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
            c.setNowStamp(nowstamp: coupon.nowStamp)
            c.setHeart(flag: coupon.favorite)
        case let c as HyphenCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
            c.setNowStamp(nowstamp: coupon.nowStamp)
            c.setHeart(flag: coupon.favorite)
        case let c as MoiritaCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
            c.setNowStamp(nowstamp: coupon.nowStamp)
            c.setHeart(flag: coupon.favorite)
        case let c as SandPressoCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
            c.setNowStamp(nowstamp: coupon.nowStamp)
            c.setHeart(flag: coupon.favorite)
        case let c as HandsomeCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
            c.setNowStamp(nowstamp: coupon.nowStamp)
            c.setHeart(flag: coupon.favorite)
        case let c as CafeMotungiCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
            c.setNowStamp(nowstamp: coupon.nowStamp)
            c.setHeart(flag: coupon.favorite)
        case let c as CafeILLungoCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
            c.setNowStamp(nowstamp: coupon.nowStamp)
            c.setHeart(flag: coupon.favorite)
        case let c as DeChocolateCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
            c.setNowStamp(nowstamp: coupon.nowStamp)
            c.setHeart(flag: coupon.favorite)
        case let c as MostCard:
            c.coupon = coupon
            c.status.text = String(coupon.nowStamp) + "/" + String(coupon.maxStamp)
            c.delegate = self
            c.setNowStamp(nowstamp: coupon.nowStamp)
            c.setHeart(flag: coupon.favorite)
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
        couponManager.coupons.remove(at: card.currentIdx())
        couponManager.save()
        card.removeSelectCard() //순서 중요! 항상 위의 remove보다 밑에 있어야 함!
    }
    
    @IBAction func photoButton() {
        let myCamera : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "QRCodeViewController")
        (myCamera as! QRCodeViewController).delegate = self
        self.show(myCamera as! UIViewController, sender: myCamera)
    }
    
    func usedQRCode() {
        // create the alert
        let alert = UIAlertController(title: "스탬프 찍기 실패", message: "이미 사용한 QR코드 입니다", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
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
