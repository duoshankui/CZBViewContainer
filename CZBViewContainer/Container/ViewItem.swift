//
//  ViewItem.swift
//  CZBViewContainer
//
//  Created by DoubleK on 2021/5/26.
//

import Foundation

/**
 如果使用系统Codable协议解析JSON,
 可能出现的属性必须设置为可选类型，不能给默认值，否则会解析失败
 */

enum PluginType: String, Codable {
    case banner = "banner"
    case image = "image"
}

struct ContainerItem: Codable {
    var w: Float = 0
    var ele: [ViewItem]?
}

struct ViewItem: Codable {
    var pt: PluginType = .image
    var t: Float = 0
    var l: Float = 0
    var w: Float = 0
    var h: Float = 0
    /// 边框圆角
    var sb: Border?
    var pp: Props?
    var data: UnknownModel?
}

struct Border: Codable {
    var lt: Float?
    var lb: Float?
    var rt: Float?
    var rb: Float?
}

struct Props: Codable {
    /// banner 轮播时间 单位ms
    var tm: Int?
    /// 填充模式
    var ft: String?
}

struct ImgItem: Codable {
    var src: String?
    var au: String?
    
    init(dict: [String: Any]?) {
        self.src = dict?["src"] as? String
        self.au = dict?["au"] as? String
    }
}

///不确定数据类型解析
struct UnknownModel: Codable {
    var imgItem: ImgItem?
    var banners: [ImgItem]?
    
    init(from decoder: Decoder) throws {
        let single = try decoder.singleValueContainer()
        if let data = try? single.decode(ImgItem.self)  {
            imgItem = data
        } else if let data = try? single.decode([ImgItem].self) {
            banners = data
        }
    }
}
