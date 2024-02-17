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
    
    // MARK: - Parameters
    var id = String()
    var password = String()
    
    // MARK: - UIs
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = PPFont.titleLarge700.font
        label.textColor = R.Color.gray900
        label.text = NSLocalizedString("Login Email Label", comment: "Login page Email Lable")
        return label
    } ()
    
    lazy var idTextField: PPTextField = {
        let textField = PPTextField(placeholder: NSLocalizedString("Login Email Placeholder", comment: "Login page Email textfield placeholder"))
        textField.becomeFirstResponder()
        textField.textContentType = .username
        textField.keyboardType = .asciiCapable
        textField.clearButtonMode = .always
        textField.addTarget(self, action: #selector(idTextFieldEditingChange(_:)), for: .editingChanged)
        textField.returnKeyType = .next
        textField.delegate = self
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
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    } ()
    
    lazy var loginBtn: PPButton = {
        let button = PPBlackButton(buttonStyle: .bottom)
        button.setTitle(NSLocalizedString("Login Button", comment: "Login Button String"), for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginBtnDidTap(_:)), for: .touchUpInside)
        return button
    } ()

    // MARK: - LifeCycles
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
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-10)
        }
    }
    
    // MARK: - Functions
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
        login()
//        let mainVC = PPNavigationController(rootViewController: HomeViewController())
//        mainVC.modalPresentationStyle = .fullScreen
//        present(mainVC, animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case idTextField:
            pwTextField.becomeFirstResponder()
        case pwTextField:
            if loginBtn.isEnabled {
                loginBtnDidTap(loginBtn)
            }
        default:
            break
        }
        return true
    }
}

extension LoginViewController {
    func login() {
        UserService.shared.login(email: id, password: password) { response in
            switch response {
            case .success(let data):
                if let userData = data as? LoginResponse {
                    KeyChain.create(key: R.String.KeyChainKey.accessToken, token: userData.result!.accessToken)
                    KeyChain.create(key: R.String.KeyChainKey.refreshToken, token: userData.result!.refreshToken)
                    UserDefaults.standard.set(true, forKey: R.String.UserDefaultKey.isLoggedIn)
                    
                    let navigationViewController = PPNavigationController(rootViewController: HomeViewController())
                    navigationViewController.modalPresentationStyle = .fullScreen
                    self.present(navigationViewController, animated: true)
                }
            case .requestErr(let err):
                print(err)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}
