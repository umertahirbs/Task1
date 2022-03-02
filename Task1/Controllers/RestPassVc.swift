//
//  RestPassVc.swift
//  Task1
//
//  Created by Umer Tahir on 02/03/2022.
//

import UIKit

class RestPassVc: BaseVC {

    @IBOutlet weak var confirmPassTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    var viewModel : AuthVM!

    override func viewDidLoad() {
        super.viewDidLoad()

        initViewModel()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func resetBtnTapped(_ sender: UIButton) {
        if viewModel.isValid {
            viewModel.resetPassword()
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
extension RestPassVc {
    
    func successResponse() {
        viewModel.didFinishFetch = {
            DispatchQueue.main.async {
              
                self.goToDashboard()
            }
            
        }
    }
    
    func setTFDelegates(){

        passwordTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        confirmPassTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.password.value = passwordTextfield.text ?? ""
        viewModel.confirmPasword.value = confirmPassTextfield.text ?? ""
    }
    
   
    
    func getErrors() {
        for rule in viewModel.brokenRules{
                self.showAlert(titleStr: "Alert", messageStr: rule.message, okButtonTitle: "OK", cancelButtonTitle: nil, response: nil)
                return
        }
    }
   
}
