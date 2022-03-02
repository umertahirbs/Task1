//
//  RegisterVc.swift
//  Task1
//
//  Created by Umer Tahir on 02/03/2022.
//

import UIKit

class RegisterVc: BaseVC {

    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var firstNameTextfield: UITextField!
    
    var viewModel : AuthVM!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViewModel()
    }
    

    @IBAction func registerBtnTapped(_ sender: UIButton) {
        
        if viewModel.isValid {
            viewModel.register()
        }else{
            getErrors()
        }
    }
    

    private func initViewModel() {
        viewModel = AuthVM(type: .signUp)
        setViewModelObserver(model: viewModel)
        setTFDelegates()
        successResponse()
        
    }
  
}
extension RegisterVc {
    
    func successResponse() {
        viewModel.didFinishFetch = {
            DispatchQueue.main.async {
              
                self.goToDashboard()

            }
            
        }
    }
    
    
}

