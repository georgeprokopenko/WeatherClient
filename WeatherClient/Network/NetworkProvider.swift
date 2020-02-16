//
//  NetworkProvider.swift
//  WeatherClient
//
//  Created by Georgii Prokopenko on 2/16/20.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation
import Alamofire
import Moya

final class NetworkProvider<T>: MoyaProvider<T> where T: TargetType {
    override init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
                  requestClosure: @escaping RequestClosure = MoyaProvider<T>.defaultRequestMapping,
                  stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
                  callbackQueue: DispatchQueue? = nil,
                  manager: Manager = DefaultAlamofireManager.managerWithTimeout,
                  plugins: [PluginType] = [],
                  trackInflights: Bool = false) {

        super.init(endpointClosure: endpointClosure,
                   requestClosure: requestClosure,
                   stubClosure: stubClosure,
                   callbackQueue: callbackQueue,
                   manager: manager,
                   plugins: [NetworkLoggerPlugin(), CachePlugin()],
            trackInflights: trackInflights)
    }

    @discardableResult
    func request<T>(
        _ target: Target,
        responseType: T.Type,
        completion: @escaping WCAPIResponseBlock<T>
    ) -> Cancellable where T: Codable {
        return super.request(target) { result in
            switch result {
            case .success(let response):
                let container = try!
                    JSONDecoder().decode(T.self,
                                         from: response.data)
                    completion(container, nil)
//                } else {
//                    completion(nil, .parsingError)
//                }
            case .failure:
                completion(nil, .serverError)
            }
        }
    }
}
