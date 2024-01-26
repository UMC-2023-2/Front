//
//  WelcomeViewController.swift
//  PicPick
//
//  Created by Jaeuk on 1/26/24.
//

import UIKit

import SnapKit
import PicPick_Util
import PicPick_Resource

class WelcomeViewController: UIViewController {
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        
        image.image = R.Image.imgWelcomeBackground
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    } ()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.setTextWithLineHeight(text: NSLocalizedString("Welcome Title", comment: "Welcome Title Label Text"), lineHeight: PicPickFont.headlineLarge700.lineHeight)
        label.numberOfLines = 0
        label.font = PicPickFont.headlineLarge700.font
        label.textColor = R.Color.systemWhite
        
        return label
    } ()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.setTextWithLineHeight(text: NSLocalizedString("Welcome Subtitle", comment: "Welcome Subtltie Label Text"), lineHeight: PicPickFont.bodyLarge500.lineHeight)
        label.numberOfLines = 0
        label.font = PicPickFont.bodyLarge500.font
        label.textColor = R.Color.gray400
        
        return label
    } ()
    
    lazy var loginButton: PPButton = {
        let button = PPButton(configuration: .white())
        
        button.setTitle(NSLocalizedString("Welcome Login", comment: "Login Button Text"), for: .normal)
        
        return button
    } ()
    
    
    lazy var signupButton: PPButton = {
        let button = PPButton(configuration: .line())
        
        button.setTitle(NSLocalizedString("Welcome Sign up", comment: "Sign up Button Text"), for: .normal)
        
        return button
    } ()
    
    lazy var contentsView: UIView = {
        let view = UIView()
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        return view
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        // Do any additional setup after loading the view.
        view.insertSubview(backgroundImage, at: 0)
        view.addSubview(visualEffectView)
        view.addSubview(contentsView)
        backgroundImage.snp.makeConstraints{
            $0.edges.equalTo(view)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(56)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        signupButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-4)
        }
        contentsView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        visualEffectView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(view)
            $0.top.equalTo(contentsView.snp.top).offset(-32)
        }
    }

}