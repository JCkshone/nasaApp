//
//  Configuration.swift
//  NasaApp
//
//  Created by Juan Camilo on 12/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import Foundation

enum ConfigurationKey: String {
    case baseUrl = "BASE_URL"
    case publicKey = "PUBLIC_KEY"
}

class Configuration {
    static let shared = Configuration()
    
    struct ConfigurationType {
        static let developtment = "Development"
        static let production = "Production"
    }
    
    let isDevelopment = true
    let configurationPath = "Configurations"
    
    var mode: String {
        return isDevelopment ? ConfigurationType.developtment : ConfigurationType.production
    }
    
    func getValueConfiguration<T> (withType _:T.Type, key: ConfigurationKey) -> T? {
        
        if let configurations = getConfigurations() {
            return configurations.object(forKey: key.rawValue) as? T
        }
        return nil
    }
    
    private func getConfigurations () -> NSDictionary? {
        var bundle = Bundle.main
        if bundle.bundleURL.pathExtension == "app" {
            bundle = (Bundle(url: bundle.bundleURL.deletingLastPathComponent())) ?? bundle
        }
        let envsPListPath = Bundle.main.path(forResource: configurationPath, ofType: "plist")
        guard let data = try? NSData(contentsOfFile: envsPListPath ?? "") as Data else {
            return nil
        }
        
        do {
            if let enviroments = try PropertyListSerialization.propertyList(from: data,
                                                                            options: .mutableContainersAndLeaves,
                                                                            format: nil) as? [String: Any] {
                return enviroments[mode] as? NSDictionary
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}
