//
//  MapViewController.swift
//  Crash Investigation
//
//  Created by Serhii Kyrylenko on 14.12.2019.
//  Copyright © 2019 Serhii Kyrylenko. All rights reserved.
//

import UIKit
import ArcGIS
import SwiftUI

class MapViewController: UIViewController {
    
    public let portal: AGSPortal
    public let portalItemID: String
    
    private var mapView: AGSMapView!
    
    init(portal: AGSPortal, portalItemID: String) {
        
        self.portal = portal
        self.portalItemID = portalItemID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        setupMap()
    }
    
    private func setupMap() {
        
        mapView = AGSMapView(frame: .zero)
        mapView.map = makeMap()
        
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let top = mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0)
        let bottom = mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
        let leading = mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0)
        let trailing = mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0)
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }
    
    private func makeMap() -> AGSMap {
        
        let portalItem = AGSPortalItem(portal: portal, itemID: portalItemID)
        let map = AGSMap(item: portalItem)
        map.load { (error) in
            if let error = error {
                print(error)
            }
            
            let operationlaLayers = map.operationalLayers.compactMap { $0 as? AGSFeatureLayer }
            let operationlaLayersNames = operationlaLayers.map { $0.name }
            print(operationlaLayersNames)
        }
        
        return map
    }
}
