//
//  API.swift
//  Snappy
//
//  Created by Piotr Sochalewski on 13.04.2017.
//  Copyright © 2017 Droids on Roids. All rights reserved.
//

import UIKit
import Alamofire

enum Endpoint {
    case uploadPhoto(image: UIImage, fromUserId: Int, toUserId: Int?)
    case getPhotos(userId: Int?)
    case removePhoto(filename: String, toUserId: Int?)
    
    var url: String {
        switch self {
        case .uploadPhoto:
            return "upload"
        default:
            return ""
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getPhotos:
            return .get
        case .uploadPhoto, .removePhoto:
            return .post
        }
    }
}

final class API {
    
    static let baseURL = URL(string: "https://snappyapp.herokuapp.com/images/")
    
    class func request(_ endpoint: Endpoint, completion: ((Bool) -> Void)) {
        guard let url = URL(string: endpoint.url, relativeTo: API.baseURL) else { fatalError() }
    }
}
