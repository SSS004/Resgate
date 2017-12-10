//
//  TextFieldExtensions.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 29/11/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit

private var __maxLengths = [UITextField: Int]()

//=======================================
//MARK: UITextField extension
//=======================================
extension UITextField {


  //================================================================
  // Implementa o tamanho máximo de caracteres para um Text Field
  //================================================================
  @IBInspectable var maxLength: Int {
    get {
      guard let l = __maxLengths[self] else {
        return 150 // (global default-limit. or just, Int.max)
      }
      return l
    }
    set {
      __maxLengths[self] = newValue
      addTarget(self, action: #selector(fixMaxLenght), for: .editingChanged)
    }
  }
  
  @objc func fixMaxLenght(textField: UITextField) {
    let t = textField.text
    textField.text = t?.safelyLimitedTo(length: maxLength)
  }

  
  //=====================================================
  // Mostra somente a borda inferior de um Text Field
  // Utilizar na "func viewDidAppear"
  // Parametros:
  //  1) backgroundColor: Cor atual do fundo do textbox
  //  2) lineColor: Cor da borda inferior que sera desenhada
  //  3) borderWidth: Largura da borda inferior
  //=====================================================
  func underline(backgroundColor: UIColor, lineColor: UIColor, borderWidth: CGFloat) {
    
    //-------------------------------------------------------------
    // Desenha um retangulo para sumir com a borda do Text Field
    //-------------------------------------------------------------
    let borderBackground = CALayer()
    borderBackground.borderColor = backgroundColor.cgColor
    borderBackground.frame = CGRect(x: -1,
                                    y: -1,
                                    width:self.frame.size.width+2,
                                    height: self.frame.size.height+2)
    borderBackground.borderWidth = 3
    self.layer.addSublayer(borderBackground)
    
    //-------------------------------------------------------------
    // Desenha a borda inferior do Text Field
    //-------------------------------------------------------------
    let borderLine = CALayer()
    borderLine.borderColor = lineColor.cgColor
    borderLine.frame = CGRect(x: 0,
                              y: self.frame.size.height - borderWidth,
                              width: self.frame.size.width,
                              height: borderWidth)
    borderLine.borderWidth = borderWidth
    self.layer.addSublayer(borderLine)
    
    self.layer.masksToBounds = true
    
  }
  
  //=====================================================
  // Altera atributos da borda de um Text Field
  // Utilizar na "func viewDidLoad"
  //=====================================================
  func setBorderAttrib(cornerRadius: CGFloat, borderWidth: CGFloat, lineColor: UIColor) {
    
    self.layer.cornerRadius = cornerRadius
    self.layer.borderWidth = borderWidth
    self.layer.borderColor = lineColor.cgColor
    self.layer.masksToBounds = true
  }

  //=====================================================
  // Permite alterar a imagem do "Clear Button"
  // de um Text Field
  //=====================================================
  func showClearButtonWithImage(_ image: UIImage) {
    let clearButton = UIButton()
    clearButton.setImage(image, for: .normal)
    clearButton.frame = CGRect(x: 0, y: 0, width: 25, height: 16)
    clearButton.contentMode = .scaleAspectFit
    clearButton.addTarget(self, action: #selector(self.clearTextButton(sender:)), for: .touchUpInside)
    self.rightView = clearButton
    self.rightViewMode = .always
  }
  
  @objc func clearTextButton(sender: AnyObject) {
    self.text = ""
  }
  
  //=====================================================
  // Permite alterar a imagem do "Show Password Button"
  // de um Text Field
  //=====================================================
  func showPasswordButtonWithImage(_ image: UIImage) {
    
    let showPasswordButton = UIButton()
    showPasswordButton.setImage(image, for: .normal)
    showPasswordButton.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
    showPasswordButton.contentMode = .scaleAspectFit
    showPasswordButton.addTarget(self, action: #selector(self.setPasswordVisible(sender:)), for: .touchUpInside)
    self.rightView = showPasswordButton
    self.rightViewMode = .always
  }
  
  @objc func setPasswordVisible(sender: AnyObject) {
    self.isSecureTextEntry = !self.isSecureTextEntry
    self.clearsOnInsertion = self.isSecureTextEntry
  }


  
}



