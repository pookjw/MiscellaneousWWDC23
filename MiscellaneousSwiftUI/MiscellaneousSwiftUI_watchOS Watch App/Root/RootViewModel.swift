//
//  RootViewModel.swift
//  MiscellaneousSwiftUI_watchOS Watch App
//
//  Created by Jinwoo Kim on 8/18/23.
//

import SwiftUI
import Observation
import OSLog

@Observable
final class RootViewModel {
    private static var url: URL {
        .documentsDirectory
        .appending(component: "pathData")
    }
    
    private static var pathData: Data? {
        get throws {
            try .init(contentsOf: url)
        }
    }
    
    private static func save(pathData: Data) throws {
        try pathData.write(to: url, options: .atomic)
    }
    
    var path: NavigationPath
    
    init() {
        do {
            if let pathData: Data = try Self.pathData {
                let representation: NavigationPath.CodableRepresentation = try JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: pathData)
                
                path = NavigationPath(representation)
            } else {
                path = .init()
            }
        } catch {
            Logger().error("\(error)")
            path = .init()
        }
    }
    
    func save() throws {
        guard let representation: NavigationPath.CodableRepresentation = path.codable else {
            return
        }
        
        let data: Data = try JSONEncoder().encode(representation)
        try Self.save(pathData: data)
    }
}
