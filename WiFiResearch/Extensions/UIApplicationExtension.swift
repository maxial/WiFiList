//
//  UIApplicationExtension.swift
//  WiFiResearch
//
//  Created by Maxim Aliev on 13.10.2022.
//

import UIKit

extension UIApplication {
    
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
}
