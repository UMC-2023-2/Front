//
//  PPEditProfileImageView.swift
//  PicPick
//
//  Created by Jaeuk on 2/10/24.
//

import UIKit

import SnapKit
import PicPick_Util
import PicPick_Resource

class PPEditProfileImageView: UIButton {
    lazy var profileImage = {
        let image = UIImageView()
        image.makeRound(radius: 56)
        image.clipsToBounds = true
        image.snp.makeConstraints {
            $0.width.height.equalTo(112)
        }
        image.backgroundColor = R.Color.gray300
        image.image = R.Image.profileInfoContent
        image.isUserInteractionEnabled = false
        image.contentMode = .scaleAspectFill
        return image
    } ()
    
    lazy var editButton = {
        let button = UIButton()
        button.setImage(R.Image.icoEdit22.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = R.Color.gray300
        button.backgroundColor = R.Color.pointNormal
        button.makeRound(radius: 6)
        button.clipsToBounds = true
        button.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        button.isUserInteractionEnabled = false
        return button
    } ()
    
    func setImage(image: UIImage) {
        profileImage.image = image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImage)
        addSubview(editButton)
        
        profileImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        editButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-4)
        }
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
