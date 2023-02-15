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

class MACarousalBannerView: UIView {
    
    weak var delegate: MACarousalBannerViewDelegate?
    private let viewModel: MACarousalBannerViewModel
    
    let wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumInteritemSpacing = 5.0
        collectionViewFlowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    let leftArrowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "backwards"), for: .normal)
        return button
    }()
    
    let rightArrowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "forwards"), for: .normal)
        return button
    }()
    
    // MARK: - Initializers
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: MACarousalBannerViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = .lightText
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews()
        addLayoutConstraints()
        configureSubviews()
    }
    
    // MARK: - customizing sub views
    func addSubViews() {
        wrapperView.addSubview(leftArrowButton)
        wrapperView.addSubview(rightArrowButton)
        wrapperView.addSubview(imageCollectionView)
        addSubview(wrapperView)
    }
    
    func configureSubviews() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        imageCollectionView.register(MACarousalViewCell.self, forCellWithReuseIdentifier: "CarousalViewCell")
        
        leftArrowButton.addTarget(self, action: #selector(moveBackwards), for: .touchUpInside)
        rightArrowButton.addTarget(self, action: #selector(moveForwards), for: .touchUpInside)
    }
    
    func addLayoutConstraints() {
        let constraints = [
            wrapperView.topAnchor.constraint(equalTo: self.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            wrapperView.leftAnchor.constraint(equalTo: self.leftAnchor),
            wrapperView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            leftArrowButton.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor),
            leftArrowButton.leftAnchor.constraint(equalTo: wrapperView.leftAnchor),
            leftArrowButton.heightAnchor.constraint(equalToConstant: 60),
            leftArrowButton.widthAnchor.constraint(equalTo: leftArrowButton.heightAnchor),
            
            rightArrowButton.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor),
            rightArrowButton.rightAnchor.constraint(equalTo: wrapperView.rightAnchor),
            rightArrowButton.heightAnchor.constraint(equalToConstant: 60),
            rightArrowButton.widthAnchor.constraint(equalTo: rightArrowButton.heightAnchor),
        
            imageCollectionView.leftAnchor.constraint(equalTo: leftArrowButton.rightAnchor, constant: 5),
            imageCollectionView.rightAnchor.constraint(equalTo: rightArrowButton.leftAnchor, constant: -5),
            imageCollectionView.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            imageCollectionView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func moveForwards() {
        guard let currentIndex = viewModel.currentVisibleIndexpath?.row else {return}
        
        if let nextIndexpath = viewModel.updatedIndexPath(currentRow: currentIndex + 1) {
            imageCollectionView.scrollToItem(at: nextIndexpath,
                                             at: .centeredHorizontally,
                                             animated: true)
            viewModel.updateCurrentIndexPath(with: nextIndexpath)
            delegate?.moveBackwards()
        }
    }
    
    @objc func moveBackwards() {
        guard let currentIndex = viewModel.currentVisibleIndexpath?.row else {return}
        
        if let prevIndexpath = viewModel.updatedIndexPath(currentRow: currentIndex - 1) {
            imageCollectionView.scrollToItem(at: prevIndexpath,
                                             at: .centeredHorizontally,
                                             animated: true)
            viewModel.updateCurrentIndexPath(with: prevIndexpath)
            delegate?.moveBackwards()
        }
    }
    
}

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
