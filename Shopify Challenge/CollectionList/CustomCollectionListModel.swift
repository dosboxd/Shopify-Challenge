//
//  Model.swift
//  Shopify Challenge
//
//  Created by Dosbol Duysekov on 1/19/19.
//  Copyright © 2019 Dosbol Duysekov. All rights reserved.
//

import Foundation

struct CustomCollectionList: Codable {
    let customCollections: [CustomCollection]
    
    enum CodingKeys: String, CodingKey {
        case customCollections = "custom_collections"
    }
}

struct CustomCollection: Codable {
    let id: Int?
    let handle, title: String?
    let updatedAt: Date?
    let bodyHTML: String?
    let publishedAt: Date?
    let sortOrder: SortOrder?
    let templateSuffix: String?
    let publishedScope: PublishedScope?
    let adminGraphqlAPIID: String?
    let image: CollectionListImage?
    
    enum CodingKeys: String, CodingKey {
        case id, handle, title
        case updatedAt = "updated_at"
        case bodyHTML = "body_html"
        case publishedAt = "published_at"
        case sortOrder = "sort_order"
        case templateSuffix = "template_suffix"
        case publishedScope = "published_scope"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case image
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        handle = try values.decodeIfPresent(String.self, forKey: .handle)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        bodyHTML = try values.decodeIfPresent(String.self, forKey: .bodyHTML)
        sortOrder = try values.decodeIfPresent(SortOrder.self, forKey: .sortOrder)
        templateSuffix = try values.decodeIfPresent(String.self, forKey: .templateSuffix)
        publishedScope = try values.decodeIfPresent(PublishedScope.self, forKey: .publishedScope)
        adminGraphqlAPIID = try values.decodeIfPresent(String.self, forKey: .adminGraphqlAPIID)
        image = try values.decodeIfPresent(CollectionListImage.self, forKey: .image)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)?.toDate(format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)?.toDate(format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
    }
}

struct CollectionListImage: Codable {
    let createdAt: Date?
    let alt: String?
    let width, height: Int?
    let src: String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case alt, width, height, src
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        alt = try values.decodeIfPresent(String.self, forKey: .alt)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        src = try values.decodeIfPresent(String.self, forKey: .src)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)?.toDate(format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
    }
}

enum PublishedScope: String, Codable {
    case web = "web"
}

enum SortOrder: String, Codable {
    case bestSelling = "best-selling"
}
