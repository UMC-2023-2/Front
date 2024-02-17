//
//  CurationViewController.swift
//  tabbarcustom
//
//  Created by 신지연 on 2024/02/06.
//

import UIKit

import PicPick_Resource
import PicPick_Util
import SnapKit

class CurationViewController: UIViewController, UITextFieldDelegate {

    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        view.clipsToBounds = true
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    
    
    //topView
    let topImage: UIImageView = {
        let image = UIImageView()
        image.image = .back01
        image.contentMode = .center
        image.clipsToBounds = true
        return image
    }()
    
    let albumTitle: UILabel = {
        let title = UILabel()
        title.text = "3D 입체 앨범 모형"
        title.font = UIFont(name: "Pretendard-Bold", size: 22)
        title.textColor = .white
        title.backgroundColor = .clear // 배경색 설정
        title.clipsToBounds = true
        return title
    }()
    
    
    
    
    let searchBar: UITextField = {
        let search = UITextField()
        search.placeholder = "  앨범안에 있는 추억을 찾아보세요"
        search.font = UIFont(name: "Pretendard", size: 14)
        search.backgroundColor = R.Color.gray700.withAlphaComponent(0.8)
        search.textColor = .white
        search.layer.cornerRadius = 27
        return search
    }()
    
    
    //contentView
    private let titleContent: UILabel = {
        let title = UILabel()
        title.text = "앨범 사진"
        title.font = UIFont(name: "Pretendard-Bold", size: 18)
        title.textColor = R.Color.gray900
        title.clipsToBounds = true
        return title
    }()
    
    private let textFilter: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "Pretendard", size: 12)
        text.textColor = R.Color.gray700
        text.text = "시간순"
        return text
    }()
    
    private let btnFilter: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.Image.icoArrowDown24.withRenderingMode(.alwaysTemplate), for: .normal)
        
        button.backgroundColor = .white
        button.addTarget(CurationViewController.self, action: #selector(filterButtonTapped), for: .touchUpInside)
        button.tintColor = R.Color.gray700
        return button
    }()
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let indexPath = IndexPath(item: 0, section: 0)
        let yOffset = 532 / 2
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 15
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
    
    //noneContent
    private lazy var noneContentView: UIView = {
        let ncView = UIView()
        
        
        
        // Text Label 추가
        let textLabel = UILabel()
        ncView.addSubview(textLabel)
        textLabel.text = "앨범에 사진이 없습니다."
        textLabel.textColor = R.Color.gray500
        textLabel.font = UIFont(name: "Pretendard", size: 14)
        textLabel.textAlignment = .center
        textLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            
            make.height.equalTo(22)
        }
        
        // 이미지뷰 추가
        let imageView = UIImageView()
        imageView.image = R.Image.icoImg46.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = R.Color.gray500
        ncView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(textLabel.snp.top).offset(-8) // text label과의 간격 조절
            make.height.equalTo(46)
            make.width.equalTo(imageView.snp.height)
        }
        
        // 버튼 추가
        let addPhotoBtn = UIButton(type: .system)
        ncView.addSubview(addPhotoBtn)
        addPhotoBtn.setTitle("사진 추가하기", for: .normal)
        addPhotoBtn.layer.cornerRadius = 21
        addPhotoBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textLabel.snp.bottom).offset(10) // text label과의 간격 조절
            make.width.equalTo(165) // 가로 길이와 동일하게
            make.height.equalTo(42) // 높이는 30px로
        }
        addPhotoBtn.setTitleColor(R.Color.gray500, for: .normal)
        addPhotoBtn.backgroundColor = UIColor.clear
        addPhotoBtn.layer.borderWidth = 1.0
        addPhotoBtn.layer.borderColor = R.Color.gray500.cgColor
        
        addPhotoBtn.addTarget(self, action: #selector(didTappedAddPhotoBtn), for: .touchUpInside)
        
        return ncView
    }()
    
    
    
    
    //
    private func loadTopView(){
        
        let searchButton = UIButton()
        let searchImage = UIImage(named: "icoSearch")
        searchButton.setBackgroundImage(searchImage, for: .normal)
        searchButton.frame = CGRectMake(0,0, 36, 36)
        searchButton.addTarget(self, action: #selector(self.clickSearchButton), for: .touchUpInside)
        
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16) // 오른쪽 여백 추가
        searchButton.configuration = buttonConfig
        //searchButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16) // 오른쪽 여백 추가
        searchBar.leftView = searchButton
        searchBar.leftViewMode = UITextField.ViewMode.always
        searchBar.delegate = self
        
        topView.addSubview(albumTitle)
        topView.addSubview(searchBar)
        
        albumTitle.snp.makeConstraints { make in
            make.top.equalTo(topView).offset(97)
            make.leading.equalToSuperview().offset(20)
        }
        
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.width.equalTo(343)
            make.centerX.equalToSuperview()
            make.top.equalTo(topView.snp.top).offset(156)
        }
    }
    
    private func loadContentView() {
        contentView.addSubview(titleContent)
        contentView.addSubview(btnFilter)
        contentView.addSubview(textFilter)
        contentView.addSubview(cardContent)
        
        titleContent.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(4)
            make.top.equalTo(contentView.snp.top)
        }
        
        btnFilter.snp.makeConstraints { make in
            make.centerY.equalTo(titleContent)
            make.trailing.equalTo(contentView)
            make.width.height.equalTo(14)
        }
        
        textFilter.snp.makeConstraints { make in
            make.trailing.equalTo(btnFilter.snp.leading)
            make.centerY.equalTo(btnFilter)
        }
        
        cardContent.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(38)
            make.leading.trailing.bottom.equalTo(contentView)
            
        }
        
    }
    
    
    private func updateContentViewForEmpty() {
        
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        contentView.addSubview(titleContent)
        contentView.addSubview(btnFilter)
        contentView.addSubview(textFilter)
        contentView.addSubview(noneContentView)
        
        titleContent.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(4)
            make.top.equalTo(contentView.snp.top)
        }
        
        btnFilter.snp.makeConstraints { make in
            make.centerY.equalTo(titleContent)
            make.trailing.equalTo(contentView)
            make.width.height.equalTo(14)
        }
        
        textFilter.snp.makeConstraints { make in
            make.trailing.equalTo(btnFilter.snp.leading)
            make.centerY.equalTo(btnFilter)
        }
        
        noneContentView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(38)
            make.leading.trailing.bottom.equalTo(contentView)
            
        }
        
        
        contentView.addSubview(noneContentView)
        
    }
    
    @objc func didTappedAddPhotoBtn() {
        let addPhotoViewController = AddPhotoViewController()
        
        navigationController?.pushViewController(addPhotoViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = R.Color.systemWhite
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        removeBackBtnTitle()
        let homebutton = UIBarButtonItem(image:R.Image.icoHome24.withRenderingMode(.alwaysTemplate) , style: .done, target: self, action: #selector(back))
        self.navigationItem.rightBarButtonItem = homebutton
        
        navigationController?.navigationBar.tintColor = R.Color.systemWhite
        
        
        
        
        self.view.addSubview(self.backView)
        self.view.addSubview(self.topImage)
        self.view.addSubview(self.topView)
        self.view.addSubview(self.contentView)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        topImage.snp.makeConstraints { make in
            make.height.equalTo(226)
            make.leading.trailing.top.equalToSuperview()
        }
        topImage.layer.cornerRadius = 40
        // 특정 모서리에만 코너 라디우스를 적용하는 CACornerMask를 정의합니다.
        let maskedCorners: CACornerMask = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        // CACornerMask에 따라 코너 라디우스를 설정합니다.
        let cornerRadius: CGFloat = 40
        topImage.layer.maskedCorners = maskedCorners
        topImage.layer.cornerCurve = .continuous
        topImage.layer.cornerRadius = cornerRadius
        
        topView.layer.cornerRadius = 40
        topView.snp.makeConstraints { make in
            make.height.equalTo(226)
            make.leading.trailing.top.equalToSuperview()
        }
        topView.layer.maskedCorners = maskedCorners
        topView.layer.cornerCurve = .continuous
        topView.layer.cornerRadius = cornerRadius

        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(26)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        
        loadTopView()
        //loadContentView()
        updateContentViewForEmpty()
    }
    
    
    @objc func back() {
            self.navigationController?.popViewController(animated: true)
        }
    
    @objc func clickSearchButton() {
            //self.navigationController?.popViewController(animated: true)
        }
    
    @objc private func filterButtonTapped() {
        /*
        // 팝업창 생성 및 설정
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 시간순 버튼
        let chronologicalAction = UIAlertAction(title: "시간순", style: .default) { _ in
            // 시간순으로 정렬하는 로직 추가
            self.btnFilter.setTitle("시간순", for: .normal)
        }
        alertController.addAction(chronologicalAction)
        
        // 연관순 버튼
        let relevanceAction = UIAlertAction(title: "연관순", style: .default) { _ in
            // 연관순으로 정렬하는 로직 추가
            self.btnFilter.setTitle("연관순", for: .normal)
        }
        alertController.addAction(relevanceAction)
        
        
        // 현재 뷰 컨트롤러에서 팝업창 표시
        present(alertController, animated: true, completion: nil)
         */
    }

    

}

extension CurationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
