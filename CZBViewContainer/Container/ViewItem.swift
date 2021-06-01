//
//  ViewItem.swift
//  CZBViewContainer
//
//  Created by DoubleK on 2021/5/26.
//

import Foundation
import HandyJSON
import SwiftyJSON

/// 另一种写法, 等同于PluginType
//enum TestType {
//    case banner
//    case image
//
//    init?(key: String) {
//        switch key {
//        case "banner": self = .banner
//        case "image": self = .image
//        default: return nil
//        }
//    }
//}

enum PluginType: String {
    case banner = "banner"
    case image = "image"
}

struct ContainerItem {
    var w: Float = 0
    var ele: [ViewItem]?
    
    init(json: JSON) {
        guard json.type != .null else {
            return
        }
        w = json["w"].floatValue
        ele = json["ele"].arrayValue.compactMap({
            ViewItem(json: $0)
        })
    }
}

struct ViewItem {
//    var pt: TestType = .image
    var pt: PluginType = .image
    var t: Float = 0
    var l: Float = 0
    var w: Float = 0
    var h: Float = 0
    /// 边框圆角
    var sb: Border?
    var pp: Props?
    var data: Any?
    
    init(json: JSON) {
        guard json.type != .null else {
            return
        }
//        pt = TestType(key: json["pt"].stringValue) ?? . image
        pt = PluginType(rawValue: json["pt"].stringValue) ?? .image
        t = json["t"].floatValue
        l = json["l"].floatValue
        w = json["w"].floatValue
        h = json["h"].floatValue
        sb = Border(json: json["sb"])
        pp = Props(json: json["pp"])
        if pt == .image {
            data = ImgItem(json: json["data"])
        } else {
            data = json["data"].arrayValue.compactMap({
                ImgItem(json: $0)
            })
        }
    }
}

struct Border {
    var lt: Float = 0
    var lb: Float = 0
    var rt: Float = 0
    var rb: Float = 0
    
    init(json: JSON) {
        guard json.type != .null else { return }
        lt = json["lt"].floatValue
        lb = json["lb"].floatValue
        rt = json["rt"].floatValue
        rb = json["rb"].floatValue
    }
}

struct Props {
    /// banner 轮播时间 单位ms
    var tm: Int?
    /// 填充模式
    var ft: String?
    init(json: JSON) {
        guard json.type != .null else { return }
        tm = json["tm"].intValue
        ft = json["ft"].stringValue
    }
}

struct ImgItem {
    var src: String?
    var au: String?
    
    init(json: JSON) {
        guard json.type != .null else {
            return
        }
        src = json["src"].stringValue
        au = json["au"].stringValue
    }
    
    init(dict: [String: Any]?) {
        self.src = dict?["src"] as? String
        self.au = dict?["au"] as? String
    }
}
