//
//  TableViewCell.swift
//  tabbarcustom
//
//  Created by 신지연 on 2024/01/28.
//

import UIKit

import SnapKit
import PicPick_Resource

class TableViewCell: UITableViewCell {
    
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .back01
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    
    private let albumTitleView: UILabel = {
        let titleView = UILabel()
        titleView.text = "제목입니다."
        titleView.font = PPFont.titleMedium700.font
        titleView.textColor = R.Color.systemWhite
        titleView.clipsToBounds = true
        return titleView
    }()
    
    private let friendInfoView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let friendTxtView: UILabel = {
        let titleView = UILabel()
        titleView.text = "홍길동"
        titleView.font = PPFont.captionLarge500.font
        titleView.textColor = R.Color.gray400
        titleView.clipsToBounds = true
        return titleView
    }()
    
    private let circleTxtView: UILabel = {
        let titleView = UILabel()
        titleView.text = "·"
        titleView.font = PPFont.captionLarge500.font
        titleView.textColor = R.Color.gray400
        titleView.clipsToBounds = true
        return titleView
    }()
    
    private let dividerView: UILabel = {
        let titleView = UILabel()
        titleView.text = "|"
        titleView.font = PPFont.captionLarge500.font
        titleView.textColor = R.Color.gray500
        titleView.clipsToBounds = true
        return titleView
    }()
    
    private let photoIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.Image.icoImg18.withRenderingMode(.alwaysTemplate)
        imageView.clipsToBounds = true
        imageView.tintColor = R.Color.gray400
        return imageView
    }()
    
    private let photoNum: UILabel = {
        let titleView = UILabel()
        titleView.text = "20"
        titleView.font = PPFont.captionLarge500.font
        titleView.textColor = R.Color.gray400
        titleView.clipsToBounds = true
        return titleView
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.Image.icoMenu18.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = R.Color.systemWhite
        return button
    }()
    
    private let titleInfoView: UIView = {
       let view = UIView()
        //view.backgroundColor = .yellow
        return view
    }()

    private func loadDataForNoSharedAlbum(){
        
        //let titleInfoView = UIView()
        
        contentView.addSubview(titleInfoView)
        titleInfoView.addSubview(albumTitleView)
        titleInfoView.addSubview(photoIconView)
        titleInfoView.addSubview(photoNum)
        
        titleInfoView.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(12)
            make.trailing.equalTo(moreButton.snp.leading).offset(-12)
            make.height.equalTo(44)
            make.centerY.equalTo(productImageView)
        }
        albumTitleView.snp.makeConstraints { make in
            make.leading.top.equalTo(titleInfoView)
            make.height.equalTo(20)
        }
        photoIconView.snp.makeConstraints { make in
            make.leading.bottom.equalTo(titleInfoView)
            make.height.width.equalTo(18)
        }
        photoNum.snp.makeConstraints { make in
            make.leading.equalTo(photoIconView.snp.trailing).offset(3)
            make.centerY.equalTo(photoIconView)
        }
    }
    
    
    private func loadDataForSharedAlbum(friendcount: Int) {
        
            // 공유 앨범이면
            
            contentView.addSubview(friendInfoView)
            friendInfoView.snp.makeConstraints { make in
                make.top.equalTo(albumTitleView.snp.bottom).offset(8)  //
                make.leading.equalTo(albumTitleView.snp.leading)  //
            }
            
            contentView.addSubview(friendTxtView)
            friendTxtView.snp.makeConstraints { make in
                make.centerX.equalTo(friendInfoView.snp.centerX)
                make.leading.equalTo(friendInfoView.snp.leading)
            }
            
            //친구 2명이상이면 circleTxtView와 친구 추가...
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // content view에 이미지 뷰 추가
        contentView.addSubview(productImageView)
        //contentView.addSubview(albumTitleView)
        contentView.addSubview(moreButton)
        //contentView.addSubview(photoIconView)
        //contentView.addSubview(photoNum)
        
        // SnapKit을 사용하여 제약 조건 설정
        productImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview() // 왼쪽에서 20px 떨어지게
            make.centerY.equalToSuperview()  // 세로 중앙 정렬
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(productImageView.snp.height)
        }
        /*
        albumTitleView.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(20)  // imageView로부터 오른쪽으로 10px 떨어져 있음
            make.top.equalToSuperview().offset(20)  // superview의 위쪽 가장자리보다 10px 아래로 떨어져 있음
            make.height.equalTo(20)
            make.trailing.equalTo(moreButton.snp.leading).offset(-12)  // 오른쪽 가장자리는 moreButton의 왼쪽 가장자리보다 12px 왼쪽에 위치함
        }
        
        
        photoIconView.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(20)
            make.top.equalTo(albumTitleView.snp.bottom).offset(5)
            make.height.equalTo(18)
            make.width.equalTo(photoIconView.snp.height)  // 오른쪽 가장자리는 moreButton의 왼쪽 가장자리보다 12px 왼쪽에 위치함
        }
        
        photoNum.snp.makeConstraints { make in
            make.centerY.equalTo(photoIconView.snp.centerY)
            make.height.equalTo(18)
            make.leading.equalTo(photoIconView.snp.trailing).offset(5)
        }
        */
        moreButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(18)
            make.width.equalTo(moreButton.snp.height)
        }
        
        // 셀의 배경색을 투명하게 설정
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        loadDataForNoSharedAlbum()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // content view의 크기를 조정하여 이미지 뷰의 위치와 크기를 조절
        //contentView.frame = bounds
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 20, bottom: 6, right: 20))
    }

}
