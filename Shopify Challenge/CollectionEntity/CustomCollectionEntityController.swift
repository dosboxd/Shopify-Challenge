//
//  CustomCollectionEntityController.swift
//  Shopify Challenge
//
//  Created by Dosbol Duysekov on 1/19/19.
//  Copyright © 2019 Dosbol Duysekov. All rights reserved.
//

import UIKit

final class CustomCollectionEntityController: UIViewController {

    // MARK: Properties
    var imageSRC: String? {
        didSet {
            loadCover(by: imageSRC)
        }
    }
    var collectionID: Int? {
        didSet {
            if let collectionID = collectionID  {
                loadData(by: collectionID)
            }
        }
    }
    private let entityCollectionCell = "CustomCollectionEntityCell"
    
    var collectList: CustomCollectionEntityList? {
        didSet {
            if let ids = collectList?.collects.compactMap({ $0.productID }) {
                loadProducts(by: ids)
            }
        }
    }
    var productList: Products? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    // MARK: View Elements
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProductCell.self, forCellReuseIdentifier: entityCollectionCell)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        return imageView
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: Custom Methods
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(imageView)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let heightOffset = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height ?? 44)
        
        tableView.contentInset = UIEdgeInsets(top: 256, left: 0, bottom: 0, right: 0)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: heightOffset).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        imageView.frame = CGRect(x: 0, y: heightOffset, width: view.frame.width, height: 256)
    }
    
    private func loadData(by collectionID: Int) {
        let stringWithID = String(format: URLs.customCollectionEntity, String(describing: collectionID))
        NetworkLayer.getData(from: stringWithID) { [weak self] data, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(CustomCollectionEntityList.self, from: data)
                    self?.collectList = decoded
                } catch {
                    print(error)
                }
            }
        }
    }
    
    private func loadProducts(by ids: [Int]) {
        let stringIDs = ids.map { String($0) }
        let stringIDsByComma = stringIDs.joined(separator: ",")
        let stringWithID = String(format: URLs.customCollectionProduct, stringIDsByComma)
        NetworkLayer.getData(from: stringWithID) { [weak self] data, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(Products.self, from: data)
                    self?.productList = decoded
                } catch {
                    print(error)
                }
            }
        }
    }
    
    private func loadCover(by src: String?) {
        NetworkLayer.getData(from: src) { [weak self] data, error in
            DispatchQueue.main.async {
                if let data = data {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                    self?.imageView.frame.size.height = image?.size.height ?? 256
                    self?.tableView.contentInset.top = image?.size.height ?? 256
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 256 - (scrollView.contentOffset.y + 256)
        let height  = max(128, y)
        imageView.frame.size.height = height
    }
}

extension CustomCollectionEntityController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: entityCollectionCell, for: indexPath) as? ProductCell else { return UITableViewCell() }
        cell.titleLabel.text = productList?.products[indexPath.row].title
        cell.collectionTitle.text = productList?.products[indexPath.row].variants?.first?.price
        cell.productTotal.text = productList?.products[indexPath.row].options?.first?.name
        
        NetworkLayer.getData(from: productList?.products[indexPath.row].image?.src) { data, error in
            DispatchQueue.main.async {
                if let data = data {
                    cell.collectionImageView.image = UIImage(data: data)
                }
            }
        }
        
        return cell
    }
}
