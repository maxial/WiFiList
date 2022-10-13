//
//  AppState.swift
//  WiFiResearch
//
//  Created by Maxim Aliev on 13.10.2022.
//

import Foundation
import CoreLocation
import NetworkExtension

class AppState: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var wifiConnectionStatus: Bool
    
    override init() {
        authorizationStatus = locationManager.authorizationStatus
        wifiConnectionStatus = false
        super.init()
        locationManager.delegate = self
    }
    
    func requestAuthorisationIfNeeded() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func connectToWiFi() {
        let configuration = NEHotspotConfiguration(ssid: "<ИМЯ СЕТИ>", passphrase: "<ПАРОЛЬ>", isWEP: false)
        configuration.joinOnce = true
        NEHotspotConfigurationManager.shared.apply(configuration) { [weak self] error in
            self?.wifiConnectionStatus = error == nil
        }
    }
}

extension AppState: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
    }
}
