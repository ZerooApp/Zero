//
//  ToastState.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import DeveloperToolsSupport

extension ToastMessageView {
    enum State {
        case error
        case success
        
        var backgroundColor: ColorResource {
            switch self {
            case .error:
                return .Black.black10
            case .success:
                return .Black.black10
            }
        }
        
        var textColor: ColorResource {
            switch self {
            case .error:
                return .Black.black10
            case .success:
                return .Black.black10
            }
        }
        
        var icon: ImageResource {
            switch self {
            case .error:
                return .xmarkCircleFill
            case .success:
                return .checkmarkCircleFill
            }
        }
    }
}
