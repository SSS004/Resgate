//
//  FirebaseCustomizado.swift
//  Resgate
//
//  Created by Silvio Shindi Shimizu on 01/12/2017.
//  Copyright © 2017 Cinco Mais Tecnologia em Saúde. All rights reserved.
//

import UIKit
import FirebaseAuth

public func getFirebaseErrorMessage(errorCode errCode: AuthErrorCode) -> String {
  
  switch errCode {
    
  case .invalidEmail:
    return "E-mail inválido"

  case .emailAlreadyInUse:
    return "E-mail já está sendo utilizado por um usuário"
    
  case .operationNotAllowed:
    return "Contas de autenticação por usuario/email precisam ser ativadas no consoles"
  
  case .weakPassword:
    return "Senha fraca, favor escolher uma senha fortes"
  
  case .networkError:     // Indica que ocorreu um erro na rede durante a operação.
    return "Não foi possivel acessar o servidor, verifique sua conexão e tente novamente mais tarde."
  
  case .userNotFound:     // Indica que a conta de usuário não foi encontrada. Pode ocorrer se a conta de usuário foi excluída.
    return "Usuário desconhecido"
  
  case .userTokenExpired: // Indica que o token atual do usuário expirou porque, por exemplo, ele alterou a senha da conta em outro dispositivo. Solicite novo login neste dispositivo.
    return "Sessão expirada, tente se logar novamente"
  
  case .tooManyRequests:  // Indica que a solicitação foi bloqueada após o dispositivo chamador fazer um número anormal de solicitações aos servidores do Firebase Authentication. Tente novamente mais tarde.
    return "Muitas requisições ao servidor, tente mais tarde"
  
  case .invalidAPIKey:    // Indica que o app foi configurado com uma chave de API inválida.
    return "Chave API inválida"
  
  case .appNotAuthorized: // Indica que o app não tem autorização para usar o Firebase Authentication com a chave de API fornecida. Acesse o Console de APIs do Google e, na guia de credenciais, verifique se o código do pacote do seu app está na lista de permissões da chave de API que você está usando.
    return "Aplicativo nao autorizado para autenticação"
  
  case .wrongPassword:    // Indica que o usuário tentou fazer login com uma senha incorreta.
    return "Senha inválida"

  case .invalidCredential: // Indica que a credencial informada é inválida. Isso pode acontecer se a credencial estiver expirada ou incorreta.
    return "Credenticial de acesso inválido ou expirado, tente logar novamente"

  case .userDisabled:      // Indica que a conta do usuário está desativada.
    return "Conta de usuário está desativadas"

  case .requiresRecentLogin:  // Indicates the user has attemped to change email or password more than 5 minutes after signing in.
    return "Sua sessão tem mais de 5 minutos, será necessario se logar novamente para utilizar esta funcionalidade"

  case .invalidUserToken:   // Indicates user's saved auth credential is invalid, the user needs to sign in again.
    return "Credencial não está mais válida, sera necessário se logar novamente"

  case .missingPhoneNumber:  // Indicates that a phone number was not provided in a call to @c verifyPhoneNumber:completion:.
    return "Telefone necessário para utilizar esta funcionalidade"

  case .invalidPhoneNumber:  // Indicates that an invalid phone number was provided in a call to @c verifyPhoneNumber:completion:.
    return "Telefone fornecido é inválido"
  
  case .sessionExpired:   // Indicates that the SMS code has expired.
    return "Código de SMS expirado"

/*
  case .invalidCustomToken:
    <#code#>
  case .customTokenMismatch:
    <#code#>
  case .accountExistsWithDifferentCredential:
    <#code#>
  case .providerAlreadyLinked:
    <#code#>
  case .noSuchProvider:
    <#code#>
  case .userMismatch:
    <#code#>
  case .credentialAlreadyInUse:
    <#code#>
  case .expiredActionCode:
    <#code#>
  case .invalidActionCode:
    <#code#>
  case .invalidMessagePayload:
    <#code#>
  case .invalidSender:
    <#code#>
  case .invalidRecipientEmail:
    <#code#>
  case .missingEmail:
    <#code#>
  case .missingIosBundleID:
    <#code#>
  case .missingAndroidPackageName:
    <#code#>
  case .unauthorizedDomain:
    <#code#>
  case .invalidContinueURI:
    <#code#>
  case .missingContinueURI:
    <#code#>
  case .missingVerificationCode:
    <#code#>
  case .invalidVerificationCode:
    <#code#>
  case .missingVerificationID:
    <#code#>
  case .invalidVerificationID:
    <#code#>
  case .missingAppCredential:
    <#code#>
  case .invalidAppCredential:
    <#code#>
  case .quotaExceeded:
    <#code#>
  case .missingAppToken:
    <#code#>
  case .notificationNotForwarded:
    <#code#>
  case .appNotVerified:
    <#code#>
  case .captchaCheckFailed:
    <#code#>
  case .webContextAlreadyPresented:
    <#code#>
  case .webContextCancelled:
    <#code#>
  case .appVerificationUserInteractionFailure:
    <#code#>
  case .invalidClientID:
    <#code#>
  case .webNetworkRequestFailed:
    <#code#>
  case .webInternalError:
    <#code#>
  case .keychainError:
    <#code#>
  case .internalError:
    <#code#>
*/
  default:
    return ""
  }


}


