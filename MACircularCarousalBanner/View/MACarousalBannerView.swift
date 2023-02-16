//
//  MACarousalBannerView.swift
//  MACarousalBanner
//
//  Created by Mahjabin Alam on 2022/07/11.
//

import UIKit

protocol MACarousalBannerViewDelegate: AnyObject {
    func moveForwards()
    func moveBackwards()
}

class MACarousalBannerView: UIView, UIScrollViewDelegate {
    
    weak var delegate: MACarousalBannerViewDelegate?
    
    private let viewModel: MACarousalBannerViewModel
    
    let carousalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    let stackContentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Initializers
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: MACarousalBannerViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews()
        addLayoutConstraints()
        carousalScrollView.delegate = self
    }
    
    // MARK: - customizing sub views
    
    private func addItemsToStackView() {
        let images = viewModel.imageList()
        for image in images {
            let imageView = getImageView(for: image)
            stackContentView.addArrangedSubview(imageView)
        }
    }
    
    func getImageView(for image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return imageView
    }
    
    func addSubViews() {
        addSubview(carousalScrollView)
        carousalScrollView.addSubview(stackContentView)
        addItemsToStackView()
    }
    
    private func addLayoutConstraints() {
        let constraints = [
            carousalScrollView.topAnchor.constraint(equalTo: topAnchor),
            carousalScrollView.leftAnchor.constraint(equalTo: leftAnchor),
            carousalScrollView.rightAnchor.constraint(equalTo: rightAnchor),
            carousalScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackContentView.topAnchor.constraint(equalTo: carousalScrollView.topAnchor),
            stackContentView.leftAnchor.constraint(equalTo: carousalScrollView.leftAnchor),
            stackContentView.rightAnchor.constraint(equalTo: carousalScrollView.rightAnchor),
            stackContentView.bottomAnchor.constraint(equalTo: carousalScrollView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        moveForwards(scrollView)
    }
    
    func moveForwards(_ scrollView: UIScrollView) {
        let contentOffsetXPosition = scrollView.contentOffset.x
        let imageViewFrameWidth = (UIScreen.main.bounds.width * CGFloat(viewModel.imageList().count))
        if contentOffsetXPosition > imageViewFrameWidth {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        print("content Offset \(contentOffsetXPosition)")
        
//        guard let currentIndex = viewModel.currentVisibleIndexpath?.row else {return}
//
//        if let nextIndexpath = viewModel.updatedIndexPath(currentRow: currentIndex + 1) {
//            imageScrollView.scrollToItem(at: nextIndexpath,
//                                             at: .centeredHorizontally,
//                                             animated: true)
//            viewModel.updateCurrentIndexPath(with: nextIndexpath)
//            delegate?.moveBackwards()
//        }
    }
    
//    @objc func moveBackwards() {
//        guard let currentIndex = viewModel.currentVisibleIndexpath?.row else {return}
//
//        if let prevIndexpath = viewModel.updatedIndexPath(currentRow: currentIndex - 1) {
//            imageScrollView.scrollToItem(at: prevIndexpath,
//                                             at: .centeredHorizontally,
//                                             animated: true)
//            viewModel.updateCurrentIndexPath(with: prevIndexpath)
//            delegate?.moveBackwards()
//        }
//    }
//
}
/*
extension MACarousalBannerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: collectionView.bounds.height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.defaultSectionNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.datasource.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let carousalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarousalViewCell", for: indexPath) as? MACarousalViewCell else { return UICollectionViewCell() }
        carousalCell.image = viewModel.datasource.itemAt(indexPath.row)
        return carousalCell
    }
    
}
*/
