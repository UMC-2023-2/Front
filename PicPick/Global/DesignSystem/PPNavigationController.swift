//
//  PPNavigationController.swift
//  PicPick
//
//  Created by Jaeuk on 2/8/24.
//

import UIKit

import PicPick_Resource

class PPNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBar.backIndicatorImage = R.Image.icoNavLineArrowLeft24
        navigationBar.backIndicatorTransitionMaskImage = R.Image.icoNavLineArrowLeft24
        navigationBar.tintColor = R.Color.gray900
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font : PPFont.titleLarge700.font]
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
