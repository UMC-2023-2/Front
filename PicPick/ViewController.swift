//
//  ViewController.swift
//  PicPick
//
//  Created by Jaeuk on 1/20/24.
//

import UIKit

import PicPick_Resource

class ViewController: UIViewController {

    lazy var offWhite: PPButton = {
        let button = PPBlackButton(configuration: .bottom())
        
        button.setTitle(NSLocalizedString("Edit Album", comment: "Edit album button string"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()

    lazy var onWhite: PPButton = {
        let button = PPButton(configuration: .bottom())
        
        button.setTitle(NSLocalizedString("Edit Album", comment: "Edit album button string"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()

    lazy var offBlack: PPButton = {
        let button = PPButton(configuration: .bottom())
        
        button.setTitle(NSLocalizedString("Edit Album", comment: "Edit album button string"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()

    lazy var onBlack: PPButton = {
        let button = PPButton(configuration: .bottom())
        
        button.setTitle(NSLocalizedString("Edit Album", comment: "Edit album button string"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    lazy var label: UILabel = {
        let label = UILabel()
        
        label.font = PicPickFont.titleMedium700.font
        label.text = "medium700"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .orange
        
        navigationController?.navigationBar.backIndicatorImage = R.Image.icoNavLineArrowLeft
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = R.Image.icoNavLineArrowLeft
        navigationController?.navigationBar.tintColor = R.Color.gray900
        navigationItem.backButtonTitle = ""
        
        view.addSubview(offWhite)
        view.addSubview(onWhite)
        view.addSubview(offBlack)
        view.addSubview(onBlack)
        view.addSubview(label)
        
        offBlack.isEnabled = false
        
        onBlack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        offBlack.topAnchor.constraint(equalTo: onBlack.bottomAnchor, constant: 10).isActive = true
        onWhite.topAnchor.constraint(equalTo: offBlack.bottomAnchor, constant: 10).isActive = true
        offWhite.topAnchor.constraint(equalTo: onWhite.bottomAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: offWhite.bottomAnchor, constant: 10).isActive = true
        
        offWhite.addTarget(self, action: #selector(offWhiteDidTap(_:)), for: .touchUpInside)
        
        offWhite.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        onWhite.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        offBlack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        onBlack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }

    @objc
    func offWhiteDidTap(_ sender: PPBlackButton) {
        self.navigationController?.pushViewController(QRViewController(), animated: true)
    }

}

