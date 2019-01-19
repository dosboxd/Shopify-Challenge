//
//  CustomCollectionsListPageController.swift
//  Shopify Challenge
//
//  Created by Dosbol Duysekov on 1/19/19.
//  Copyright © 2019 Dosbol Duysekov. All rights reserved.
//

import UIKit

final class CustomCollectionsListPageController: UIViewController {
    
    // MARK: Properties
    var collectionList: CustomCollectionList? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: View Elements
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 32
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCollectionListCell.self, forCellWithReuseIdentifier: "CollectionListCellID")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadData()
    }
    
    // MARK: Custom Methods
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    private func loadData() {
        NetworkLayer.getData(from: URL.customCollectionList?.absoluteString) { [weak self] data, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(CustomCollectionList.self, from: data)
                    self?.collectionList = decoded
                } catch {
                    print(error)
                }
            }
        }
    }
}

// MARK: CollectionView Delegates and Data Source
extension CustomCollectionsListPageController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionListCellID", for: indexPath) as? CustomCollectionListCell else { return UICollectionViewCell() }
        cell.imageView.image = nil
        cell.imageSrc = collectionList?.customCollections[indexPath.row].image?.src
        cell.titleLabel.text = collectionList?.customCollections[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionList?.customCollections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 2 - 32
        return CGSize(width: size, height: size)
    }
}
