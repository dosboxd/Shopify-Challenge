//
//  CustomCollectionEntityModel.swift
//  Shopify Challenge
//
//  Created by Dosbol Duysekov on 1/19/19.
//  Copyright © 2019 Dosbol Duysekov. All rights reserved.
//

import Foundation

struct CustomCollectionEntityList: Codable {
    let collects: [Collect]
}

struct Collect: Codable {
    let id, collectionID, productID: Int?
    let featured: Bool?
    let createdAt, updatedAt: Date?
    let position: Int?
    let sortValue: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case collectionID = "collection_id"
        case productID = "product_id"
        case featured
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case position
        case sortValue = "sort_value"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        collectionID = try values.decodeIfPresent(Int.self, forKey: .collectionID)
        productID = try values.decodeIfPresent(Int.self, forKey: .productID)
        featured = try values.decodeIfPresent(Bool.self, forKey: .featured)
        position = try values.decodeIfPresent(Int.self, forKey: .position)
        sortValue = try values.decodeIfPresent(String.self, forKey: .sortValue)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)?.toDate(format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)?.toDate(format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
    }
}

struct Products: Codable {
    let products: [Product]
}

struct Product: Codable {
    let id: Int?
    let title, bodyHTML, vendor, productType: String?
    let createdAt: String? // TODO: Use Date.Type
    let handle: String?
    let updatedAt, publishedAt: String?
//    let templateSuffix: JSONNull?
    let tags, publishedScope, adminGraphqlAPIID: String?
    let variants: [Variant]?
    let options: [Option]?
    let images: [ProductImage]?
    let image: ProductImage?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case bodyHTML = "body_html"
        case vendor
        case productType = "product_type"
        case createdAt = "created_at"
        case handle
        case updatedAt = "updated_at"
        case publishedAt = "published_at"
//        case templateSuffix = "template_suffix"
        case tags
        case publishedScope = "published_scope"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case variants, options, images, image
    }
}

struct ProductImage: Codable {
    let id, productID, position: Int
    let createdAt, updatedAt: String
    let alt: String?
    let width, height: Int
    let src: String
    let variantIDS: [Int]
    let adminGraphqlAPIID: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case position
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case alt, width, height, src
        case variantIDS = "variant_ids"
        case adminGraphqlAPIID = "admin_graphql_api_id"
    }
}

struct Option: Codable {
    let id, productID: Int?
    let name: String?
    let position: Int?
    let values: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case name, position, values
    }
}

struct Variant: Codable {
    let id, productID: Int?
    let title, price, sku: String?
    let position: Int?
    let inventoryPolicy: InventoryPolicy?
//    let compareAtPrice: JSONNull?
    let fulfillmentService: FulfillmentService?
//    let inventoryManagement: JSONNull?
    let option1: String?
    let option2, option3: String?
    let createdAt, updatedAt: String?
    let taxable: Bool?
//    let barcode: JSONNull?
    let grams: Int?
//    let imageID: JSONNull?
    let weight: Double?
    let weightUnit: WeightUnit?
    let inventoryItemID, inventoryQuantity, oldInventoryQuantity: Int?
    let requiresShipping: Bool?
    let adminGraphqlAPIID: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case title, price, sku, position
        case inventoryPolicy = "inventory_policy"
//        case compareAtPrice = "compare_at_price"
        case fulfillmentService = "fulfillment_service"
//        case inventoryManagement = "inventory_management"
        case option1, option2, option3
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case taxable, /*barcode,*/ grams
//        case imageID = "image_id"
        case weight
        case weightUnit = "weight_unit"
        case inventoryItemID = "inventory_item_id"
        case inventoryQuantity = "inventory_quantity"
        case oldInventoryQuantity = "old_inventory_quantity"
        case requiresShipping = "requires_shipping"
        case adminGraphqlAPIID = "admin_graphql_api_id"
    }
}

enum FulfillmentService: String, Codable {
    case manual = "manual"
}

enum InventoryPolicy: String, Codable {
    case deny = "deny"
}

enum WeightUnit: String, Codable {
    case kg = "kg"
}
