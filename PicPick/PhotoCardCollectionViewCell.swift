//
//  PhotoCardCollectionViewCell.swift
//  tabbarcustom
//
//  Created by 신지연 on 2024/02/04.
//

import UIKit

import PicPick_Resource

class PhotoCardCollectionViewCell: UICollectionViewCell {
    
    private let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .back01
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목제목제목ㅈㅁㅈㅁㅈㅁㅈㅁㅈㅈㅁ"
        label.font = UIFont(name: "Pretendard", size: 14)
        label.textColor = R.Color.gray700
        label.numberOfLines = 2
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 22
        
        return label
    }()
    
    private let heartBtn: UIButton = {
        let button = UIButton()
        button.setImage(R.Image.icoHeart24, for: .normal)
        
        return button
    }()
    
    let keywordView: UIView = {
       let label = UILabel()
        label.backgroundColor = R.Color.pointLight
        label.textColor = R.Color.pointNormal
        label.text = "3D인물"
        label.font = UIFont(name: "Pretendard", size: 12)
        label.layer.cornerRadius = 13
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        // 이미지뷰를 셀에 추가하고 제약 조건 설정
        addSubview(photoImage)
        photoImage.snp.makeConstraints { make in
            make.width.height.equalTo(166)
            make.top.leading.trailing.equalToSuperview()
            
        }
        
        addSubview(heartBtn)
        heartBtn.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.top.equalTo(photoImage.snp.top).offset(12)
            make.trailing.equalTo(photoImage.snp.trailing).offset(-12)
        }

        // 제목 라벨을 셀에 추가하고 제약 조건 설정
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.top.equalTo(photoImage.snp.bottom).offset(8)
            make.width.equalTo(158)
            make.height.equalTo(44)
        }
        
        addSubview(keywordView)
        keywordView.snp.makeConstraints { make in
            make.height.equalTo(26)
            make.width.equalTo(56)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(6)
            
        }
        
        
        layer.masksToBounds = true
    }
    
    
}
