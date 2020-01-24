//
//  RemoteValidators.swift
//  addonpayments
//
//  Created by Comercia on 2020.
//  Copyright © 2020 Addon Payments. All rights reserved.
//

import Foundation
import UIKit

// Considere la posibilidad de refactorizar el código para utilizar los operadores no opcionales.

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

class RemoteValidators: NSObject {
    
    /**
        Valide el número de la tarjeta.
        Devuelve verdadero si el número de tarjeta es válido.
        Sólo permite valores numéricos no vacíos entre 12 y 19 caracteres.
        También se realiza una comprobación de Luhn con el número de tarjeta.
     
        - parameter cardNumber: El número de tarjeta de crédito a comprobar
        - returns: Devuelve true si el número de tarjeta es válido
    */
    
    class func validateCardNumber(_ cardNumber: String?) -> Bool {

        if let number = cardNumber {

            // Prueba numérica y de longitud entre 12 y 19
            let regex = "^\\d{12,19}$"
            if number.range(of: regex, options: .regularExpression) == nil {
                return false
            }

            // Comprobación lhun
            var sum = 0;
            var digit = 0;
            var addend = 0;
            var timesTwo = false;
            let length = number.count - 1;

            for i in (0...length).reversed() {
                //digit = Int(number[number.index(number.startIndex, offsetBy: i) ..< number.index(number.startIndex, offsetBy: 2)])!

                if (timesTwo) {
                    addend = digit * 2;
                    if (addend > 9) {
                        addend -= 9;
                    }
                } else {
                    addend = digit;
                }
                sum += addend;
                timesTwo = !timesTwo;
            }

            let modulus = sum % 10;
            if (modulus != 0) {
                return false;
            }

            return true;

        }
        return false
    }

    /**
        Validar el nombre del titular de la tarjeta.
        Devuelve verdadero si el titular de la tarjeta es válido.
        Sólo permite valores ISO/IEC 8859-1 no vacíos de 100 caracteres o menos.
     
        - parameter cardHolderName: El nombre del titular de la tarjeta a validar
        - returns: Devuelve true si el nombre del titular de la tarjeta es válido
    */
    class func validateCardHolderName(_ cardHolderName: String?) -> Bool {
        // Prueba por undefined
        if let name = cardHolderName {

            // Prueba de espacio en blanco
            let trimmedString = name.trimmingCharacters(in: CharacterSet.whitespaces)
            if trimmedString == "" {
                return false
            }

            // Probar los caracteres ISO/IEC 8859-1 entre 1 y 100
            let regex = "^[\\u0020-\\u007E\\u00A0-\\u00FF]{1,100}$"
            if name.range(of: regex, options: .regularExpression) == nil {
                return false
            }

            return true

        }
        return false
    }

    /**
        Valide el CVN de Amex.
        Se aplica a los tipos de tarjeta Amex.
        Sólo permite 4 caracteres numéricos.
     
        - parameter cvn: El CVN de Amex a validar
        - returns: Devuelve true si el CVN de Amex es válido
    */
    class func validateAmexCvn(_ cvn: String?) -> Bool {
        if let cvnNumber = cvn {
            // Comprobación de longitud máximo y mínimo 4 caracteres
            let regex = "^\\d{4}$"
            if cvnNumber.range(of: regex, options: .regularExpression) == nil {
                return false
            }
            return true
        }
        return false
    }


    /**
        Validar CVN.
        Se aplica a los tipos de tarjetas no Amex.
        Sólo permite 3 caracteres numéricos.
     
        - parameter cvn: El CVN a validar
        - returns: Devuelve true si el el CVN es correcto
    */
    class func validateCvn(_ cvn: String?) -> Bool {
        if let cvnNumber = cvn {
            // test numeric length 3
            let regex = "^\\d{3}$"
            if cvnNumber.range(of: regex, options: .regularExpression) == nil {
                return false
            }
            return true
        }
        return false
    }

    /**
        Validar el formato de la fecha de caducidad.
        Sólo permite 4 caracteres numéricos.
        El mes debe estar entre el 1 y el 12.
     
        - parameter expiryDate: La fecha de caducidad de la tarjeta a validar
        - returns: Vuelve true si la fecha de caducidad es válida
    */
    class func validateExpiryDateFormat(_ expiryDate: String?) -> Bool {
        if let date = expiryDate {
            // Comprueba que se reciben 4 números
            let regex = "^\\d{4}$"
            if date.range(of: regex, options: .regularExpression) == nil {
                return false
            }
            let month = Int(date[date.index(date.startIndex, offsetBy: 0) ..< date.index(date.startIndex, offsetBy: 2)])!

            // El valor del mes debe ser entre 1 y 12
            if (month < 1 || month > 12) {
                return false;
            }
            return true
        }
        return false
    }

    /**
        Valida que la fecha de caducidad sea actual o superior.
        Hace la comprobación de la función validateExpiryDateFormat.
     
        - parameter expiryDate: La fecha de caducidad de la tarjeta para validar
        - returns: Devuelve true si la fecha de caducidad no está en el pasado
    */
    class func validateExpiryDateNotInPast(_ expiryDate: String?) -> Bool {
        if let date = expiryDate {
            // Valida el formato de la fecha
            if self.validateExpiryDateFormat(date) == false {
                return false
            }

            let month = Int(date[date.index(date.startIndex, offsetBy: 0) ..< date.index(date.startIndex, offsetBy: 2)])
            let year = Int(date[date.index(date.startIndex, offsetBy: 2) ..< date.index(date.startIndex, offsetBy: 4)])

            let components = (Calendar.current as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month], from: Date())
            let currentMonth = components.month
            let currentYear = components.year

            if (year! < (currentYear! % 100)) {
                return false;
            } else if (year! == (currentYear! % 100) && month! < currentMonth!) {
                return false;
            }
            return true
        }
        return false
    }
    
}
