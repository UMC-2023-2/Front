//
//  QRViewController.swift
//  PicPick
//
//  Created by Jaeuk on 1/26/24.
//

import UIKit

import SnapKit

class QRViewController: UIViewController {

    lazy var qrReaderView: QRReaderView = QRReaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(qrReaderView)
        
        qrReaderView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
