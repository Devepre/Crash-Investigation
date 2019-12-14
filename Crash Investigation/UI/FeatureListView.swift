//
//  FeatureListView.swift
//  Crash Investigation
//
//  Created by Serhii Kyrylenko on 14.12.2019.
//  Copyright © 2019 Serhii Kyrylenko. All rights reserved.
//

import SwiftUI
import ArcGIS

struct FeatureListView: View {
    
    @EnvironmentObject var portalWrapper: PortalWrapper
    @State private var mapLayers: [LayerContainer] = [LayerContainer]()
    @State private var operationalLayers = [AGSLayer]()
    
    public var portalItemID: String {
        didSet {
            getOperationLayers()
        }
    }
    
    var body: some View {
        NavigationView {
            List(operationalLayers, id: \.name) { layer in
                Text(layer.name)
            }
            .navigationBarTitle(Text("Feature List"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            self.getOperationLayers()
        }
    }
    
}

// MARK: - Private

extension FeatureListView {
    
    private func getOperationLayers() {
        
        let portalItem = AGSPortalItem(portal: portalWrapper.portal, itemID: portalItemID)
        let map = AGSMap(item: portalItem)
        
        map.load { (error) in
            if let error = error {
                print(error)
                return
            }
            
            self.operationalLayers = map.operationalLayers
                .compactMap { $0 as? AGSLayer }
            
            for layer in self.operationalLayers {
                self.mapLayers.append( LayerContainer(object: layer))
            }
        }
    }
}
