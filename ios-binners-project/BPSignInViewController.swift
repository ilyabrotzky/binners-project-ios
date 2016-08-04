//
//  BPSignInViewController.swift
//  ios-binners-project
//
//  Created by Matheus Ruschel on 7/14/16.
//  Copyright © 2016 Rodrigo de Souza Reis. All rights reserved.
//

import UIKit

protocol SignInDismissDelegate {
    
    func didDismissView()
}

let signInButtonTag = 1

class BPSignInViewController: UIViewController {
    
    var textFieldEmail: UITextField?
    var textFieldPassword: UITextField?
    var textFieldConfirmPassword: UITextField?
    var activityIndicator:UIActivityIndicatorView!
    var dismissDelegate: SignInDismissDelegate?
    let signInViewModel = BPSignInViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.signInViewModel.signInDelegate = self
        self.view.addSubview(createForm())
    }
    
    func createForm() -> UIView {
        
        let formView = UIView(frame: CGRect(
            x: (self.view.frame.width - (self.view.frame.width * 0.9))/2,
            y: (self.view.frame.height * 0.4),
            width: self.view.frame.width * 0.9,
            height: (self.view.frame.height * 0.6)))
        
        formView.addSubview(createInputText(formView))
        let passwordTextField = createInputPassword("Password",form: formView, belowView: nil)
        formView.addSubview(passwordTextField)
        formView.addSubview(createInputPassword("Confirm Password",
            form: formView,
            belowView: passwordTextField))
        
        formView.addSubview(createButton(formView))
        
        return formView
    }
    
    func createInputText(form: UIView) -> UIView {
        
        let yPosButton = form.frame.height * 0.1
        
        let formView = UITextField(frame: CGRect(x: 0,
            y: yPosButton,
            width: form.frame.width,
            height: 20))
        formView.tag = 123
        formView.autocapitalizationType = .None
        formView.background = UIImage(named: "login-email-input-field.png")
        formView.textColor = UIColor.whiteColor()
        formView.attributedPlaceholder =
            NSAttributedString(string: "Email",
                               attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        formView.textAlignment = .Center
        formView.tag = 123
        textFieldEmail = formView
        return formView
    }
    
    func createInputPassword(text: String, form: UIView,belowView: UIView?) -> UIView {
        
        let viewEmail = form.viewWithTag(123)
    
        var initialPos:CGFloat = 0.0
        if let view = belowView {
            initialPos = view.frame.origin.y +
                view.frame.height +
                view.frame.height * 0.9
        } else {
            initialPos = viewEmail!.frame.origin.y +
                viewEmail!.frame.height +
                viewEmail!.frame.height * 0.9
        }
        
        let formView = UITextField(frame: CGRect(
            x: 0,
            y: initialPos,
            width: form.frame.width,
            height: 20))
        formView.autocapitalizationType = .None
        formView.background = UIImage(named: "login-password-input-field.png")
        formView.secureTextEntry = true
        formView.textColor = UIColor.whiteColor()
        formView.attributedPlaceholder =
            NSAttributedString(string: text,
                               attributes:
                [NSForegroundColorAttributeName : UIColor.whiteColor()])
        formView.textAlignment = .Center
        
        if belowView != nil {
            textFieldPassword = formView
        } else {
            textFieldConfirmPassword = formView
        }
        return formView
    }

    
    func createButton(form: UIView) -> UIView {
        
        let yPos = form.frame.size.height * 0.4
        
        let formView = UIButton(frame: CGRect(x: 0,
            y: yPos,
            width: form.frame.width,
            height: form.frame.height * 0.15))
        
        activityIndicator = UIActivityIndicatorView(
            frame: CGRect(x: 0,y: 0,width: 50,height: formView.frame.height))
        
        formView.backgroundColor = UIColor(netHex: 0x008DF0)
        formView.layer.cornerRadius = 4.0
        formView.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        formView.titleLabel?.font = UIFont.binnersFontWithSize(16)
        formView.setTitle("Sign Up", forState: UIControlState.Normal)
        formView.tag = signInButtonTag
        formView.addTarget(self, action: #selector(signInUser), forControlEvents: .TouchUpInside)
        return formView
    }
    
    func signInUser(sender: UIButton) {
        
        let email = textFieldEmail?.text
        let password = textFieldPassword?.text
        let confirmPassword = textFieldConfirmPassword?.text
        
        switch signInViewModel.validateEmail(email) {
        case .Failed(let msg):
            BPMessageFactory.makeMessage(.ALERT, message: msg).show()
        case .Passed: break
        }
        
        switch signInViewModel.validatePasswords(password, confirmPassword: confirmPassword) {
        case .Failed(let msg):
            BPMessageFactory.makeMessage(.ALERT, message: msg).show()
        case .Passed:
            do {
                try self.signInViewModel.signInUser(email!, password: password!)
                sender.addSubview(self.activityIndicator)
                self.activityIndicator.startAnimating()
                sender.enabled = false
            } catch let error as NSError {
                BPMessageFactory.makeMessage(.ALERT, message: error.localizedDescription).show()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension BPSignInViewController : SignInDelegate {
    
    func didSignIn(success: Bool, errorMsg: String?) {
        
        if let button = self.view.viewWithTag(signInButtonTag) as? UIButton {
            button.enabled = true
            self.activityIndicator.removeFromSuperview()
        }

        
        if success {
            
            self.dismissViewControllerAnimated(true, completion: {
                self.dismissDelegate?.didDismissView()
            })
            
        } else {
            BPMessageFactory.makeMessage(
                .ALERT,
                message: errorMsg!).show()
        }
        
    }
    
}
 