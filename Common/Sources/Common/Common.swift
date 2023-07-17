import Foundation
import UniformTypeIdentifiers

@objc
public actor Common: NSObject {
    @objc public static nonisolated var containerURL: URL {
        FileManager
            .default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.com.pookjw.MiscellaneousExtensionKit")!
            .appendingPathComponent("default", conformingTo: .init(filenameExtension: "sqlite", conformingTo: .data)!)
    }
    
    private override init() {
        super.init()
    }
}

@objc public protocol PublisherServiceProtocol: NSObjectProtocol {
    func transform(_ input: String) async -> String
}

public let sceneID: String = "scene"
