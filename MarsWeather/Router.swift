//
//  Router.swift
//  MarsWeather
//
//  Created by Enzo Antonino on 16/09/2017.
//  Copyright © 2017 Enzo Antonino. All rights reserved.
//

import Alamofire


enum Router: URLRequestConvertible {
    
    case latest
    
    static let baseURLString = "http://marsweather.ingenology.com/v1"
    
    var method: HTTPMethod {
        switch self {
        case .latest:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .latest:
            return "/latest"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .latest:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: ["format":"json"])
        }
        
        return urlRequest
    }
}
