//
//  CadastroViewController.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 28/11/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import SVProgressHUD

class CadastroViewController: UIViewController, UITextFieldDelegate {
  
//##########################################
//MARK: Outlet to Objects
//##########################################

  @IBOutlet weak var txtNomeCompleto: UITextField!
  @IBOutlet weak var txtEmail: UITextField!
  @IBOutlet weak var txtSenha: UITextField!
  @IBOutlet weak var txtConfirmaSenha: UITextField!
  @IBOutlet weak var cmdCadastrar: UIButton!
  @IBOutlet weak var masterView: UIView!
  
  
//##########################################
//MARK: Properties
//##########################################

  
  
//##########################################
//MARK: Private Methods
//##########################################

  // ===========================================================================================
  // Verifica se os campos possuem informação válida
  // ===========================================================================================
  private func validarCamposCadastro() -> Bool {
    
    let minLenght = 6
    let maxLenght = 40
    
    // ******************************************************
    // Validar informações digitadas
    // Obtem as informações sem os espaços em branco no
    // inicio/final do texto
    // ******************************************************
    if let nomeCompleto = self.txtNomeCompleto.text?.trimmingCharacters(in: .whitespacesAndNewlines){
      if let email = self.txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
        if let senha = self.txtSenha.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
          if let senhaConfirma = self.txtConfirmaSenha.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            
            // Verifica se os campos estao preenchidos
            if (nomeCompleto.isEmpty) || (email.isEmpty) || (senha.isEmpty) || (senhaConfirma.isEmpty) {
              
              SVProgressHUD.dismiss()
              
              // Avisa que todos os campos precisam ser preenchidos
              let alerta = Alerta(titulo: "Atenção!", mensagem: "Todos os campos precisam ser preenchidos")
              self.present(alerta.alertaOK(), animated: true, completion: nil)
              return false
              
            } else {
              
              // Valida o nome que precisa ter pelo menos nome e sobrenome
              let nomeValidado = nomeCompleto.x_validaNome()
              
              if (nomeValidado == "") {
                
                SVProgressHUD.dismiss()
                
                // Avisa que todos os campos precisam ser preenchidos
                let alerta = Alerta(titulo: "Atenção!", mensagem: "\nO nome precisa sem completo (nome e sobrenome) e não pode ter caracteres especiais")
                self.present(alerta.alertaOK(), animated: true, completion: nil)
                return false
                
              } else {
                txtNomeCompleto.text = nomeValidado
              }
              
              // Valida o formato do email
              let emailValidado = email.x_isValidEmailAddressStr()
              if (emailValidado == "") {
                
                SVProgressHUD.dismiss()
                
                // Avisa que todos os campos precisam ser preenchidos
                let alerta = Alerta(titulo: "Atenção!", mensagem: "\nO email não possui um formato válido, favor corrigir.")
                self.present(alerta.alertaOK(), animated: true, completion: nil)
                return false
                
              } else {
                txtEmail.text = emailValidado
              }
              
              // Valida se senha e confirmação de senha estão iguais
              if senha == senhaConfirma {
                
                // Verifica se a senha é válida
                if try! senha.x_isPasswordValid(minimumLenght: minLenght,
                                                maximumLenght: maxLenght,
                                                numericCharacterRequired: false,
                                                lowercaseCharacterRequired: false,
                                                uppercaseCharacterRequired: false,
                                                symbolCharacterRequired: false) {
                  // Todos os campos estão válidos
                  return true
                  
                } else {
                  
                  SVProgressHUD.dismiss()
                  
                  // Avisa que a confirmação de senha está diferente da senhas
                  let alerta = Alerta(titulo: "Atenção!", mensagem: "A senha precisa atender as seguintes regras:\n 1) Conter somente letras e números.\n 2) Ter no mínimo \(minLenght) e no máximo \(maxLenght) caracteres")
                  self.present(alerta.alertaOK(), animated: true, completion: nil)
                  return false
                }
                
              } else {
                
                SVProgressHUD.dismiss()
                
                // Avisa que a confirmação de senha está diferente da senhas
                let alerta = Alerta(titulo: "Atenção!", mensagem: "A confirmação da senha está diferente")
                self.present(alerta.alertaOK(), animated: true, completion: nil)
                return false
              }
            }
          }
        }
      }
    }
    
    SVProgressHUD.dismiss()
    
    return false
  }
  
  
  
//##########################################
//MARK: Métodos
//##########################################

  // ===========================================================================================
  // Faz com que o foco mude de Field ao teclar Return. Se estiver no
  // ultimo, executa o button cmdCadastrars
  // ===========================================================================================
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    
    if (textField == txtConfirmaSenha) {
      txtConfirmaSenha.resignFirstResponder()
      cmdCadastrar.becomeFirstResponder()
      cmdCadastrar.sendActions(for: UIControlEvents.touchUpInside)
    }
    
    return true
    
  }
  
  
//##########################################
//MARK: Actions
//##########################################
  
  @IBAction func cmdCadastrar(_ sender: Any) {
    
    // Esconde o teclado
    view.endEditing(true)
    
    SVProgressHUD.show()
    
    if !validarCamposCadastro() {
      SVProgressHUD.dismiss()
      return
    }
    
    let email = txtEmail.text
    let senha = txtSenha.text
    
    // Realiza o cadastro do usuário na autenticacao do Firebase. Esta chamada é assincrona, o sistema continua a executar as linhas de codigo
    // posteriores. Quando a função retornar, o sistema executara o codigo escrito para o create user que verifica se o usuário foi criado
    let autenticacao = Auth.auth()
    autenticacao.createUser(withEmail: email!,
                            password: senha!) { (usuario, erro) in
                              
                              // Não ocorreu erro na execução da funçãos
                              if (erro == nil) {
                                
                                // Usuário foi criado ?
                                if (usuario != nil) {
                                  
                                  // Verifica se precisa Salvar o usuario como UserDefault
                                  if UserDefaults.standard.object(forKey: "salvarUsuario") != nil {
                                    // ==========================================
                                    // Existe o UserDefault, atualiza a tela
                                    // ==========================================
                                    
                                    // Atualiza o switch "salvar usuario"
                                    let salvarUsuario = UserDefaults.standard.bool(forKey: "salvarUsuario")
                                    if salvarUsuario {
                                      atualizarUserDefaults(salvarUsuario: true, emailAddress: email!)
                                    }
                                    
                                  }
                                  
                                  let nomeUsuario = self.txtNomeCompleto.text
                                  
                                  let dadosUsuario = ["email": usuario?.email,"nome": nomeUsuario]
                                  let database = Database.database().reference()
                                  
                                  let usuarios = database.child("usuarios")
                                  
                                  usuarios.child((usuario?.uid)!).setValue(dadosUsuario)
                                  
                                  SVProgressHUD.dismiss()
                                  
                                  self.performSegue(withIdentifier: "segueCadastro2Home", sender: nil)
                                  
                                } else {
                                  
                                  SVProgressHUD.dismiss()
                                  
                                  let alerta = Alerta(titulo: "Não foi possivel criar o acesso!", mensagem: "Usuário não foi criado")
                                  self.present(alerta.alertaOK(), animated: true, completion: nil)
                                  
                                }
                              } else {
                                
                                if let errCode = AuthErrorCode(rawValue: erro!._code) {
                                  
                                  var mensagemErroString = getFirebaseErrorMessage(errorCode: errCode)
                                  
                                  if mensagemErroString == "" {
                                    mensagemErroString = (erro?.localizedDescription)!
                                  }
                                  
                                  SVProgressHUD.dismiss()
                                  
                                  let alerta = Alerta(titulo: "Não foi possivel criar o acesso!", mensagem: mensagemErroString)
                                  self.present(alerta.alertaOK(), animated: true, completion: nil)
                                  
                                } else {
                                  
                                  SVProgressHUD.dismiss()
                                  
                                  let alerta = Alerta(titulo: "Não foi possivel criar o acesso!", mensagem: "Ocorreu erro desconhecido ao tentar criar o usuário")
                                  self.present(alerta.alertaOK(), animated: true, completion: nil)
                                  
                                }
                                
                              }
    }
    
  }
  
  
//##########################################
//MARK: Override functions
//##########################################
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    // ************************************
    // Alterar bordas dos Text Fields
    // ************************************
    let lnColor : UIColor = UIColor.white  // Seleciona a cor
    
    txtNomeCompleto.setBorderAttrib(cornerRadius: 4.0, borderWidth: 1.0, lineColor: lnColor)
    txtEmail.setBorderAttrib(cornerRadius: 4.0, borderWidth: 1.0, lineColor: lnColor)
    txtSenha.setBorderAttrib(cornerRadius: 4.0, borderWidth: 1.0, lineColor: lnColor)
    txtConfirmaSenha.setBorderAttrib(cornerRadius: 4.0, borderWidth: 1.0, lineColor: lnColor)
    
    //Configurar arredondamento do botao Acessar para ter os cantos arredondados
    self.cmdCadastrar.layer.cornerRadius = 7.5
    self.cmdCadastrar.clipsToBounds = true

    // -------------------------------------------------------------------------------------------------
    // Configura a sequencia de Text Fields quando usuário teclar no botão "Proximo / Next" do teclado
    // E configura o Text Field da confirmação de senha para tratar o evento do return key
    // Permite que o evento textFieldShouldReturn seja delegado para esta classe
    // Necessario declarar UITextFieldDelegate
    // -------------------------------------------------------------------------------------------------
    UITextField.connectFieldbyReturnKey(fields: [txtNomeCompleto, txtEmail, txtSenha, txtConfirmaSenha], returnKeyType: .done)
    txtConfirmaSenha.delegate = self
    // -------------------------------------------------------------------------------------------------

    // Customiza o icone para mostrar/esconder o texto da senha
    let eyeIcon = UIImage(named:"eyes-icon")!
    txtSenha.showPasswordButtonWithImage(eyeIcon)
    txtConfirmaSenha.showPasswordButtonWithImage(eyeIcon)

    // Customiza o icone para apagar o texto de um TextFields
    let clearImage = UIImage(named: "imagem_clear")!
    txtEmail.clearButtonWithImage(clearImage)
    txtNomeCompleto.clearButtonWithImage(clearImage)

  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    // Torna a barra de navegação invisivel
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
    super.viewWillDisappear(animated)
    SVProgressHUD.dismiss()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // Evento que ocorre quando usuario iniciar o toque em qualquer ponto da tela que não seja um input
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    super.touchesBegan(touches, with: event)
    
    // Esconde o teclado
    view.endEditing(true)
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






/*
// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
  {
    [[NSNotificationCenter defaultCenter] addObserver:self
      selector:@selector(keyboardWasShown:)
      name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
      selector:@selector(keyboardWillBeHidden:)
      name:UIKeyboardWillHideNotification object:nil];
    
  }
  
  // Called when the UIKeyboardDidShowNotification is sent.
  - (void)keyboardWasShown:(NSNotification*)aNotification
{
  NSDictionary* info = [aNotification userInfo];
  CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
  
  UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
  scrollView.contentInset = contentInsets;
  scrollView.scrollIndicatorInsets = contentInsets;
  
  // If active text field is hidden by keyboard, scroll it so it's visible
  // Your app might not need or want this behavior.
  CGRect aRect = self.view.frame;
  aRect.size.height -= kbSize.height;
  if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
    [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
  }
  }
  
  // Called when the UIKeyboardWillHideNotification is sent
  - (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
  UIEdgeInsets contentInsets = UIEdgeInsetsZero;
  scrollView.contentInset = contentInsets;
  scrollView.scrollIndicatorInsets = contentInsets;
}
 */
