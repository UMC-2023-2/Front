//
//  SearchViewController.swift
//  tabbarcustom
//
//  Created by 신지연 on 2024/01/31.
//

import UIKit

import PicPick_Resource
import PicPick_Util
import SnapKit

class SearchViewController: UIViewController {
    
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
        
    }()
    
    //contentView-1
    private let titleContent: UILabel = {
        let title = UILabel()
        title.text = "최근 검색한 사진"
        title.font = UIFont(name: "Pretendard-Bold", size: 18)
        title.textColor = R.Color.gray900
        title.clipsToBounds = true
        return title
        
    }()
    
    private lazy var btnDeleteCompletely: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("전체 삭제", for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard", size: 14)
        button.tintColor = R.Color.gray700
        
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
         
        
        return button
    }()
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 11
        return layout
    }()
    
    private lazy var cardContent: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCardCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCardCollectionViewCell")
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    //키워드
    let keywordBtn: UIButton = {
        let button = UIButton(type: .system)
        
        return button
    }()
    
    //팝업뷰
    
    @objc func deleteButtonTapped() {
            // 팝업 내용 추가
        // 팝업 띄우기 또는 검색어 삭제 등의 동작 수행
            let alertController = UIAlertController(title: "검색어를 삭제하시겠습니까?", message: "삭제 클릭시 최근 검색어가 삭제됩니다.", preferredStyle: .alert)
            
            // 확인 버튼 추가
            let confirmAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
                guard let self = self else { return }
                // 팝업 확인 시 동작할 내용 구현
                // 예를 들어, 검색어 삭제 등의 로직 수행
                cardContent.removeFromSuperview()
                btnDeleteCompletely.removeFromSuperview()
                self.updateContentViewForRecentContentNone()
            }
            alertController.addAction(confirmAction)
            
            // 취소 버튼 추가
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            // 팝업 화면에 띄우기
            present(alertController, animated: true, completion: nil)
        
        /*
            popUpView.addSubview(cancelBtn)
            closeButton.snp.makeConstraints { make in
                make.width.equalTo(128)
                make.height.equalTo(42)
            }
            
            // 팝업을 화면에 추가
            view.addSubview(closeBtn)
            popupView.snp.makeConstraints { make in
                make.width.equalTo(128)
                make.height.equalTo(42)
                make.center.equalToSuperview()
                make.width.equalTo(301)
                make.height.equalTo(164)
            }
         
         */
        }
    
    private func updateContentViewForRecentContent() {
        print("최근검색한 사진")
        
        contentView.addSubview(titleContent)
        contentView.addSubview(btnDeleteCompletely)
        contentView.addSubview(cardContent)
        
        
        titleContent.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(4)
            make.top.equalTo(contentView.snp.top)
        }
        
        btnDeleteCompletely.snp.makeConstraints { make in
            make.top.trailing.equalTo(contentView)
        }
        
        cardContent.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(38)
            make.leading.trailing.bottom.equalTo(contentView)
            
        }
        
        
        
    }
    
    private func updateContentViewForRecentContentNone() {
        print("최근검색한 사진없음")
        
        let icon = UIImageView()
        icon.image = R.Image.icoSearch46.withRenderingMode(.alwaysTemplate)
        icon.tintColor = R.Color.gray500
        
        
        let text = UILabel()
        text.text = "최근 검색한 사진이 없습니다."
        text.font = UIFont(name: "Pretendard", size: 14)
        text.textColor = R.Color.gray500
        
        contentView.addSubview(icon)
        contentView.addSubview(text)
        
        icon.snp.remakeConstraints { make in
            make.height.width.equalTo(48)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(text.snp.top).offset(-10)
        }
        
        text.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            
        }
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.Color.systemWhite

        removeBackBtnTitle()
        
        self.view.addSubview(self.contentView)
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "추억을 찾아드려요"
        
        self.navigationItem.titleView = searchBar
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(22)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        //updateContentViewForRecentContentNone()
        updateContentViewForRecentContent()
        
    }
    

}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of cells
        return 3 // or any other value based on your data
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCardCollectionViewCell", for: indexPath) as? PhotoCardCollectionViewCell else {
            return UICollectionViewCell()
        }
        // Configure your cell here
        // ...
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Return the size for each cell
        return CGSize(width: 166, height: 248)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Return the minimum line spacing
        return 10.0 // or any other value based on your preference
    }
    
}


