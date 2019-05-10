//
//  NetworkManager.swift
//  MVVM
//
//  Created by liubomyr.drevych on 5/10/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation
import CoreLocation

enum NetworkHTTPMethod : String { case get, post, put, patch, delete }

enum NetworkError {
    case wrongURL
    case parseJSON
    case serializationError
    case generalFailure
    case requestFailed(statusCode: Int)
}

enum Result {
    case success(data: SunriseSunset)
    case failude(error: NetworkError)
}

final class NetworkManager {
    
    private let session: URLSession
    
    init(timeout: TimeInterval = 60.seconds) {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = timeout
        sessionConfig.timeoutIntervalForResource = timeout
        session = URLSession(configuration: sessionConfig)
    }
    
    public func getSunsetSunriseData(latitude: CLLocationDegrees, longitute: CLLocationDegrees,complitionHandler: @escaping (Result) -> Void, delay: TimeInterval?) {
        guard let url = getSunsetSunriseURL(long: "\(longitute)", lat: "\(latitude)") else {
            complitionHandler(.failude(error: .wrongURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = NetworkHTTPMethod.get.rawValue
        let task = session.dataTask(with: urlRequest) { (data, urlResponse, erorr) in
            guard let response = urlResponse as? HTTPURLResponse else {
                complitionHandler(.failude(error: .generalFailure))
                return
            }
            switch response.statusCode {
            case 200...201:
                let decoder = JSONDecoder()
                guard let responseData = data else {
                    complitionHandler(.failude(error: .serializationError))
                    return
                }
                guard let model = try? decoder.decode(SunriseSunset.self, from: responseData) else {
                    complitionHandler(.failude(error: .parseJSON))
                    return
                }
                complitionHandler(.success(data: model))
            default:
                complitionHandler(.failude(error: .requestFailed(statusCode: response.statusCode)))
            }
        }
        guard let delay = delay else {
            task.resume()
            return
        }
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + delay) {
            task.resume()
        }
        
    }
    
    //MARK: Private
    private func getSunsetSunriseURL(long: String, lat: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.sunsetSunriseSchema
        urlComponents.host = Constants.sunsetSunriseHost
        urlComponents.path = Constants.sunsetSunrisePath
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.latitude, value: lat),
            URLQueryItem(name: Constants.longitute, value: long),
            URLQueryItem(name: Constants.date, value: Constants.dateValue)
        ]
        return urlComponents.url
    }
}

extension Int {
    public var seconds: TimeInterval  { return Double(self) }
}
