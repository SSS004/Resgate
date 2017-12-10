//
//  ViewControllerExtensions.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 10/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func mostraAlertaOK( titulo tituloAlerta: String, mensagem mensagemAlerta: String) {

      let alerta = UIAlertController(title: tituloAlerta, message: mensagemAlerta, preferredStyle: .alert)
      let acaoOK = UIAlertAction(title: "OK", style: .default, handler: nil)
      alerta.addAction(acaoOK)
    
      self.present(alerta, animated: true, completion: nil)
    
  }
  
  //================================================================
  // Implementa a possibilidade de usar o botão Proximo do Teclado
  // para ir para o proximo campo quando for pressionado
  //================================================================
  func conectarCamposPelaTeclaDeRetorno(fields:[UITextField], returnKeyType retKeyType: UIReturnKeyType) {
    
    guard let last = fields.last else {
      return
    }
    
    for i in 0 ..< fields.count - 1 {
      fields[i].returnKeyType = .next
      fields[i].addTarget(fields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
    }
    last.returnKeyType = retKeyType
    last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    
  }

  func conectarCamposPelaTeclaDeRetornoLoop(fields:[UITextField]) {

    if (fields.count <= 1) {
      return
    }
    
    for i in 0 ..< fields.count {
      fields[i].returnKeyType = .next
      if (i == (fields.count-1)) {
        fields[i].addTarget(fields[0], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
      } else {
        fields[i].addTarget(fields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
      }
    }
  }

  
  func setTextFieldPasswordButtonImage(textFieldArray fields:[UITextField], iconName icon: String ) {
    
    if let iconImage = UIImage(named: icon) {
      for campo in fields {
        campo.showPasswordButtonWithImage(iconImage)
      }
    }
  }
  
  func setTextFieldClearButtonImage(textFieldArray fields:[UITextField], iconName icon: String ) {
    
    if let iconImage = UIImage(named: icon) {
      for campo in fields {
        campo.showClearButtonWithImage(iconImage)
      }
    }
  }
    
}
