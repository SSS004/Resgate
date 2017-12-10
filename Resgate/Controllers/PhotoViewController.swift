//
//  PhotoViewController.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 05/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit
import SVProgressHUD

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
  
//##########################################
//MARK: Enumerations
//##########################################

  
//##########################################
//MARK: Outlet to Objects
//##########################################
  @IBOutlet weak var fotosCollectionView: UICollectionView!
  @IBOutlet weak var mensagemNenhumaFoto: UILabel!
  
  
  //##########################################
//MARK: Properties
//##########################################
  var umaOcorrencia : Ocorrencia!
  var mostraCameraSeColecaoZeradaDeFotos: Bool = true
  
  private var imagePicker = UIImagePickerController()
  private var indiceImagemSelecionada: Int = 0
  
  //##########################################
  //MARK: Private Methods
  //##########################################
  private func mostrarCamera() {
    
    if (umaOcorrencia.imagensFotos.count >= 6) {
      
      self.mostraAlertaOK(titulo: "Atenção!", mensagem: "Podem ser enviados no máximo 6 imagens")
      
    }
  
    //    imagePicker.sourceType = .camera  // SSSSSSS
    imagePicker.sourceType = .savedPhotosAlbum
    
    present(imagePicker, animated: true, completion: nil)

  }


  //##########################################
  //MARK: Métodos
  //##########################################
  
  
  
  //##########################################
  //MARK: Actions
  //##########################################
  @IBAction func cmdFoto(_ sender: Any) {
    
    mostrarCamera()
    
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
      
      SVProgressHUD.show()

      imagePicker.delegate = self
      
      // Configura a largura e altura da celula para caber exatamente duas fotos na largura
      // UIScreen.main.bounds.width contém a largura da tela, diminuiu-se 40 pois a view
      // da coleção esta com constraint para ter margem de 20 no lado esquerdo e direito
      // Entao (UIScreen.main.bounds.width-40)/2) seria a largura da celula.
      // Como o inimumInteritemSpacing = 10 entao diminuimos de 10 por causa deste espaço
      let cellItemSize = ((UIScreen.main.bounds.width-40)/2) - 10
      
      let layout = UICollectionViewFlowLayout()
      layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
      // A altura da celula foi acrescido de 26 pois é a altura do label "descricao da foto"
      layout.itemSize = CGSize(width: cellItemSize, height: cellItemSize + 26 )

      layout.minimumInteritemSpacing = 10
      layout.minimumLineSpacing = 10
      
      fotosCollectionView.collectionViewLayout = layout

  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    SVProgressHUD.show()
    
    fotosCollectionView.reloadData()
    
    if (mostraCameraSeColecaoZeradaDeFotos) {
      
      mostraCameraSeColecaoZeradaDeFotos = false
      if (umaOcorrencia.imagensFotos.count == 0) {
        mostrarCamera() 
      }
    }

  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    SVProgressHUD.dismiss()

  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    mensagemNenhumaFoto.isHidden = (umaOcorrencia.imagensFotos.count > 0)
    fotosCollectionView.isHidden  = (umaOcorrencia.imagensFotos.count == 0)

    return umaOcorrencia.imagensFotos.count
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celula", for: indexPath) as! ImagemFotoCollectionViewCell
    
    cell.imagemFoto.image = umaOcorrencia.imagensFotos[ indexPath.row ].imagemFoto
    cell.descricaoFoto.text = umaOcorrencia.imagensFotos[ indexPath.row ].descricaoFoto

    return cell
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    self.performSegue(withIdentifier: "seguePhoto2UmaFoto", sender: nil)
    indiceImagemSelecionada = indexPath.row
    
  }

  // Uma SEGUE foi executada para chamar uma View Controller
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "seguePhoto2UmaFoto" {
      
      // Chamou a view que mostra o MAPA, passa para a segue o endereco
      if let umaFotoView = segue.destination as? umaFotoViewController {
        umaFotoView.indiceImagemSelecionada = indiceImagemSelecionada
        umaFotoView.umaOcorrencia = umaOcorrencia
      }
    }
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
