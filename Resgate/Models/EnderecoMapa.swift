//
//  EnderecoMapa.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 05/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit
import MapKit

class EnderecoMapa {

  public var addressName: String
  public var country: String
  public var locality: String
  public var location: CLLocation

  init() {
      self.addressName = ""
      self.country = ""
      self.locality = ""
      self.location = CLLocation(latitude: 0, longitude: 0)
  }

}

