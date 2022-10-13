//
//  ContentView.swift
//  WiFiResearch
//
//  Created by Maxim Aliev on 13.10.2022.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            switch appState.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                List {
                    ForEach(fetchNetworks(), id: \.self) { network in
                        WiFiView(network: network)
                            .environmentObject(appState)
                    }
                }
                .listStyle(.grouped)
                .refreshable { }
            default:
                Text("Location access required")
            }
        }
        .onAppear {
            appState.requestAuthorisationIfNeeded()
            appState.connectToWiFi()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
