//
//  JsonTools.swift
//  CZBViewContainer
//
//  Created by DoubleK on 2021/5/26.
//

import Foundation
import SwiftyJSON

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
        
        guard let js = try? JSON(data: jsonData as Data) else {
            return nil
        }
        
        return ContainerItem(json: js)
    }
}
