//
//  Alerta.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 29/11/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit

class Alerta {
    
    var titulo: String
    var mensagem: String
    
    init(titulo: String, mensagem: String) {
        self.titulo = titulo
        self.mensagem = mensagem
    }
    
    func alertaOK() -> UIAlertController {
        
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoOK = UIAlertAction(title: "OK", style: .default, handler: nil)
        alerta.addAction(acaoOK)
        
        return alerta

    }
}

