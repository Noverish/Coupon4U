//
//  QRCodeViewController.swift
//  Coupon_for_U_Anam
//
//  Created by cscoi020 on 2017. 2. 6..
//  Copyright © 2017년 dan1002. All rights reserved.
//

import UIKit
import SwiftQRCode
class QRCodeViewController: UIViewController {
    var delegate: UsedQRCode? = nil
    let scanner = QRCode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanner.prepareScan(view) { (stringValue) -> () in
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
            
            if let stamp = serverClient.stamp(str: stringValue) {
                couponManager.addStamp(stamp: stamp)
            } else {
                self.delegate?.usedQRCode()
            }
        }
        scanner.scanFrame = view.bounds
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // start scan
        scanner.startScan()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol UsedQRCode {
    func usedQRCode()
}
