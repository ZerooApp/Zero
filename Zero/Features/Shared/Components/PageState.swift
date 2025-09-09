//
//  PagrState.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import Foundation

enum PageState<T: Hashable>: Hashable {
    case initial
    case loading
    case dataLoaded(data: T)
    case retryView(error: AppError)
    
    var data: T? {
        switch self {
        case .dataLoaded(let data):
            return data
        default:
            return nil
        }
    }
}

struct AppError: Hashable, Error {
    let message: String
    let isNoInternet: Bool
    
    init(message: String, isNoInternet: Bool) {
        self.message = message
        self.isNoInternet = isNoInternet
    }
}
