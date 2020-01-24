//
//  RedesController.swift
//  addonpayments
//
//  Created by Comercia on 2020.
//  Copyright © 2020 Addon Payments. All rights reserved.
//

import Foundation
import UIKit

class RedesController: UIViewController {

    @IBOutlet weak var linkedin: UIView!
    @IBOutlet weak var github: UIView!
    @IBOutlet weak var twitter: UIView!
    @IBOutlet weak var whatsapp: UIView!
    @IBOutlet weak var mail: UIView!
    
    weak var parametro: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shadow(parametro: linkedin)
        shadow(parametro: github)
        shadow(parametro: twitter)
        shadow(parametro: whatsapp)
        shadow(parametro: mail)
    }
    
    func shadow(parametro: UIView!) {
        parametro.layer.cornerRadius = 8
        parametro.clipsToBounds = true
        
        parametro.layer.shadowPath =
              UIBezierPath(roundedRect: parametro.bounds,
              cornerRadius: parametro.layer.cornerRadius).cgPath
        parametro.layer.shadowColor = UIColor.black.cgColor
        parametro.layer.shadowOpacity = 0.5
        parametro.layer.shadowOffset = CGSize(width: 0, height: 0)
        parametro.layer.shadowRadius = 8
        parametro.layer.masksToBounds = false
    }
    
    @IBAction func linkedin(_ sender: UIButton) {
        let url = URL(string: "https://es.linkedin.com/company/comercia-global-payments")!
        UIApplication.shared.open(url)
    }
    
    @IBAction func github(_ sender: UIButton) {
        let url = URL(string: "https://github.com/addonpayments")!
        UIApplication.shared.open(url)
    }
    
    @IBAction func twitter(_ sender: UIButton) {
        let url = URL(string: "https://twitter.com/caixabank")!
        UIApplication.shared.open(url)
    }
    
    @IBAction func whatsapp(_ sender: UIButton) {
        var str = "Descubre el nuevo método de pago de CaixaBank https://www.addonpayments.com/"
        str = str.addingPercentEncoding(withAllowedCharacters: (NSCharacterSet.urlQueryAllowed))!
        let whatsappURL = NSURL(string: "whatsapp://send?text=\(str)")

        if UIApplication.shared.canOpenURL(whatsappURL! as URL) {
            UIApplication.shared.open(whatsappURL! as URL)
        } else {
            print("Whatsapp no está instalado en el sistema")
        }
        
    }
    
    @IBAction func share(_ sender: UIButton) {
        let items = ["Descubre el nuevo método de pago de CaixaBank https://www.addonpayments.com/"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
        
    }
}
