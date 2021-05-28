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
    var pp: Props?
    var data: Any?
}

struct Border: HandyJSON {
    var lt: Float = 0
    var lb: Float = 0
    var rt: Float = 0
    var rb: Float = 0
}

struct Props: HandyJSON {
    /// banner 轮播时间 单位ms
    var tm: Int?
    /// 填充模式
    var ft: String?
}

struct ImgItem {
    var src: String?
    var au: String?
    
    init(dict: [String: Any]?) {
        self.src = dict?["src"] as? String
        self.au = dict?["au"] as? String
    }
}
