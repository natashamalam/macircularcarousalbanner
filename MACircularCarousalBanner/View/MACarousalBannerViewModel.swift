//
//  MACarousalBannerViewModel.swift
//  MACircularCarousalBanner
//
//  Created by Alam, Mahjabin | Natasha | ECMPD on 2023/02/14.
//

import UIKit

class MACarousalBannerViewModel {
    
    private(set) var currentVisibleIndexpath: IndexPath?
    
    private let listViewModel: MACarousalViewModel
    
    init(imageNames: [String]) {
        currentVisibleIndexpath = IndexPath(row: 0, section: 0)
        let images = imageNames.compactMap { imageName in
            UIImage(named: imageName)
        }
        self.listViewModel = MACarousalViewModel(images)
    }
    
    func updatedIndexPath(currentRow: Int, currentSection: Int = 0) -> IndexPath? {
        return IndexPath(row: currentRow, section: currentSection)
    }
    
    func updateCurrentIndexPath(with indexPath: IndexPath) {
        currentVisibleIndexpath = indexPath
    }
    
    func imageList() -> [UIImage] {
        return listViewModel.items()
    }
    
    func image(at index: Int) -> UIImage? {
        return listViewModel.item(at: index)
    }
    
}
