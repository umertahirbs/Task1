//


import Foundation
import UIKit

class AuthVM :NSObject, ViewModel {
    
    enum ModelType {
        case login
        case signUp
        case forgetPassword
        case resetPassword
        
    }
    
    var modelType      : ModelType
    var email          : Dynamic<String> = Dynamic("")
    var password       : Dynamic<String> = Dynamic("")
    
    var firstName       : Dynamic<String> = Dynamic("")
    var lastName        : Dynamic<String> = Dynamic("")
    
    var confirmPasword       : Dynamic<String> = Dynamic("")

    
    //MARK: Closures
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    var faceidResBlock: ((Bool, String?) -> ())?

    var brokenRules: [BrokenRule] = []
    var successMessage = ""
    
    init(type:ModelType) {
        modelType = type
    }
    
    var isValid: Bool{
        get {
            self.brokenRules = [BrokenRule]()
            self.Validate()
            return self.brokenRules.count == 0
        }
    }

    var error: String?{
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var isLoading: Bool = false{
        didSet{
            self.updateLoadingStatus?()
        }
    }
    
    private var service    = AuthService(NetworkHandler())
    var user : User?
    
    var message : String?
    
    func login() {
        self.isLoading = true
        
        let param = ["email":email.value,"password":password.value]
        service.loginResult(params: param) {  [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result{
            case .success(let response):
                
                if response.success ?? false {
                    guard response.data != nil else {
                        return
                    }
                    self.user = response.data
                    AppSettings.email = self.email.value
                    AppSettings.pasword = self.password.value
                    AppSettings.hasLogIn = true
                    AppSettings.token = response.data?.accessToken ?? ""
                    AppSettings.name = response.data?.firstName ?? ""
                    AppSettings.lastName = response.data?.lastName ?? ""

                    self.didFinishFetch?()
                }
                else{
                   // self.error = response.message
                }
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func register() {
        self.isLoading = true
        
        let param = ["email":email.value,"password":password.value,"first_name": "","last_name":"","code":"u2cXXDKF"]
        service.register(params: param) {  [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result{
            case .success(let response):
        
                if response.success ?? false {
                    guard response.data != nil else {
                        return
                    }
                    self.user = response.data
                    AppSettings.email = self.email.value
                    AppSettings.pasword = self.password.value
                    AppSettings.hasLogIn = true
                    AppSettings.token = response.data?.accessToken ?? ""
                    AppSettings.name = response.data?.firstName ?? ""
                    AppSettings.lastName = response.data?.lastName ?? ""

                    self.didFinishFetch?()
                }
                else{
                   // self.error = response.message
                }
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    
    func verifyAccout() {
        self.isLoading = true
        
        let param = ["email":email.value]
        service.verifyAccout(params: param) {  [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result{
            case .success(let response):
        
                if response.success ?? false {
                  
                    self.message = response.message
                    self.didFinishFetch?()
                }
                else{
                   // self.error = response.message
                }
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    
    func resetPassword() {
        self.isLoading = true
        
        let param = ["email":email.value]
        service.resetPaswd(params: param) {  [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result{
            case .success(let response):
        
                if response.success ?? false {
                  
                    self.message = response.message
                    self.didFinishFetch?()
                }
                else{
                   // self.error = response.message
                }
            case .failure(let error):
                self.error = error
            }
        }
    }
    
}


extension AuthVM {
    private func Validate() {
        switch modelType {
        case .login:
            if email.value == "" || email.value == " "{
                self.brokenRules.append(BrokenRule(propertyName: "NoEmail", message: EMAIL_EMPTY))
            }
            if email.value != "" && !email.value.isValidEmail(){
                self.brokenRules.append(BrokenRule(propertyName: "InvalidEmail", message: EMAIL_VALID))
            }
            if password.value == "" || password.value == " "  {
                self.brokenRules.append(BrokenRule(propertyName: "NoPassword", message: PASSWORD_EMPTY))
            }
            if  password.value == "" {
                self.brokenRules.append(BrokenRule(propertyName: "NoPassword", message: PASSWORD_LENGTH))
            }
        case .signUp:
            
            if email.value == "" || email.value == " "{
                self.brokenRules.append(BrokenRule(propertyName: "NoEmail", message: EMAIL_EMPTY))
            }
            if email.value != "" && !email.value.isValidEmail(){
                self.brokenRules.append(BrokenRule(propertyName: "InvalidEmail", message: EMAIL_VALID))
            }
            if firstName.value == "" || firstName.value == " "{
                self.brokenRules.append(BrokenRule(propertyName: "NoEmail", message: FIRST_NAME_EMPTY))
            }
            if lastName.value == "" || lastName.value == " " {
                self.brokenRules.append(BrokenRule(propertyName: "NoEmail", message: LAST_NAME_EMPTY))
            }
            if password.value == "" || password.value == " "  {
                self.brokenRules.append(BrokenRule(propertyName: "NoPassword", message: PASSWORD_EMPTY))
            }
            if  password.value.count < 6 {
                self.brokenRules.append(BrokenRule(propertyName: "NoPassword", message: PASSWORD_LENGTH))
            }
        case .forgetPassword :
            if email.value == "" || email.value == " "{
                self.brokenRules.append(BrokenRule(propertyName: "NoEmail", message: EMAIL_EMPTY))
            }
            if email.value != "" && !email.value.isValidEmail(){
                self.brokenRules.append(BrokenRule(propertyName: "InvalidEmail", message: EMAIL_VALID))
            }
        case .resetPassword:
            if password.value == "" || password.value == " "{
                self.brokenRules.append(BrokenRule(propertyName: "NoEmail", message: EMAIL_EMPTY))
            }
            if  password.value.count < 6 {
                self.brokenRules.append(BrokenRule(propertyName: "NoPassword", message: PASSWORD_LENGTH))
            }
            if confirmPasword.value == "" || confirmPasword.value == " "{
                self.brokenRules.append(BrokenRule(propertyName: "NoEmail", message: EMAIL_EMPTY))
            }
            
            if  password.value != confirmPasword.value {
                self.brokenRules.append(BrokenRule(propertyName: "Match", message: PASSWORD_MATCH))
            }
        }
    }
    
}
