//
//  PortalWrapper.swift
//  Crash Investigation
//
//  Created by Serhii Kyrylenko on 14.12.2019.
//  Copyright © 2019 Serhii Kyrylenko. All rights reserved.
//

import Foundation
import Combine
import ArcGIS

/// PortalWrapper enables to inject AGSPortal into SwiftUI Views as Environment object
public class PortalWrapper: ObservableObject {
    
    @Published public var portal: AGSPortal
    
    init(portal: AGSPortal) {
        self.portal = portal
    }
    
    public func load() {
        
        portal.load { error in
            
            guard error == nil else {
                print("Something went wrong...")
                return
            }
        }
    }
}

