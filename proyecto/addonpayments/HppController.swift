//
//  HppController.swift
//  addonpayments
//
//  Created by Comercia on 2020.
//  Copyright © 2020 Addon Payments. All rights reserved.
//

import Foundation
import UIKit

class HppController: UIViewController {
    
    // Unimos los campos de texto del formulario creado en el StoryBoard
    @IBOutlet weak var hppView: UIView!
    @IBOutlet weak var buttonView: UIView!
    
    // Iniciamos los campos de validación nada más cargar la pestaña
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shadow(parametro: hppView)
        shadow(parametro: buttonView)
    }
    
    // Función que modifica el estilo de la vista y el botón aplicando una sombra y redondea las esquinas
    func shadow(parametro: UIView!) {
        parametro.layer.cornerRadius = 5
        parametro.clipsToBounds = true
        parametro.layer.shadowPath =
             UIBezierPath(roundedRect: parametro.bounds,
             cornerRadius: parametro.layer.cornerRadius).cgPath
        parametro.layer.shadowColor = UIColor.black.cgColor
        parametro.layer.shadowOpacity = 0.5
        parametro.layer.shadowOffset = CGSize(width: 0, height: 0)
        parametro.layer.shadowRadius = 5
        parametro.layer.masksToBounds = false
    }

    // Función que se activa cuando se pulsa el botón de "Pagar ahora"
    @IBAction func hppOP(_ sender: UIButton) {
        
        // Indicamos la URL del servidor de Addon Payments
        let url = URL(string: "https://hpp.sandbox.addonpayments.com/pay")!
        
        // Preparamos los parámetros que vamos a enviar al servidor
        let json: [String: Any] = [
            "TIMESTAMP":"20200123125849",
            "MERCHANT_ID":"addonphptest",
            "ACCOUNT":"api",
            "ORDER_ID":"636-Pruebas",
            "AMOUNT":"1001",
            "CURRENCY":"EUR",
            "SHA1HASH":"3eb93d9769be528bc02e133a04923ced4ecddc36",
            "AUTO_SETTLE_FLAG":"1",
            "COMMENT1":"Mobile Channel",
            "COMMENT2":"Comment2",
            "SHIPPING_CODE":"03201",
            "SHIPPING_CO":"ES",
            "BILLING_CODE":"03201",
            "BILLING_CO":"ES",
            "CUST_NUM":"332a85b",
            "VAR_REF":"Invoice 7564a",
            "PROD_ID":"SKU1000054",
            "HPP_LANG":"ES",
            "HPP_VERSION":"2",
            "MERCHANT_RESPONSE_URL":"https://www.midominio.com/responseUrl",
            "CARD_PAYMENT_BUTTON":"Pagar ahora",
            "SUPPLEMENTARY_DATA":"Valores adicionales"
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // Creamos la petición mediante el método POST indicando en la cabecera que vamos a enviar un JSON
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        // Asociamos los parámetros a la solicitud de envío
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // En caso de no poder conectar con la URL iOS nos mostrará el error en consola
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            // Mostramos la respuesta de forma asíncrona
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            DispatchQueue.main.async {
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                    // En caso de que la operación se haya repetido o se hayan enviado parámetros incorrectos
                    // se recibirá un error desde el servidor.
                    //
                    // Si la operación es válida obtendremos un enlace como respuesta del servidor
                    // y este lo abriremos en una ventana nueva de Safari
                    if let responseJSON = responseJSON["errors"] {
                        print("Error en la solicitud HPP = ", responseJSON as Any)
                    } else {
                        if let url = URL(string: responseJSON["hppPayByLink"]! as! String) {
                            UIApplication.shared.open(url)
                        }
                    }
                }
            }
        }
        task.resume()
        print("Botón pulsado\n")
    }
}
