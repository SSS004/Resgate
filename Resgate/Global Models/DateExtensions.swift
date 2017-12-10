//
//  DateExtensions.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 10/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit

//=======================================
//MARK: UITextField extension
//=======================================
extension Date {

  func devolveDataHoraFormatada() -> String {

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    
    return dateFormatter.string(from: self)
    
  }

  func devolveDataFormatada() -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    
    return dateFormatter.string(from: self)
    
  }

}

