//
//  mapaNovoAtendimentoViewController.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 04/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD


class MapaNovoAtendimentoViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
 
  
  //##########################################
  //MARK: Outlet to Objects
  //##########################################
  @IBOutlet weak var mapa: MKMapView!
  @IBOutlet weak var cmdTirarFoto: UIButton!
  @IBOutlet weak var areaEndereco: UIView!
  @IBOutlet weak var txtEnderecoOcorrencia: UITextField!
  
  
  //##########################################
  //MARK: Properties
  //##########################################
  private var enderecoInformado: Bool = false
  private var gerenciadorLocalizacao = CLLocationManager()
  private var enderecoAux = EnderecoMapa()

  // IMPORTANTE, ao chamar esta view, precisa receber um EnderecoMapa no campo enderecoSalvo
  var enderecoSalvo : EnderecoMapa!
 
  //##########################################
  //MARK: Private Methods
  //##########################################
  private func validaEnderecoOrigem(endereco enderecoOcorrencia: String) {
    
    let endereco = enderecoOcorrencia.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if (endereco == "") {
      self.mostraAlertaOK(titulo: "Aviso", mensagem: "\nEntre com o endereço da ocorrência!")
      return
    }
    
    SVProgressHUD.show()
    
    let enderecoCompleto = "\(endereco), \(enderecoAux.pais)"
    
    CLGeocoder().geocodeAddressString(enderecoCompleto) { (local, erro) in
      
      if (erro == nil) {
        
        if let dadosLocal = local?.first {
          
          self.atualizaEnderecoAux( placemark: dadosLocal )
          self.enderecoAux.endereco = endereco
          
          // Remove anotacoes antes de criar a anotação do local atual
          self.mapa.removeAnnotations(self.mapa.annotations)
          
          let coordenadas = CLLocationCoordinate2D(latitude: self.enderecoAux.location.coordinate.latitude,
                                                   longitude: self.enderecoAux.location.coordinate.longitude)
          
          let regiao = MKCoordinateRegionMakeWithDistance(coordenadas,300,300)
          self.mapa.setRegion(regiao, animated: true)
          
          // Cria anotação para o local do usuario
          let anotacaoUsuario = MKPointAnnotation()
          anotacaoUsuario.coordinate = coordenadas
          anotacaoUsuario.title = "Sua localização"
          self.mapa.addAnnotation(anotacaoUsuario)
          
          SVProgressHUD.dismiss()
          
        } else {
          
          SVProgressHUD.dismiss()
          
        }
      } else {
        
        // Não foi possivel localizar endereço
        SVProgressHUD.dismiss()
        self.mostraAlertaOK(titulo: "Aviso!", mensagem: erro.debugDescription)
      
      }
    }
  }
  
  private func atualizaEnderecoAux( placemark: CLPlacemark ) {
    
    if (placemark.name == nil) {
      self.enderecoAux.endereco = ""
    } else {
      self.enderecoAux.endereco = placemark.name!
    }

    if (placemark.subLocality == nil) {
      self.enderecoAux.bairro = ""
    } else {
      self.enderecoAux.bairro = placemark.subLocality!
    }

    if (placemark.locality == nil) {
      self.enderecoAux.localidade = ""
    } else {
      self.enderecoAux.localidade = placemark.locality!
    }

    if (placemark.administrativeArea == nil) {
      self.enderecoAux.estado = ""
    } else {
      self.enderecoAux.estado = placemark.administrativeArea!
    }

    if (placemark.postalCode == nil) {
      self.enderecoAux.codigoPostal = ""
    } else {
      self.enderecoAux.codigoPostal = placemark.postalCode!
    }
    
    if (placemark.country == nil) {
      self.enderecoAux.pais = ""
    } else {
      self.enderecoAux.pais = placemark.country!
    }

    if (placemark.isoCountryCode == nil) {
      self.enderecoAux.codigoISOPais = ""
    } else {
      self.enderecoAux.codigoISOPais = placemark.isoCountryCode!
    }
    
    self.enderecoAux.location = placemark.location!

    //  placemark.name = endereco
    //  placemark.locality = localidade
    //  placemark.subLocality = bairro
    //  placemark.administrativeArea = estado
    //  placemark.postalCode = codigoPostal
    //  placemark.country = pais
    //  placemark.isoCountryCode = codigoISOPais

/*
    
    if let placemarkName = placemark.name {
      print ( "\nplacemark.name = \(placemarkName)")
    } else {
      print ( "placemark. = \"\"")
    }

    if let placemarkThoroughfare = placemark.thoroughfare {
      print ( "placemark.thoroughfare = \(placemarkThoroughfare)")
    } else {
      print ( "placemark.thoroughfare = \"\"")
    }

    if let placemarksubThoroughfare = placemark.subThoroughfare {
      print ( "placemark.subThoroughfare = \(placemarksubThoroughfare)")
    } else {
      print ( "placemark.subThoroughfare = \"\"")
    }

    if let placemarksubLocality = placemark.subLocality {
      print ( "placemark.subLocality = \(placemarksubLocality)")
    } else {
      print ( "placemark.subLocality = \"\"")
    }
    
    if let placemarklocality = placemark.locality {
      print ( "placemark.locality = \(placemarklocality)")
    } else {
      print ( "placemark.locality = \"\"")
    }

    if let placemarkadministrativeArea = placemark.administrativeArea {
      print ( "placemark.administrativeArea = \(placemarkadministrativeArea)")
    } else {
      print ( "placemark.administrativeArea = \"\"")
    }

    if let placemarkpostalCode = placemark.postalCode {
      print ( "placemark.postalCode = \(placemarkpostalCode)")
    } else {
      print ( "placemark.postalCode = \"\"")
    }

    if let placemarkCountry = placemark.country {
      print ( "placemark.country = \(placemarkCountry)")
    } else {
      print ( "placemark.country = \"\"")
    }

    if let placemarkisoCountryCode = placemark.isoCountryCode {
      print ( "placemark.isoCountryCode = \(placemarkisoCountryCode)")
    } else {
      print ( "placemark.isoCountryCode = \"\"")
    }

 */
    
  }

  
  
  //##########################################
  //MARK: Métodos
  //##########################################
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

    if (textField == txtEnderecoOcorrencia) {
      
      txtEnderecoOcorrencia.resignFirstResponder()
      validaEnderecoOrigem(endereco: txtEnderecoOcorrencia.text!)
    }
    
    return true
  }


  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  
  //##########################################
  //MARK: Actions
  //##########################################
  @IBAction func cmdSelecionarEndereco(_ sender: UIButton) {
    
    // ==========================================================================
    // Salva o endereco selecionado para que possa ser consumida por outra views
    // ==========================================================================
    enderecoSalvo.endereco = enderecoAux.endereco
    enderecoSalvo.localidade = enderecoAux.localidade
    enderecoSalvo.bairro = enderecoAux.bairro
    enderecoSalvo.estado = enderecoAux.estado
    enderecoSalvo.codigoPostal = enderecoAux.codigoPostal
    enderecoSalvo.pais = enderecoAux.pais
    enderecoSalvo.codigoISOPais = enderecoAux.codigoISOPais

    enderecoSalvo.location = enderecoAux.location
    
    self.navigationController?.popViewController(animated: true)
    
  }
  
  
  @IBAction func bbiLigarCallCenter(_ sender: UIBarButtonItem) {
    let callCenter = CallCenterNumber()
    callCenter.callToCallCenter(view: self)
  }
  
  
  //##########################################
  //MARK: Override functions
  //##########################################
  override func viewWillDisappear(_ animated: Bool) {
    
    SVProgressHUD.dismiss()
    
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    SVProgressHUD.show()

    self.areaEndereco.layer.cornerRadius = 10
    self.areaEndereco.clipsToBounds = true
    
    txtEnderecoOcorrencia.delegate = self

    // Inicia o gerenciador de localização
    gerenciadorLocalizacao.delegate = self
    gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
    gerenciadorLocalizacao.requestWhenInUseAuthorization()
    
    // Recebeu um endereco na variável enderecoSalvo pela view pai que chamou esta views
    if !((enderecoSalvo.location.coordinate.latitude == 0) && (enderecoSalvo.location.coordinate.longitude == 0)) {
      
      self.enderecoAux.endereco = enderecoSalvo.endereco
      self.enderecoAux.bairro = enderecoSalvo.bairro
      self.enderecoAux.localidade = enderecoSalvo.localidade
      self.enderecoAux.estado = enderecoSalvo.estado
      self.enderecoAux.codigoPostal = enderecoSalvo.codigoPostal
      self.enderecoAux.pais = enderecoSalvo.pais
      self.enderecoAux.codigoISOPais = enderecoSalvo.codigoISOPais
      
      self.enderecoAux.location = CLLocation(latitude: enderecoSalvo.location.coordinate.latitude, longitude: enderecoSalvo.location.coordinate.longitude)
      
      // Remove anotacoes antes de criar a anotação do local atual
      self.mapa.removeAnnotations(self.mapa.annotations)
      
      let coordenadas = CLLocationCoordinate2D(latitude: self.enderecoAux.location.coordinate.latitude,
                                               longitude: self.enderecoAux.location.coordinate.longitude)
      
      let regiao = MKCoordinateRegionMakeWithDistance(coordenadas,300,300)
      self.mapa.setRegion(regiao, animated: true)
      
      // Cria anotação para o local do usuario
      let anotacaoUsuario = MKPointAnnotation()
      anotacaoUsuario.coordinate = coordenadas
      anotacaoUsuario.title = "Sua localização"
      self.mapa.addAnnotation(anotacaoUsuario)
      
      txtEnderecoOcorrencia.text = enderecoSalvo.endereco
      
      self.enderecoInformado = true
      
      SVProgressHUD.dismiss()
      
    } else {
      
//      gerenciadorLocalizacao.requestLocation()
      gerenciadorLocalizacao.startUpdatingLocation()
      self.enderecoInformado = false
      
    }
  }

  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    // Recupera as coordenadas do local atual
    if let coordenadas = manager.location?.coordinate {
      
      let regiao = MKCoordinateRegionMakeWithDistance(coordenadas,300,300)
      mapa.setRegion(regiao, animated: true)
      
      // Remove anotacoes antes de criar a anotação do local atual
      mapa.removeAnnotations(mapa.annotations)
      
      // Cria anotação para o local do usuario
      let anotacaoUsuario = MKPointAnnotation()
      anotacaoUsuario.coordinate = coordenadas
      anotacaoUsuario.title = "Sua localização"
      mapa.addAnnotation(anotacaoUsuario)
      
      let geoCoder = CLGeocoder()
      let location = CLLocation(latitude: coordenadas.latitude, longitude: coordenadas.longitude)
      geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
        
        if (!self.enderecoInformado) {
          
          self.enderecoInformado = true
          
          // Place details
          if let placeMark = placemarks?[0] {
            
            self.gerenciadorLocalizacao.stopUpdatingLocation()

            self.atualizaEnderecoAux(placemark: placeMark)
            self.enderecoAux.location = location
            
            self.txtEnderecoOcorrencia.text = placeMark.name!
            
            SVProgressHUD.dismiss()
            
           }
        }
      })
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
