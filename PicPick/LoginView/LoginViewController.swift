//
//  LoginViewController.swift
//  PicPick
//
//  Created by Jaeuk on 1/27/24.
//

import UIKit

import SnapKit
import PicPick_Resource
import PicPick_Util

class LoginViewController: UIViewController {
    
    var id = String()
    var password = String()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = PPFont.titleLarge700.font
        label.textColor = R.Color.gray900
        label.text = NSLocalizedString("Login ID Label", comment: "Login page ID Lable")
        return label
    } ()
    
    lazy var idTextField: PPTextField = {
        let textField = PPTextField(placeholder: NSLocalizedString("Login ID Placeholder", comment: "Login page ID textfield placeholder"))
        textField.becomeFirstResponder()
        textField.textContentType = .username
        textField.keyboardType = .asciiCapable
        textField.clearButtonMode = .always
        textField.addTarget(self, action: #selector(idTextFieldEditingChange(_:)), for: .editingChanged)
        return textField
    } ()
    
    lazy var pwLabel: UILabel = {
        let label = UILabel()
        label.font = PPFont.titleLarge700.font
        label.textColor = R.Color.gray900
        label.text = NSLocalizedString("Login Password Label", comment: "Login page Password Lable")
        return label
    } ()
    
    lazy var pwTextField: PPTextField = {
        let textField = PPTextField(placeholder: NSLocalizedString("Login Password Placeholder", comment: "Login page Password textfield placeholder"))
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        textField.addTarget(self, action: #selector(pwTextFieldEditingChange(_:)), for: .editingChanged)
        textField.enablePasswordToggle()
        return textField
    } ()
    
    lazy var loginBtn: PPButton = {
        let button = PPBlackButton(buttonStyle: .bottom)
        button.setTitle(NSLocalizedString("Login Button", comment: "Login Button String"), for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginBtnDidTap(_:)), for: .touchUpInside)
        return button
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = NSLocalizedString("Login Title", comment: "Login page navigationvar title")
        removeBackBtnTitle()
        
        view.backgroundColor = .white
        
        view.addSubview(idLabel)
        view.addSubview(idTextField)
        view.addSubview(pwLabel)
        view.addSubview(pwTextField)
        
        view.addSubview(loginBtn)
        
        idLabel.snp.makeConstraints {
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
        }
        
        idTextField.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.top.equalTo(idLabel.snp.bottom).offset(10)
        }
        
        pwLabel.snp.makeConstraints {
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.top.equalTo(idTextField.snp.bottom).offset(58)
        }
        
        pwTextField.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.top.equalTo(pwLabel.snp.bottom).offset(10)
        }
        
        loginBtn.snp.makeConstraints {
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
    }
    
    @objc
    func idTextFieldEditingChange(_ sender: UITextField) {
        let text = sender.text ?? ""
        loginBtn.isEnabled = (password.count > 2 && text.count > 2)
        id = text
    }
    
    @objc
    func pwTextFieldEditingChange(_ sender: UITextField) {
        let text = sender.text ?? ""
        loginBtn.isEnabled = (text.count > 2 && id.count > 2)
        password = text
    }
    
    @objc
    func loginBtnDidTap(_ sender: UIButton) {
        let mainVC = PPNavigationController(rootViewController: HomeViewController())
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true)
    }
    
}
