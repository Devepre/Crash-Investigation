//
//  SceneDelegate.swift
//  Crash Investigation
//
//  Created by Serhii Kyrylenko on 14.12.2019.
//  Copyright © 2019 Serhii Kyrylenko. All rights reserved.
//

import UIKit
import SwiftUI
import ArcGIS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    let clientID = "xHx4Nj7q1g19Wh6P"
    let oAuthRedirectURLString = "iOSSamples://auth"
    let itemID = "acc027394bc84c2fb04d1ed317aac674"
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let portal = AGSPortal.arcGISOnline(withLoginRequired: true)
        let portalWrapper = PortalWrapper(portal: portal)
        
        setupOAuth(for: portalWrapper, with: clientID, and: oAuthRedirectURLString)
        
        // Inject portal into SwitUI view hierarchy
        let contentView = ContentView(itemID: itemID)
            .environmentObject(portalWrapper)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
}

// MARK: - AGSAuthenticationManagerDelegate

extension SceneDelegate: AGSAuthenticationManagerDelegate {
    
    func authenticationManager(_ authenticationManager: AGSAuthenticationManager,
                               didReceive challenge: AGSAuthenticationChallenge) {
        challenge.continueWithDefaultHandling()
    }
}

// MARK: - oAuth configuration

extension SceneDelegate {
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        if let url = URLContexts.first?.url {
            if url.absoluteString.range(of: "auth", options: [], range: nil, locale: nil) != nil {
                
                let options = convertFirstOf(URLContexts)
                AGSApplicationDelegate.shared().application(
                    UIApplication.shared,
                    open: url,
                    options: options
                )
            }
        }
    }
    
    private func setupOAuth(for portalWrapper: PortalWrapper, with clientID: String, and oAuthRedirectURLString: String) {
        // Setting OAuth info
        let oAuthConfiguration = AGSOAuthConfiguration(
            portalURL: portalWrapper.portal.url,
            clientID: clientID,
            redirectURL: oAuthRedirectURLString
        )
        
        AGSAuthenticationManager.shared().delegate = self
        AGSAuthenticationManager.shared().oAuthConfigurations.add(oAuthConfiguration)
        AGSAuthenticationManager.shared().credentialCache
            .enableAutoSyncToKeychain(
                withIdentifier: "com.development.Crash-Investigation",
                accessGroup: nil,
                acrossDevices: false
        )
    }
    
    /// Converts URL to open info for the UIKit representation consuming
    private func convertFirstOf(_ URLContexts: Set<UIOpenURLContext>) -> [UIApplication.OpenURLOptionsKey: Any] {
        
        var options: [UIApplication.OpenURLOptionsKey: Any] = [:]
        
        if let inputOptions = URLContexts.first?.options {
            options[.openInPlace] = inputOptions.openInPlace
            
            if let sourceApplication = inputOptions.sourceApplication {
                options[.sourceApplication] = sourceApplication
            }
            if let annotation = inputOptions.annotation {
                options[.annotation] = annotation // Type casting undefined
            }
        }
        
        return options
    }
}
