//
//  ProductHeaderCell.swift
//  Shopify Challenge
//
//  Created by Dosbol Duysekov on 1/20/19.
//  Copyright © 2019 Dosbol Duysekov. All rights reserved.
//

import UIKit

final class ProductHeaderCell: UITableViewCell {
    
    var collectionTopTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    var collectionTopBody: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(collectionTopTitle)
        addSubview(collectionTopBody)
        
        collectionTopTitle.translatesAutoresizingMaskIntoConstraints = false
        collectionTopBody.translatesAutoresizingMaskIntoConstraints = false
        
        collectionTopTitle.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        collectionTopTitle.bottomAnchor.constraint(equalTo: collectionTopBody.topAnchor, constant: -8).isActive = true
        collectionTopTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        collectionTopTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        collectionTopBody.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        collectionTopBody.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        collectionTopBody.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
}
