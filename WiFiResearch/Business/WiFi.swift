//
//  WiFi.swift
//  WiFiResearch
//
//  Created by Maxim Aliev on 13.10.2022.
//

import UIKit
import SystemConfiguration.CaptiveNetwork

func getSSID(interfaceName: String) -> String? {
    guard let info = CNCopyCurrentNetworkInfo(interfaceName as CFString) as NSDictionary? else {
        return nil
    }
    return info[kCNNetworkInfoKeySSID as String] as? String
}

func getBSSID(interfaceName: String) -> String? {
    guard let info = CNCopyCurrentNetworkInfo(interfaceName as CFString) as NSDictionary? else {
        return nil
    }
    return  info[kCNNetworkInfoKeyBSSID as String] as? String
}

func getStrengthInDBM() -> Int? {
    guard
        let statusBarManager = UIApplication.shared.keyWindow?.windowScene?.statusBarManager,
        statusBarManager.responds(to: Selector(("createLocalStatusBar"))),
        let localStatusBar = statusBarManager.perform(Selector(("createLocalStatusBar")))
            .takeUnretainedValue() as? UIView,
        localStatusBar.responds(to: Selector(("statusBar"))),
        let statusBar = localStatusBar.perform(Selector(("statusBar")))
            .takeUnretainedValue() as? UIView,
        let value = (((statusBar.value(forKey: "_statusBar") as? NSObject)?
            .value(forKey: "_currentAggregatedData") as? NSObject)?
            .value(forKey: "_wifiEntry") as? NSObject)?
            .value(forKey: "_rawValue")
    else {
        return nil
    }
    
    return value as? Int
}

func getWiFiAddress() -> String? {
    var address: String?
    var ifaddr: UnsafeMutablePointer<ifaddrs>?
    
    guard getifaddrs(&ifaddr) == 0, let firstAddr = ifaddr else {
        return nil
    }
    
    for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
        let interface = ifptr.pointee
        let addrFamily = interface.ifa_addr.pointee.sa_family
        
        if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
            let name = String(cString: interface.ifa_name)
            if  name == "en0" { // en0 – WiFi interface
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                getnameinfo(
                    interface.ifa_addr,
                    socklen_t(interface.ifa_addr.pointee.sa_len),
                    &hostname,
                    socklen_t(hostname.count),
                    nil,
                    socklen_t(0),
                    NI_NUMERICHOST
                )
                address = String(cString: hostname)
            }
        }
    }
    freeifaddrs(ifaddr)
    
    return address
}
