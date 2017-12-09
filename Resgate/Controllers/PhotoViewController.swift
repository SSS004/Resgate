//
//  PhotoViewController.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 05/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
  
//##########################################
//MARK: Enumerations
//##########################################

  
//##########################################
//MARK: Outlet to Objects
//##########################################
  @IBOutlet weak var fotosCollectionView: UICollectionView!

  //##########################################
//MARK: Properties
//##########################################
  var umaOcorrencia : Ocorrencia!
  
  //##########################################
  //MARK: Private Methods
  //##########################################
  private var imagePicker = UIImagePickerController()

  //##########################################
  //MARK: Métodos
  //##########################################
  
  
  
  //##########################################
  //MARK: Actions
  //##########################################
  @IBAction func cmdFoto(_ sender: Any) {
    
    if (umaOcorrencia.imagensFotos.count >= 6) {
      let alerta = Alerta(titulo: "Atenção!", mensagem: "Podem ser enviados no máximo 6 imagens")
      self.present(alerta.alertaOK(), animated: true, completion: nil)
    }
    
//    imagePicker.sourceType = .camera  // SSSSSSS
    imagePicker.sourceType = .savedPhotosAlbum

    present(imagePicker, animated: true, completion: nil)
    
  }
  
  @IBAction func bbiLigarCallCenter(_ sender: UIBarButtonItem) {
    let callCenter = CallCenterNumber()
    callCenter.callToCallCenter(view: self)
  }
  

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    let indexPath = IndexPath(row:umaOcorrencia.imagensFotos.count, section: 0)

    let imagemRecuperada = info[UIImagePickerControllerOriginalImage] as! UIImage
    let indiceProximaFoto = umaOcorrencia.imagensFotos.count + 1
    let foto = UmaFoto(imagem: imagemRecuperada, descricao: "Foto \(indiceProximaFoto) ")
    umaOcorrencia.imagensFotos.append(foto)
    
    fotosCollectionView.insertItems(at: [indexPath])

    imagePicker.dismiss(animated: true, completion: nil)
    
  }
  
  
  //##########################################
  //MARK: Override functions
  //##########################################



  
    override func viewDidLoad() {
      
        super.viewDidLoad()

     // Do any additional setup after loading the view.
      imagePicker.delegate = self
      
      let cellItemSize = ((UIScreen.main.bounds.width-40)/2) - 10
      
      let layout = UICollectionViewFlowLayout()
      layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
      layout.itemSize = CGSize(width: cellItemSize, height: cellItemSize + 26 )

      layout.minimumInteritemSpacing = 10
      layout.minimumLineSpacing = 10
      
      fotosCollectionView.collectionViewLayout = layout
      
      

  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return umaOcorrencia.imagensFotos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celula", for: indexPath) as! ImagemFotoCollectionViewCell
    
    cell.imagemFoto.image = umaOcorrencia.imagensFotos[ indexPath.row ].imagemFoto
    cell.descricaoFoto.text = umaOcorrencia.imagensFotos[ indexPath.row ].descricaoFoto

    return cell
    
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
