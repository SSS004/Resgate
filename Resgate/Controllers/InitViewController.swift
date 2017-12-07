//
//  InitViewController.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 30/11/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class InitViewController: UIViewController {
  
  //=======================================
  //MARK: Outlet to Objects
  //=======================================
  @IBOutlet weak var initActivityIndicator: UIActivityIndicatorView!
  
  //=======================================
  //MARK: Properties
  //=======================================
  
  //=======================================
  //MARK: Private Methods
  //=======================================
  private var handle: AuthStateDidChangeListenerHandle?
  
  //=======================================
  //MARK: Actions
  //=======================================
  
  //=======================================
  //MARK: Override functions
  //=======================================
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    appVariables.salvarUsuario = true // Valor default para o botão salvar usuario da tela de Login
    
    initActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
    initActivityIndicator.hidesWhenStopped = true
    initActivityIndicator.startAnimating()
    
    // Do any additional setup after loading the view.
  }
  
//  override func viewWillAppear(_ animated: Bool) {
//    
//    super.viewWillAppear(animated)
//    
//    // [START auth_listener]
//    handle = Auth.auth().addStateDidChangeListener { (auth, user) in
//
//      if user != nil {  // Se usuário logado, mostra a tela do homes
//
//        print ("111 Mostra segueInt2Home viewWillAppear")
//        self.performSegue(withIdentifier: "segueInit2Home", sender: nil)
//
//      } else {
//
//        print ("222 Mostra segueInit2Login viewWillAppear")
//        self.performSegue(withIdentifier: "segueInit2Login", sender: nil)
//
//      }
//
//    }
//    // [END auth_listener]
//  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    if (Auth.auth().currentUser != nil) {
      
      self.performSegue(withIdentifier: "segueInit2Home", sender: nil)
      
    } else {
      
//      self.performSegue(withIdentifier: "segueInit2Login", sender: nil)
      self.performSegue(withIdentifier: "segueInit2Login", sender: nil)

    }

  }
  
  override func viewWillDisappear(_ animated: Bool) {

    super.viewWillDisappear(animated)
    
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
