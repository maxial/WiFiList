//
//  WiFiView.swift
//  WiFiResearch
//
//  Created by Maxim Aliev on 13.10.2022.
//

import SwiftUI

struct WiFiView: View {
    
    let network: NetworkInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Interface = \(network.interfaceName)")
            Text("SSID = \(network.ssid ?? "–")")
            Text("BSSID (MAC WiFi) = \(network.bssid ?? "–")")
            Text("RSSI = \(network.strength?.description ?? "–") dbm")
            Text("IpAddress = \(network.ipAddress ?? "–")")
        }
    }
}
