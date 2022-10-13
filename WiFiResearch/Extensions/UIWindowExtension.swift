//
//  UIWindowExtension.swift
//  WiFiResearch
//
//  Created by Maxim Aliev on 13.10.2022.
//

import SwiftUI

extension UIWindow {
    
    static var safeAreaInsets: EdgeInsets {
        let insets = UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets()
        return EdgeInsets(top: insets.top, leading: insets.left, bottom: insets.bottom, trailing: insets.right)
    }
}
