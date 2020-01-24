//
//  ApiController.swift
//  addonpayments
//
//  Created by Comercia on 2020.
//  Copyright © 2020 Addon Payments. All rights reserved.
//

import Foundation
import UIKit

class ApiController: UIViewController, UITextFieldDelegate {
    
    // Inicializamos las variables indicando su tipo correspondiente
    var numTarjeta:String = ""
    var mesTarjeta:String = ""
    var anyTarjeta:String = ""
    var cvvTarjeta:String = ""
    var titularTarjeta:String = ""
    var expiryDate:String = ""
    var isValidCard:Bool = false
    var isValidMes:Bool = false
    var isValidPast:Bool = false
    var isValidCVV:Bool = false
    var isValidHolder:Bool = false
    
    // Unimos los campos de texto del formulario creado en el StoryBoard
    @IBOutlet var NumTarjeta: UITextField!
    @IBOutlet var MesTarjeta: UITextField!
    @IBOutlet var AnyTarjeta: UITextField!
    @IBOutlet var CvvTarjeta: UITextField!
    @IBOutlet var TitularTarjeta: UITextField!
    @IBOutlet var enviarAPI: UIButton!
    @IBOutlet weak var message: UILabel!
    
    // Iniciamos los campos de validación nada más cargar la pestaña
    override func viewDidLoad() {
        super.viewDidLoad()
        
        validateField(sender: UITextField())
        NumTarjeta.delegate = self
        MesTarjeta.delegate = self
        AnyTarjeta.delegate = self
        CvvTarjeta.delegate = self
    }
    
    //  Función que quita el teclado cuando salimos del foco del campo de texto
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    // Función que valida el tamaño máximo de caracteres en los campos de texto
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
            
            case NumTarjeta:
                let maxLength = 19
                let currentString: NSString = textField.text! as NSString
                let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
                return  newString.length <= maxLength

            case MesTarjeta:
                let maxLength = 2
                let currentString: NSString = textField.text! as NSString
                let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
                return  newString.length <= maxLength
            
            case AnyTarjeta:
                let maxLength = 2
                let currentString: NSString = textField.text! as NSString
                let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
                return  newString.length <= maxLength
            
            case CvvTarjeta:
                let maxLength = 4
                let currentString: NSString = textField.text! as NSString
                let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
                return  newString.length <= maxLength

        default:
            return true
        }
    }
    
    // Función que valida la información que se introduce en los campos del formulario
    @IBAction func validateField(sender: AnyObject) {
        
        switch (sender as! UITextField) {
            
            case NumTarjeta :
                isValidCard = false
                self.numTarjeta = NumTarjeta.text!
                if (RemoteValidators.validateCardNumber(self.numTarjeta) == true) {
                    isValidCard = true
                }
                
                isValid(card: isValidHolder, past: isValidCVV, cvv: isValidPast, titular: isValidCard)
            
            case AnyTarjeta :
                isValidPast = false
                self.expiryDate = MesTarjeta.text! + AnyTarjeta.text!
                if (RemoteValidators.validateExpiryDateNotInPast(self.expiryDate) == true) {
                    isValidPast = true
                }
                
                isValid(card: isValidHolder, past: isValidCVV, cvv: isValidPast, titular: isValidCard)
            
            case CvvTarjeta :
                isValidCVV = false
                self.cvvTarjeta = CvvTarjeta.text!
                if (RemoteValidators.validateCvn(self.cvvTarjeta) == true) {
                    isValidCVV = true
                }
                
                isValid(card: isValidHolder, past: isValidCVV, cvv: isValidPast, titular: isValidCard)
            
            case TitularTarjeta :
                isValidHolder = false
                self.titularTarjeta = TitularTarjeta.text!
                if (RemoteValidators.validateCardHolderName(self.titularTarjeta) == true) {
                    isValidHolder = true
                }
                
                isValid(card: isValidHolder, past: isValidCVV, cvv: isValidPast, titular: isValidCard)
            
        default :
          enviarAPI.isEnabled = false
          enviarAPI.layer.cornerRadius = 5
          enviarAPI.clipsToBounds = true
          enviarAPI.backgroundColor = UIColor(red: 70.0/255.0, green: 127.0/255.0, blue: 243.0/255.0, alpha: 0.5)
          enviarAPI.tintColor = UIColor.white
      }
    }
    
    // En caso de que algún parámetro sea falso, el botón se desactiva y el color cambia
    func isValid(card: Bool, past: Bool, cvv: Bool, titular: Bool) {
        if(titular && cvv && past && card) {
            enviarAPI.isEnabled = true
            enviarAPI.layer.cornerRadius = 5
            enviarAPI.clipsToBounds = true
            enviarAPI.backgroundColor = UIColor(red: 70.0/255.0, green: 127.0/255.0, blue: 243.0/255.0, alpha: 1.0)
            enviarAPI.tintColor = UIColor.white
        } else {
            enviarAPI.isEnabled = false
            enviarAPI.layer.cornerRadius = 5
            enviarAPI.clipsToBounds = true
            enviarAPI.backgroundColor = UIColor(red: 70.0/255.0, green: 127.0/255.0, blue: 243.0/255.0, alpha: 0.5)
            enviarAPI.tintColor = UIColor.white
        }
    }
    
    // Función que se activa cuando se pulsa el botón de "Enviar operación"
    @IBAction func envioOPAPI(_ sender: UIButton) {
        
        self.numTarjeta = NumTarjeta.text!
        self.mesTarjeta = MesTarjeta.text!
        self.anyTarjeta = AnyTarjeta.text!
        self.cvvTarjeta = CvvTarjeta.text!
        self.titularTarjeta = TitularTarjeta.text!
        
        // Mostramos en consola los parámetros que introducimos en el formulario
        print(
            "Tarjeta: " + self.numTarjeta
            + "\n" +
            "Mes: " + self.mesTarjeta
            + "\n" +
            "Año: " + self.anyTarjeta
            + "\n" +
            "CVV: " + self.cvvTarjeta
            + "\n" +
            "Titular: " + self.titularTarjeta
            + "\n"
        )
        
        let url = URL(string: "https://midominio.es/Authorization.php")
        guard let requestUrl = url else { fatalError() }
        
        // Preparamos el objeta de la URL
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
         
        // Concatenamos los parámetros del formulario
        let postString = "numero=" + self.numTarjeta + "&mes=" + self.mesTarjeta + "&any=" + self.anyTarjeta + "&cvv=" + self.cvvTarjeta + "&nombre=" + self.titularTarjeta;
        
        // Realizamos la petición con los datos obtenidos en el formulario
        request.httpBody = postString.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Comprobamos si hay errores al conectar con nuestro servidor
            if let error = error {
                DispatchQueue.main.async {
                    self.message.text = "Respuesta\n\n\(error)"
                    self.message.textColor = UIColor.black
                    self.message.numberOfLines = 0
                    self.message.lineBreakMode = NSLineBreakMode.byWordWrapping
                    self.message.backgroundColor = UIColor.white
                    self.message.layer.cornerRadius = 5
                    self.message.clipsToBounds = true
                    self.message.layer.shadowPath = UIBezierPath(roundedRect: self.message.bounds, cornerRadius: self.message.layer.cornerRadius).cgPath
                    self.message.layer.shadowColor = UIColor.black.cgColor
                    self.message.layer.shadowOpacity = 0.5
                    self.message.layer.shadowOffset = CGSize(width: 0, height: 0)
                    self.message.layer.shadowRadius = 5
                    self.message.layer.masksToBounds = false
                }
                print("Error al intentar conectar con su servidor. \(error)")
                return
            }
         
            // Convertimos la respuesta obtenida en tipo String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self.message.text = " Respuesta\n\n\(dataString)"
                    self.message.textColor = UIColor.black
                    self.message.numberOfLines = 0
                    self.message.lineBreakMode = NSLineBreakMode.byWordWrapping
                    self.message.backgroundColor = UIColor.white
                    self.message.layer.cornerRadius = 0
                    self.message.clipsToBounds = true
                    self.message.layer.shadowPath = UIBezierPath(roundedRect: self.message.bounds, cornerRadius: self.message.layer.cornerRadius).cgPath
                    self.message.layer.shadowColor = UIColor.black.cgColor
                    self.message.layer.shadowOpacity = 0.5
                    self.message.layer.shadowOffset = CGSize(width: 0, height: 0)
                    self.message.layer.shadowRadius = 5
                    self.message.layer.masksToBounds = false
                }
                
                print("Respuesta:\n\(dataString)")
            }
        }
        task.resume()
        
        print("Botón pulsado\n")
    }
}
