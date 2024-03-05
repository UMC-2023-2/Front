//
//  NewProfileViewController.swift
//  PicPick
//
//  Created by Jaeuk on 2/7/24.
//

import UIKit
import PhotosUI

import SnapKit
import PicPick_Resource
import PicPick_Util

class NewProfileViewController: UIViewController {
    
    lazy var profileImageView = {
        let imageView = PPEditProfileImageView()
        return imageView
    } ()

    lazy var profileLabel = {
        let label = UILabel()
        label.text = NSLocalizedString("New Profile Nickname", comment: "Nickname Label Text")
        label.font = PPFont.titleLarge700.font
        label.textColor = R.Color.gray900
        return label
    } ()
    
    lazy var profileTextField = {
        let textField = PPTextField(placeholder: NSLocalizedString("New Profile Nickname Placeholder", comment: "New Profile Nickname Placeholder Text"))
        textField.becomeFirstResponder()
        textField.textContentType = .username
        textField.keyboardType = .asciiCapable
        return textField
    } ()
    
    lazy var checkButton = {
        let button = PPBlackButton(buttonStyle: .textfield)
        button.setTitle(NSLocalizedString("New Profile Nickname Check Button", comment: "New Profile Nickname Check Button String"), for: .normal)
        return button
    } ()
    
    lazy var nextButton = {
        let button = PPBlackButton(buttonStyle: .bottom)
        button.setTitle(NSLocalizedString("New Profile Next Button", comment: "New Profile Next Button Text"), for: .normal)
        
        return button
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("New Profile Title", comment: "New Profle Page Title")
        removeBackBtnTitle()
        
        view.backgroundColor = .white
        
        view.addSubview(profileImageView)
        view.addSubview(profileLabel)
        view.addSubview(profileTextField)
        view.addSubview(checkButton)
        view.addSubview(nextButton)
        
        profileImageView.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(36)
        }
        
        profileLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(40)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        profileTextField.snp.makeConstraints {
            $0.top.equalTo(profileLabel.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(checkButton.snp.leading).offset(-8)
        }
        
        checkButton.snp.makeConstraints {
            $0.width.equalTo(87)
            $0.height.equalTo(48)
            $0.top.equalTo(profileTextField)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-10)
        }
        
        profileImageView.addTarget(self, action: #selector(editProfileImageDidTapped(_:)), for: .touchUpInside)
        
    }
    
    @objc
    func editProfileImageDidTapped(_ sender: PPEditProfileImageView) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = PHPickerFilter.images
        
        let pickerViewController = PHPickerViewController(configuration: config)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
    }
    
}

extension NewProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self.profileImageView.profileImage.image = image
                    }
                }
            })
        }
    }
}
