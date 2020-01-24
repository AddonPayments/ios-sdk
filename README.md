<a href="https://desarrolladores.addonpayments.com/" target="_blank">
    <img src="https://desarrolladores.addonpayments.com/assets/images/branding/comercia/logo.svg?v=?v=1.14.1" alt="Addon Payments logo" title="Addon Payments" align="right" width="225" />
</a>

# SDK de iOS Comercia Global Payments

Este SDK ha sido adaptado por Comercia Global Payments para facilitar las validaciones y la integración de su terminal Addon Payments en su aplicación de iOS.

## Soluciones

### General

* Validación de campos del formulario
* Envío de petición vía API mediante el método POST
* Envío de petición JSON vía HPP mediante el método POST
* Minimizar los requisitos de cumplimiento de PCI con las soluciones de HPP
* Cifrado seguro de extremo a extremo

## Requisitos

- iOS 10.0+
- Xcode 11+

## Compilación

El proyecto se ha realizado bajo iOS 13.2 en Xcode 11.3.1 y se ha probado en iPhone 11 Pro Max.

Si se realiza la compilación del proyecto en una versión inferior a iOS 13 dará errores de visualización que se han implementado en la última versión de iOS, no obstante, las funciones de validación (RemoteValidators.swift) y las peticiones a los servidores (ApiController.swift y HppController.swift) funcionan correctamente y se pueden implementar en proyectos que tengan como mínimo la versión 10 de iOS.

## Instalación

En la carpeta "validadores" podrá encontrar el archivo swift con las funciones para validar los campos de su formulario antes de enviarlo a su servidor.

- [RemoteValidators.swift](https://github.com/AddonPayments/ios-sdk/tree/master/validadores)

## Documentación y ejemplos

Puede encontrar una documentación adaptada al envío de operaciones por remoto y por redirección, ejecutando el archivo "index.html" desde su servidor.

Este archivo se encuentra dentro de la carpeta "test" del repositorio GitHub. Si lo prefiere, también puede ver nuestra documentación oficial en la página web de desarrolladores de [Addon Payments](https://desarrolladores.addonpayments.com) donde encontrará además tarjetas con las que realizar pruebas de compra y el resto de librerías disponibles.

*Consejo rápido*: ¡[El código fuente de pruebas incluido](https://github.com/addonpayments/ios-sdk/tree/master/test) puede ser una gran fuente de ejemplos de código para usar el SDK! Además proporcionamos un buscador dinámico de errores donde podrá buscar tanto por código como por descripción del error devuelto por el servidor, así como una posible solución.

#### Procesar un pago

Para realizar transacciones desde un cliente iOS por remoto, debe enviar las peticiones a su servidor con una de nuestras librerías para procesar las pagos:

- [PHP](https://github.com/AddonPayments/php-sdk)
- [JAVA](https://github.com/AddonPayments/java-sdk)
- [.NET](https://github.com/AddonPayments/net-sdk)

#### Datos de tarjeta de prueba

Nombre      | Número           | Exp Mes   | Exp Año  | CVN
----------- | ---------------- | --------- | -------- | ----
Visa        | 4263970000005262 | 12        | 2025     | 123
MasterCard  | 2223000010005780 | 12        | 2019     | 900
MasterCard  | 5425230000004415 | 12        | 2025     | 123
Discover    | 6011000000000087 | 12        | 2025     | 123
Amex        | 374101000000608  | 12        | 2025     | 1234
JCB         | 3566000000000000 | 12        | 2025     | 123
Diners Club | 36256000000725   | 12        | 2025     | 123

## Soporte

En caso de que quiera hablar con un especialista de Addon Payments, deberá llamar al teléfono [914 353 028](tel:914353028) o enviar un email a [soporte@addonpayments.com](mailto:soporte@addonpayments.com).

## Contribuyendo

¡Todo nuestro código es de código abierto y animamos a otros desarrolladores a contribuir y ayudar a mejorarlo!

1. Fork it
2. Cree su rama de características (`git checkout -b mi-nueva-feature`)
3. Asegúrese de que las pruebas de SDK son correctas
4. Confirme sus cambios (`git commit -am 'Añadir un commit'`)
5. Empujar a la rama (`git push origin mi-nueva-feature`)
6. Crear una nueva solicitud de extracción

## Licencia

Este proyecto está licenciado bajo MIT. Consulte el archivo ["LICENSE.md"](LICENSE.md) ubicado en la raíz del proyecto para obtener más detalles.
