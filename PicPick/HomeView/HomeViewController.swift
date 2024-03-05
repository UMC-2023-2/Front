import UIKit

import SnapKit
import PicPick_Resource
import PicPick_Util

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var bgimage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "back01") // TODO: 현재 표시되는 앨범 표지로 변경 필요
        return imageView
    }()
    
    lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    //head
    
    lazy var tabbarTop: UISegmentedControl = {
        let segment = UISegmentedControl()
        
        segment.selectedSegmentTintColor = .clear
        
        //배경 색, 구분라인 제거
        segment.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        segment.insertSegment(withTitle: NSLocalizedString("Home Top Segment 1", comment: "Memories Album Tab"), at: 0, animated: true)
        segment.insertSegment(withTitle: NSLocalizedString("Home Top Segment 2", comment: "Together Album Tab"), at: 1, animated: true)
        
        segment.selectedSegmentIndex = 0
        
        // 선택 되어 있지 않을때
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: R.Color.gray500,
            NSAttributedString.Key.font: PPFont.titleMedium500.font
        ], for: .normal)
        
        // 선택 되었을때 폰트 및 폰트컬러
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: R.Color.gray300,
            NSAttributedString.Key.font: PPFont.titleMedium700.font
        ], for: .selected)
        
        segment.addTarget(self, action: #selector(changeUnderLinePosition), for: .valueChanged)
                
        return segment
    }()
    
    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.gray300
        return view
    }()
    
    // body
    let mainView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 150
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var noneContentView: UIView = {
        let ncView = UIView()
        
        // Text Label 추가
        let textLabel = UILabel()
        ncView.addSubview(textLabel)
        textLabel.text = "현재 만들어진 앨범이 없습니다."
        textLabel.textColor = R.Color.gray400
        textLabel.font = UIFont(name: "Pretendard", size: 14)
        textLabel.textAlignment = .center
        textLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            
            make.height.equalTo(22)
        }
        
        // 이미지뷰 추가
        let imageView = UIImageView()
        imageView.image = R.Image.icoFeed46.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = R.Color.gray400
        ncView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(textLabel.snp.top).offset(-8) // text label과의 간격 조절
            make.height.equalTo(46)
            make.width.equalTo(imageView.snp.height)
        }
        
        // 버튼 추가
        let makeAlbumButton = PPLineButton(configuration: .content())
        ncView.addSubview(makeAlbumButton)
        makeAlbumButton.setTitle("앨범 만들기", for: .normal)
        makeAlbumButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textLabel.snp.bottom).offset(10) // text label과의 간격 조절
            make.width.equalTo(165) // 가로 길이와 동일하게
        }
        
        return ncView
    }()
    
    // footer
    let footerView : UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var toggleBtnBottom : UISegmentedControl = {
        let segment = UISegmentedControl()
        
        segment.layer.cornerRadius = 20
        segment.backgroundColor = UIColor.darkGray
        
        segment.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        segment.insertSegment(withTitle: NSLocalizedString("Home Footer Segment 1", comment: "Card View"), at: 0, animated: true)
        segment.insertSegment(withTitle: NSLocalizedString("Home Footer Segment 2", comment: "List View"), at: 1, animated: true)
        
        segment.selectedSegmentIndex = 0
        
        // 선택 되어 있지 않을때
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: R.Color.gray500,
            NSAttributedString.Key.font: PPFont.bodyLarge500.font
        ], for: .normal)
        
        // 선택 되었을때 폰트 및 폰트컬러
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: R.Color.gray300,
            NSAttributedString.Key.font: PPFont.bodyLarge700.font
        ], for: .selected)
        
        segment.addTarget(self, action: #selector(toggleBtnBottomTapped), for: .valueChanged)
        
        return segment
    }()
    
    

    //MARK: - Functions
    
    private func updateMainViewForCardStyle() {
        print("카드뷰")
        
        mainView.subviews.forEach { $0.removeFromSuperview() }
        mainView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.snp.remakeConstraints { make in
                    make.edges.equalToSuperview()
                }
        collectionView.backgroundColor = .clear
        collectionView.reloadData()
    
            }
    
        
    private func updateMainViewForListStyle() {
        print("테이블뷰")
        
        mainView.subviews.forEach { $0.removeFromSuperview() }
        mainView.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.reloadData()
        
    }
    
    
    
    private func updateMainViewForEmpty() {
        print("정보없음")
        
        mainView.subviews.forEach { $0.removeFromSuperview() }
        mainView.addSubview(noneContentView)
        
        noneContentView.snp.remakeConstraints { make in
                    make.edges.equalToSuperview()
                }
        noneContentView.backgroundColor = .clear
    }
    
    
    private func updateMainViewForMemoriesAlbum() {
        // "추억 앨범"에 대한 mainView 업데이트 로직 작성
        //mainView.backgroundColor = .clear
        print("추억앨범")
        
    }
    
    private func updateMainViewForTogetherAlbum() {
        // "함께 앨범"에 대한 mainView 업데이트 로직 작성
        //mainView.backgroundColor = .clear
        print("함께앨범")
    }
    
    
    // underlineView 옮기기 + 추억앨범/함께앨범
    @objc private func changeUnderLinePosition() {
        let segmentIndex = CGFloat(tabbarTop.selectedSegmentIndex)
        
        // mainView 내용 업데이트
        switch segmentIndex {
        case 0: // "추억 앨범"
            updateMainViewForMemoriesAlbum()
        case 1: // "함께 앨범"
            updateMainViewForTogetherAlbum()
        default:
            break
        }
        
        // underLineView 위치 업데이트
        let segmentWidth = tabbarTop.frame.width / CGFloat(tabbarTop.numberOfSegments)
        let newLeadingDistance = segmentWidth * segmentIndex
        
        /*
        underLineView.snp.updateConstraints { make in
            make.leading.equalTo(tabbarTop.snp.leading).offset(newLeadingDistance)
        }
        */
        underLineView.snp.remakeConstraints { make in
            make.bottom.equalTo(tabbarTop.snp.bottom).offset(2)
            make.height.equalTo(2)
            make.width.equalTo(tabbarTop.snp.width).dividedBy(tabbarTop.numberOfSegments)
            make.leading.equalTo(tabbarTop.snp.leading).offset(newLeadingDistance)
        }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
                self?.view.layoutIfNeeded()
            }
    }
    
    // 카드형식/리스트형식 선택
    @objc private func toggleBtnBottomTapped() {
        if toggleBtnBottom.selectedSegmentIndex == 0 {
            updateMainViewForCardStyle()
        } else {
            updateMainViewForListStyle()
        }
    }
    
    // 검색 버튼이 눌렸을 때 호출되는 메서드
    @objc func searchButtonTapped() {
        // SearchViewController를 생성
        let searchViewController = SearchViewController()

        // 생성한 SearchViewController로 전환
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeBackBtnTitle()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.Image.icoSearch24.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = R.Color.gray300
        
        navigationItem.titleView = tabbarTop
        tabbarTop.isUserInteractionEnabled = true
        
        
        view.addSubview(bgimage)
        view.addSubview(blurView)
        view.addSubview(mainView)
        view.addSubview(footerView)
        view.addSubview(tabbarTop)
        view.addSubview(underLineView)
        view.addSubview(toggleBtnBottom)
        
        
        updateMainViewForMemoriesAlbum()
        updateMainViewForCardStyle()
        //updateMainViewForEmpty()
        
        // SnapKit을 사용하여 제약 설정
        self.bgimage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.tabbarTop.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
//            make.bottom.equalTo(topView.snp.bottom).offset(-10)
            make.centerY.equalToSuperview()
//            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
//            make.top.equalToSuperview().offset(30)
            make.width.equalTo(136)
            make.height.equalTo(24)
        }
        
        self.underLineView.snp.makeConstraints { make in
            make.bottom.equalTo(tabbarTop.snp.bottom).offset(2)
            make.height.equalTo(2)
            make.width.equalTo(tabbarTop.snp.width).dividedBy(tabbarTop.numberOfSegments)
            make.leading.equalTo(tabbarTop.snp.leading)
            
        }
         
        self.mainView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        self.footerView.snp.makeConstraints{ make in
            make.height.equalToSuperview().dividedBy(8)
            make.bottom.equalTo(mainView.snp.bottom)
            make.width.equalTo(mainView.snp.width)
        }
        
        self.toggleBtnBottom.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(footerView.snp.top).offset(2)
            make.width.equalTo(170)
            make.height.equalTo(42)
        }
        
        
        
    }
}

// MARK: - Extension
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let curationViewController = CurationViewController()
        navigationController?.pushViewController(curationViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
  
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else{
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenHeight = UIScreen.main.bounds.height
        let collectionViewHeight = (screenHeight * 5) / 7
        return CGSize(width: 327, height: collectionViewHeight)
        
    }
}
