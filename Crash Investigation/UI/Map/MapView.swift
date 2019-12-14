//
//  MapView.swift
//  Crash Investigation
//
//  Created by Serhii Kyrylenko on 14.12.2019.
//  Copyright © 2019 Serhii Kyrylenko. All rights reserved.
//

import SwiftUI

struct MapView: UIViewControllerRepresentable {
    
    @EnvironmentObject var portalWrapper: PortalWrapper
    
    public let portalItemID: String
    
    typealias UIViewControllerType = MapViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MapView>) -> MapView.UIViewControllerType {
        
        let vc = MapViewController(portal: portalWrapper.portal, portalItemID: portalItemID)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MapView.UIViewControllerType, context: UIViewControllerRepresentableContext<MapView>) {
        
        //
    }
}
