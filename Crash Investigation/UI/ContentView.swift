//
//  ContentView.swift
//  Crash Investigation
//
//  Created by Serhii Kyrylenko on 14.12.2019.
//  Copyright © 2019 Serhii Kyrylenko. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let itemID: String
    
    var body: some View {
        VStack {
            MapView(portalItemID: itemID)
            FeatureListView(portalItemID: itemID)
        }
    }
}
