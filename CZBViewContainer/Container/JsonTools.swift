//
//  JsonTools.swift
//  CZBViewContainer
//
//  Created by DoubleK on 2021/5/26.
//

import Foundation

class JsonTools {
    static let shared = JsonTools()
    public init() { }
    
    func readLocalJson(fileName name: String) -> ContainerItem? {
        
        let finalPath = Bundle.main.bundlePath + "/\(name)"
        if !FileManager.default.fileExists(atPath: finalPath) {
            return nil
        }
        
        guard let jsonData = NSData(contentsOfFile: finalPath) else {
            return nil
        }
        
        guard let json = String(data: jsonData as Data, encoding: .utf8) else {
            return nil
        }
        
        if let model = ContainerItem.deserialize(from: json) {
            return model
        }
        
        return nil
    }
}
