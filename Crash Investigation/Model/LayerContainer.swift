//
//  Container.swift
//  Crash Investigation
//
//  Created by Serhii Kyrylenko on 14.12.2019.
//  Copyright © 2019 Serhii Kyrylenko. All rights reserved.
//

import Foundation
import ArcGIS

struct LayerContainer: Identifiable {
    
    let id = UUID()
    let object: AGSLayer
}
