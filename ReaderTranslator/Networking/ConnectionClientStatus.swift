//
//  ConnectionClientStatus.swift
//  ReaderTranslatorPlayer
//
//  Created by Viktor Kushnerov on 13/12/19.
//  Copyright © 2019 Viktor Kushnerov. All rights reserved.
//

import Network

enum ConnectionClientStatus {
    case none
    case ready
    case preparing
    case connected
    case cancelled
    case failed(error: String)

    var status: String {
        switch self {
        case .none:
            return ""
        case .ready:
            return "ready"
        case .preparing:
            return "preparing"
        case .connected:
            return "connected"
        case .cancelled:
            return "cancelled"
        case .failed(let error):
            return error
        }
    }
}