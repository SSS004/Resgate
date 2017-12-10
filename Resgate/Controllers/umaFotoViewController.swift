//
//  umaFotoViewController.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 08/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit

class umaFotoViewController: UIViewController, UIScrollViewDelegate {

  //##########################################
  //MARK: Enumerations
  //##########################################
  
  
  
  //##########################################
  //MARK: Outlet to Objects
  //##########################################
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var imageView: UIImageView!
  
  //##########################################
  //MARK: Properties
  //##########################################
  
  var umaOcorrencia: Ocorrencia!     // PARAMETRO PASSADO PELA VIEW QUE CHAMAR ESTA VIEW
  var indiceImagemSelecionada: Int!  // PARAMETRO PASSADO PELA VIEW QUE CHAMAR ESTA VIEW
  
  //##########################################
  //MARK: Private Methods
  //##########################################
  
  
  
  //##########################################
  //MARK: Métodos
  //##########################################
  
  
  
  //##########################################
  //MARK: Actions
  //##########################################
  @IBAction func cmdLixo(_ sender: UIButton) {
    
    umaOcorrencia.imagensFotos.remove(at: indiceImagemSelecionada)
    self.navigationController?.popViewController(animated: true)
    
  }
  
  //##########################################
  //MARK: Override functions
  //##########################################

  
    override func viewDidLoad() {
      
      super.viewDidLoad()
      
      imageView.image = umaOcorrencia.imagensFotos[ indiceImagemSelecionada ].imagemFoto
      
      self.scrollView.minimumZoomScale = 1.0
      self.scrollView.maximumZoomScale = 5.0
      
    }

  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.imageView
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
