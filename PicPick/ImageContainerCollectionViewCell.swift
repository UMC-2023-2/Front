//
//  ImageContainerCollectionViewCell.swift
//  tabbarcustom
//
//  Created by 신지연 on 2024/02/07.
//

import UIKit

class ImageContainerCollectionViewCell: UICollectionViewCell {
    private let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .back01
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
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
        
        layer.masksToBounds = true
    }
}
