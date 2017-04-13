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
    
    var multipartFormData: ((MultipartFormData) -> Void)? {
        switch self {
        case .uploadPhoto(let image, let fromUserId, let toUserId):
            return { multipartFormData in
                multipartFormData.append(image.data!, withName: "file", fileName: "file.jpg", mimeType: "image/jpeg")
                multipartFormData.append("\(fromUserId)".data(using: .utf8)!, withName: "from_userId")
                if let toUserId = toUserId {
                    multipartFormData.append("\(toUserId)".data(using: .utf8)!, withName: "to_userId")
                }
            }
        default:
            return nil
        }
    }
}

final class API {
    
    static let baseURL = URL(string: "https://snappyapp.herokuapp.com/images/")
    
    class func request(_ endpoint: Endpoint, completion: ((Bool) -> Void)) {
        guard let url = URL(string: endpoint.url, relativeTo: API.baseURL) else { fatalError() }
        
        switch endpoint {
        case .uploadPhoto:
            Alamofire.upload(multipartFormData: endpoint.multipartFormData!, to: url) { encodingResult in
                switch encodingResult {
                case .success(let request, _, _):
                    print("Encoding success")
                case .failure(let error):
                    print("Encoding failure: \(error.localizedDescription)")
                }
            }
            
        default:
            break
        }
    }
}
