//
//  NetworkLayer.swift
//  Shopify Challenge
//
//  Created by Dosbol Duysekov on 1/19/19.
//  Copyright © 2019 Dosbol Duysekov. All rights reserved.
//

import Alamofire

extension URL {
    static let customCollectionList = URL(string: "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
}

class NetworkLayer {
    
    static func getCustomCollectionList(completion: @escaping (Data?, NSError?) -> Void) {
        guard let url = URL.customCollectionList else { print("Wrong url"); return }
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .failure(let error):
                let nserror = NSError(domain: error.localizedDescription, code: response.response?.statusCode ?? 0, userInfo: nil)
                completion(nil, nserror)
            case .success:
                completion(response.data, nil)
            }
        }
    }
}
