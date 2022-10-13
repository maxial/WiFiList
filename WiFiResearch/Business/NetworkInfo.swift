//
//  NetworkInfo.swift
//  WiFiResearch
//
//  Created by Maxim Aliev on 13.10.2022.
//

import Foundation
import SystemConfiguration.CaptiveNetwork

struct NetworkInfo: Hashable {
    
    let interfaceName: String
    var ssid: String?
    var bssid: String?
    var strength: Int?
    var ipAddress: String?
    
    init(interfaceName: String) {
        self.interfaceName = interfaceName
        self.ssid = getSSID(interfaceName: interfaceName)
        self.bssid = getBSSID(interfaceName: interfaceName)
        self.strength = getStrengthInDBM()
        self.ipAddress = getWiFiAddress()
    }
}

func fetchNetworks() -> [NetworkInfo] {
    guard let interfaces: NSArray = CNCopySupportedInterfaces() else {
        return []
    }
    
    return interfaces.map { NetworkInfo(interfaceName: $0 as? String ?? "–") }
}
