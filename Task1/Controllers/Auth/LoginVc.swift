//
//  LoginVc.swift
//  Task1
//
//  Created by Umer Tahir on 02/03/2022.
//

import UIKit

class LoginVc: BaseVC {

    @IBOutlet weak var passwordTextfied: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    
    var viewModel : AuthVM!

    override func viewDidLoad() {
        super.viewDidLoad()


        initViewModel()
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        
        if viewModel.isValid {
            viewModel.login()
        }else{
            getErrors()
        }
    }
    
    
    private func initViewModel() {
        viewModel = AuthVM(type: .login)
        setViewModelObserver(model: viewModel)
        setTFDelegates()
        successResponse()
        
    }
  
}
extension LoginVc {
    
    func successResponse() {
        viewModel.didFinishFetch = {
            DispatchQueue.main.async {
              
              /// home
                print("home")
            
                self.goToDashboard()
            }
            
        }
    }
    
   
}
