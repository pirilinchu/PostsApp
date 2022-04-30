//
//  ReachabilityManager.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 29/4/22.
//

import Foundation
import Reachability

protocol ReachabilityProviding {
    var isNetworkReachable: Bool { get }
}

class ReachabilityManager: ReachabilityProviding {

    static let shared = ReachabilityManager()

    var isNetworkReachable: Bool { reachability.map { $0.connection != .unavailable } ?? true }

    private let reachability = try? Reachability()

    private init() {
        try? reachability?.startNotifier()
    }
}
