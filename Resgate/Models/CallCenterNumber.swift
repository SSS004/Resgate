//
//  CallCenterNumber.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 06/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit

class CallCenterNumber {
  
  public var formattedNumber = ""
  public var cleanNumber = ""
  
  init() {
    formattedNumber = "+55 (11) 96373-0002"
    cleanNumber = "+5511963730002"
  }

  func callToCallCenter (view: UIViewController) {
    
    if let phoneCallURL:URL = URL(string: "tel:\(cleanNumber)") {
      let application:UIApplication = UIApplication.shared
      if (application.canOpenURL(phoneCallURL)) {
        application.open(phoneCallURL, options: [:], completionHandler: nil)

//        let alertController = UIAlertController(title: "Resgate", message: "Deseja ligar para o Call Center ?\n\(formattedNumber)?", preferredStyle: .alert)
//        let yesPressed = UIAlertAction(title: "Sim", style: .default, handler: { (action) in
//          application.open(phoneCallURL, options: [:], completionHandler: nil)
//        })
//        let noPressed = UIAlertAction(title: "Não", style: .default, handler: { (action) in
//
//        })
//        alertController.addAction(yesPressed)
//        alertController.addAction(noPressed)
//
//        view.present(alertController, animated: true, completion: nil)
      }
    }
  }
  
}
