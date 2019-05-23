////
////  HTTPHelper.swift
////  SchoolOfScience
////
////  Created by Jacky Tang on 11/5/19.
////  Copyright © 2019 Jacky Tang. All rights reserved.
////
//
//import Foundation
//class HTTPHelper {
//    static let API_AUTH_NAME = "test.user1@rmit.edu.au"
//    static let API_AUTH_PASSWORD = "password"
//    static let BASE_URL = "https://rmit-gateway-test.herokuapp.com/api"
//
//    func buildRequest(path: String!, method: String, authType: HTTPRequestAuthType,
//                      requestContentType: HTTPRequestContentType = HTTPRequestContentType.HTTPJsonContent, requestBoundary:String = "") -> NSMutableURLRequest {
//        // 1. Create the request URL from path
//        let requestURL = NSURL(string: "\(HTTPHelper.BASE_URL)/\(path)")
//        var request = NSMutableURLRequest(URL: requestURL!)
//
//        // Set HTTP request method and Content-Type
//        request.HTTPMethod = method
//
//        // 2. Set the correct Content-Type for the HTTP Request. This will be multipart/form-data for photo upload request and application/json for other requests in this app
//        switch requestContentType {
//        case .HTTPJsonContent:
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        case .HTTPMultipartContent:
//            let contentType = "multipart/form-data; boundary=\(requestBoundary)"
//            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
//        }
//
//        // 3. Set the correct Authorization header.
//        switch authType {
//        case .HTTPBasicAuth:
//            // Set BASIC authentication header
//            let basicAuthString = "\(HTTPHelper.API_AUTH_NAME):\(HTTPHelper.API_AUTH_PASSWORD)"
//            let utf8str = basicAuthString.dataUsingEncoding(NSUTF8StringEncoding)
//            let base64EncodedString = utf8str?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(0))
//
//            request.addValue("Basic \(base64EncodedString!)", forHTTPHeaderField: "Authorization")
//        case .HTTPTokenAuth:
//            // Retreieve Auth_Token from Keychain
//            if let userToken = KeychainAccess.passwordForAccount("Auth_Token", service: "KeyChainService") as String? {
//                // Set Authorization header
//                request.addValue("Token token=\(userToken)", forHTTPHeaderField: "Authorization")
//            }
//        }
//
//        return request
//    }
//
//}
