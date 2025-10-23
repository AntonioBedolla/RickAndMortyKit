//
//  File.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import Foundation


public final class DependencyContainer {
   public static let shared = DependencyContainer()

   public var mockService: APIServiceProtocol = MockAPIService()
   public var apiService: APIServiceProtocol = APIService()
    
    public init() {}
}
