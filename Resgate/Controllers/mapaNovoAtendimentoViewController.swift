//
//  mapaNovoAtendimentoViewController.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 04/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit
import MapKit


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

  func validaEnderecoOrigem(endereco enderecoOcorrencia: String) {
    
    let endereco = enderecoOcorrencia.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if (endereco == "") {
      let alerta = Alerta(titulo: "Aviso", mensagem: "\nEntre com o endereço da ocorrência!")
      self.present(alerta.alertaOK(), animated: true, completion: nil)
      return
    }
    
    let enderecoCompleto = "\(endereco), \(enderecoAux.locality), \(enderecoAux.country)"
    
    CLGeocoder().geocodeAddressString(enderecoCompleto) { (local, erro) in
      if (erro == nil) {
        if let dadosLocal = local?.first {
          
          self.enderecoAux.addressName = endereco
          self.enderecoAux.country = dadosLocal.country!
          self.enderecoAux.locality = dadosLocal.locality!
          self.enderecoAux.location = dadosLocal.location!

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

        }
      }
    }
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
    
    // Salva o endereco selecionado para que possa ser consumida por outra views
    enderecoSalvo.country = enderecoAux.country
    enderecoSalvo.addressName = enderecoAux.addressName
    enderecoSalvo.locality = enderecoAux.locality
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
  
  override func viewDidLoad() {
    
    super.viewDidLoad()

    self.areaEndereco.layer.cornerRadius = 10
    self.areaEndereco.clipsToBounds = true
    
    txtEnderecoOcorrencia.delegate = self

    // Inicia o gerenciador de localização
    gerenciadorLocalizacao.delegate = self
    gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
    gerenciadorLocalizacao.requestWhenInUseAuthorization()
    
    // Recebeu um endereco na variável enderecoSalvo pela view pai que chamou esta views
    if !((enderecoSalvo.location.coordinate.latitude == 0) && (enderecoSalvo.location.coordinate.longitude == 0)) {
      
        enderecoAux.addressName = enderecoSalvo.addressName
        enderecoAux.country = enderecoSalvo.country
        enderecoAux.locality = enderecoSalvo.locality
        enderecoAux.location = CLLocation(latitude: enderecoSalvo.location.coordinate.latitude, longitude: enderecoSalvo.location.coordinate.longitude)

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
      
      txtEnderecoOcorrencia.text = enderecoSalvo.addressName
      
      self.enderecoInformado = true

    } else {
      
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
            
            self.enderecoAux.addressName = placeMark.name!
            self.enderecoAux.country = placeMark.country!
            self.enderecoAux.locality = placeMark.locality!
            self.enderecoAux.location = location
            
            self.txtEnderecoOcorrencia.text = placeMark.name!
            self.gerenciadorLocalizacao.stopUpdatingLocation()
            
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
