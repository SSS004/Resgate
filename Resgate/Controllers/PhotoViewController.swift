//
//  PhotoViewController.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 05/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  
//##########################################
//MARK: Enumerations
//##########################################

  
//##########################################
//MARK: Outlet to Objects
//##########################################
  @IBOutlet weak var imagem1: UIImageView!
  @IBOutlet weak var imagem2: UIImageView!
  @IBOutlet weak var imagem3: UIImageView!
  @IBOutlet weak var imagem4: UIImageView!
  @IBOutlet weak var imagem5: UIImageView!
  @IBOutlet weak var imagem6: UIImageView!
  
  

//##########################################
//MARK: Properties
//##########################################
  var imagePicker = UIImagePickerController()
  var umaOcorrencia : Ocorrencia!
  
  //##########################################
  //MARK: Private Methods
  //##########################################
  private var imagemFotos : ImagensFoto!
  
  //##########################################
  //MARK: Métodos
  //##########################################
  
  
  
  //##########################################
  //MARK: Actions
  //##########################################
  @IBAction func cmdFoto(_ sender: Any) {
    
    if (imagemFotos.totalImagens == 6) {
      let alerta = Alerta(titulo: "Atenção!", mensagem: "Podem ser enviados no máximo 6 imagens")
      self.present(alerta.alertaOK(), animated: true, completion: nil)
    }
    
    imagePicker.sourceType = .camera  // SSSSSSS
//    imagePicker.sourceType = .savedPhotosAlbum

    present(imagePicker, animated: true, completion: nil)
    
  }
  
  @IBAction func bbiLigarCallCenter(_ sender: UIBarButtonItem) {
    let callCenter = CallCenterNumber()
    callCenter.callToCallCenter(view: self)
  }
  
  
  
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    let imagemRecuperada = info[UIImagePickerControllerOriginalImage] as! UIImage
    
    switch (imagemFotos.totalImagens) {
    case 0:
      imagemFotos.totalImagens = 1
      imagemFotos.imagem1 = imagemRecuperada
      imagem1.image = imagemRecuperada
    case 1:
      imagemFotos.totalImagens = 2
      imagemFotos.imagem2 = imagemRecuperada
      imagem2.image = imagemRecuperada
    case 2:
      imagemFotos.totalImagens = 3
      imagemFotos.imagem3 = imagemRecuperada
      imagem3.image = imagemRecuperada
    case 3:
      imagemFotos.totalImagens = 4
      imagemFotos.imagem4 = imagemRecuperada
      imagem4.image = imagemRecuperada
    case 4:
      imagemFotos.totalImagens = 5
      imagemFotos.imagem5 = imagemRecuperada
      imagem5.image = imagemRecuperada
    case 5:
      imagemFotos.totalImagens = 6
      imagemFotos.imagem6 = imagemRecuperada
      imagem6.image = imagemRecuperada
    default:
      let alerta = Alerta(titulo: "Atenção!", mensagem: "Podem ser enviados no máximo 6 imagens")
      self.present(alerta.alertaOK(), animated: true, completion: nil)
    
    }
    imagePicker.dismiss(animated: true, completion: nil)
    
  }
  
  
  //##########################################
  //MARK: Override functions
  //##########################################



  
    override func viewDidLoad() {
        super.viewDidLoad()

     // Do any additional setup after loading the view.
      imagePicker.delegate = self
      
      imagem1.image = nil
      imagem2.image = nil
      imagem3.image = nil
      imagem4.image = nil
      imagem5.image = nil
      imagem6.image = nil
      
      imagemFotos = umaOcorrencia.documentos
      
      if (imagemFotos.totalImagens > 0) {
        for i in 1 ... imagemFotos.totalImagens {
          
          switch i {
          case 1:
            imagem1.image = imagemFotos.imagem1
          case 2:
            imagem2.image = imagemFotos.imagem2
          case 3:
            imagem3.image = imagemFotos.imagem3
          case 4:
            imagem4.image = imagemFotos.imagem4
          case 5:
            imagem5.image = imagemFotos.imagem5
          case 6:
            imagem6.image = imagemFotos.imagem6
          default:
            imagemFotos.totalImagens = 6
          }
          
        }
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
