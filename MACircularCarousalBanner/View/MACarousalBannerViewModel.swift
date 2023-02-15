//
//  MACarousalBannerViewModel.swift
//  MACircularCarousalBanner
//
//  Created by Alam, Mahjabin | Natasha | ECMPD on 2023/02/14.
//

import UIKit

class MACarousalBannerViewModel {
    
    let datasource: MAChain<UIImage>
    private(set) var currentVisibleIndexpath: IndexPath?
    
    init(imageNames: [String]) {
        currentVisibleIndexpath = IndexPath(row: 0, section: 0)
        let images = imageNames.compactMap { imageName in
            UIImage(named: imageName)
        }
        datasource = MAChain(items: images)
    }
    
    func updatedIndexPath(currentRow: Int, currentSection: Int = 0) -> IndexPath? {
        return IndexPath(row: currentRow, section: currentSection)
    }
    
    func updateCurrentIndexPath(with indexPath: IndexPath) {
        currentVisibleIndexpath = indexPath
    }
    
    func item(at index: Int) -> UIImage? {
        return datasource.itemAt(index)
    }
    
}
