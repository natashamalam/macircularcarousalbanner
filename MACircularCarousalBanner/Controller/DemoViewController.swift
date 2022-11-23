//
//  DemoViewController.swift
//  MACircularCarousalBanner
//
//  Created by Alam, Mahjabin | Natasha | ECMPD on 2022/11/23.
//

import UIKit

class DemoViewController: UIViewController {
    
    var carousalBanner: MACarousalBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initializeCarousalBanner()
    }

    func initializeCarousalBanner() {
        carousalBanner = MACarousalBannerView(images: ["img_1", "img_2", "img_3", "img_4", "img_5"])
        carousalBanner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(carousalBanner)
        addlayoutConstraints()
    }
    
    func addlayoutConstraints() {
        let constraints = [
            carousalBanner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            carousalBanner.heightAnchor.constraint(equalToConstant: 200),
            carousalBanner.leftAnchor.constraint(equalTo: view.leftAnchor),
            carousalBanner.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
