//
//  ProductCell.swift
//  Shopify Challenge
//
//  Created by Dosbol Duysekov on 1/19/19.
//  Copyright © 2019 Dosbol Duysekov. All rights reserved.
//

import UIKit

final class ProductCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let productTotal: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let collectionTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let collectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(collectionImageView)
        addSubview(productTotal)
        addSubview(collectionTitle)
        addSubview(titleLabel)
        
        collectionImageView.translatesAutoresizingMaskIntoConstraints = false
        productTotal.translatesAutoresizingMaskIntoConstraints = false
        collectionTitle.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        collectionImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        collectionImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8).isActive = true
        collectionImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        collectionImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        collectionImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
//        collectionImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: collectionImageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: productTotal.bottomAnchor, constant: -8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        productTotal.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        productTotal.bottomAnchor.constraint(equalTo: collectionTitle.bottomAnchor, constant: -8).isActive = true
        productTotal.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        productTotal.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        collectionTitle.topAnchor.constraint(equalTo: productTotal.bottomAnchor, constant: 8).isActive = true
        collectionTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        collectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        collectionTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
