//
//  ViewController.swift
//  PicPick
//
//  Created by Jaeuk on 1/20/24.
//

import UIKit

class ViewController: UIViewController {

    lazy var offWhite: PPButton = {
        let button = PPButton(color: .white, disable: true)
        
        button.text = NSLocalizedString("Edit Album", comment: "Edit album button string")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()

    lazy var onWhite: PPButton = {
        let button = PPButton(color: .white)
        
        button.text = NSLocalizedString("Edit Album", comment: "Edit album button string")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()

    lazy var offBlack: PPButton = {
        let button = PPButton(color: .black, disable: true)
        
        button.text = NSLocalizedString("Edit Album", comment: "Edit album button string")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()

    lazy var onBlack: PPButton = {
        let button = PPButton(color: .black)
        
        button.text = NSLocalizedString("Edit Album", comment: "Edit album button string")
        
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
        
        view.addSubview(offWhite)
        view.addSubview(onWhite)
        view.addSubview(offBlack)
        view.addSubview(onBlack)
        view.addSubview(label)
        
        onBlack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        offBlack.topAnchor.constraint(equalTo: onBlack.bottomAnchor, constant: 10).isActive = true
        onWhite.topAnchor.constraint(equalTo: offBlack.bottomAnchor, constant: 10).isActive = true
        offWhite.topAnchor.constraint(equalTo: onWhite.bottomAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: offWhite.bottomAnchor, constant: 10).isActive = true
        
        offWhite.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        onWhite.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        offBlack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        onBlack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }


}

