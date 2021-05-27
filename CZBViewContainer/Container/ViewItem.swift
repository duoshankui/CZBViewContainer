//
//  ViewItem.swift
//  CZBViewContainer
//
//  Created by DoubleK on 2021/5/26.
//

import Foundation
import HandyJSON

enum PluginType: String, HandyJSONEnum {
    case banner = "banner"
    case image = "image"
}

struct ContainerItem: HandyJSON {
    var w: Float = 0
    var ele: [ViewItem]?
}

struct ViewItem: HandyJSON {
    var pt: PluginType = .image
    var t: Float = 0
    var l: Float = 0
    var w: Float = 0
    var h: Float = 0
    /// 边框圆角
    var sb: Border?
    /// banner 轮播时间 单位ms
    var tm: Int?
    /// actionUrl
    var au: String?
    var aus: [String]?
}

struct Border: HandyJSON {
    var topLeft: Float = 0
    var topRight: Float = 0
    var bottomLeft: Float = 0
    var bottomRight: Float = 0
}
