//
//  InicioController.swift
//  addonpayments
//
//  Created by Comercia on 2020.
//  Copyright © 2020 Addon Payments. All rights reserved.
//

import Foundation
import UIKit

class InicioController: UIViewController {
    
    @IBOutlet weak var inicioView: UIView!
    @IBOutlet weak var partnerView: UIView!
    @IBOutlet weak var pciView: UIView!
    @IBOutlet weak var docsView: UIView!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    weak var parametro: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shadow(parametro: inicioView)
        shadow(parametro: partnerView)
        shadow(parametro: pciView)
        shadow(parametro: docsView)
        shadow(parametro: callView)
        shadow(parametro: emailView)
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
    
    @IBAction func inicio(_ sender: UIButton) {
        let url = URL(string: "https://www.addonpayments.com/es-es")!
        UIApplication.shared.open(url)
    }
    
    @IBAction func partners(_ sender: UIButton) {
        let url = URL(string: "https://www.addonpayments.com/es-es/partners")!
        UIApplication.shared.open(url)
    }
    
    @IBAction func pci(_ sender: UIButton) {
        let url = URL(string: "https://www.pcisecuritystandards.org/")!
        UIApplication.shared.open(url)
    }
    
    @IBAction func documentacion(_ sender: UIButton) {
        let url = URL(string: "https://desarrolladores.addonpayments.com/")!
        UIApplication.shared.open(url)
    }
    
    @IBAction func call(_ sender: UIButton) {
        UIApplication.shared.open(NSURL(string: "tel://914353028")! as URL)
    }
    
    @IBAction func email(_ sender: UIButton) {
        let url = NSURL(string: "mailto:soporte@addonpayments.com")
        UIApplication.shared.open(url! as URL)
    }
}
