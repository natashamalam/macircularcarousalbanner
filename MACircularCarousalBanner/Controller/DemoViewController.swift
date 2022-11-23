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
        carousalBanner = MACarousalBannerView(images: ["img_1.jpg", "img_2.jpg", "img_3.jpg", "img_4.jpg", "img_5.jpg"])
        carousalBanner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(carousalBanner)
        addlayoutConstraints()
    }
    
    func addlayoutConstraints() {
        let constraints = [
            carousalBanner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            carousalBanner.heightAnchor.constraint(equalToConstant: 200),
            carousalBanner.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            carousalBanner.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}