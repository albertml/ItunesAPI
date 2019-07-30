//
//  HomeViewController.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import UIKit
import Moya
import Alamofire

// MARK: - Provider setup

let serviceURL: String = {
    return "itunes.apple.com"
}()

let manager: Manager = {
    
    let serverTrustPolicies: [String: ServerTrustPolicy] = [
        serviceURL: .disableEvaluation
    ]
    
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 240
    configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
    
    return Manager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
}()

let endpointClosure = { (target: Itunes) -> Endpoint in
    let endpoint: Endpoint = Endpoint(url: url(target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
    
    return endpoint
}

var ItunesProvider: MoyaProvider<Itunes> = {
    let networkLogger = NetworkLoggerPlugin(verbose: true, responseDataFormatter: nil)
    return MoyaProvider<Itunes>(endpointClosure: endpointClosure,
                                manager: manager,
                                plugins:[networkLogger])
}()


private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

// MARK: - Provider support

extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum Itunes {
    case searctItem(String)
}

extension Itunes: TargetType {
    public var baseURL: URL {
        return URL(string: "https://" + serviceURL)!
    }
    public var path: String {
        switch self {
        case .searctItem(let item):
            return "/search?term=\(item)&country=au&media=movie&all"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String: Any]? {
        return  nil
    }
    
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString.removingPercentEncoding!
}
