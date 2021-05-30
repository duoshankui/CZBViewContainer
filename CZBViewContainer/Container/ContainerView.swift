//
//  ContainerView.swift
//  CZBViewContainer
//
//  Created by DoubleK on 2021/5/26.
//

import UIKit
import CZBCycleView

public let scale = UIScreen.main.bounds.width/375.0

protocol ContainerViewProtocol: AnyObject {
    
    func imgViewDidClick(_ imgView: UIImageView, actionUrl: String?)
    func cycleViewDidClick(_ cycleView: ZCycleView, actionUrl: String?)
}

extension ContainerViewProtocol {
    func imgViewDidClick(_ imgView: UIImageView, actionUrl: String?) {}
    func cycleViewDidClick(_ cycleView: ZCycleView, actionUrl: String?) {}
}

class ContainerView: UIView {
    
    private var imgViewActions = [UIImageView: ImgItem]()
    private var bannerActions = [ZCycleView: [ImgItem?]]()
    
    weak var delegate: ContainerViewProtocol?
    
    private var model: ContainerItem?
    
    /// 容器宽
    public var viewWidth: CGFloat {
        return frame.width
    }
    
    /// 容器高
    public var viewHeight: CGFloat {
        return frame.height
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
//    init(with model: ContainerItem) {
//        self.model = model
//        super.init(frame: .zero)
//        createViews()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: ContainerItem?) {
        self.model = model
        createViews()
    }
    
    func createViews() {
        
        guard let model = model, let elements = model.ele, elements.count > 0 else { return }
        
        let maxH = computedMaxHeight(elements: elements)
        self.frame = CGRect(x: 0, y: 0, width: CGFloat(model.w)*scale, height: maxH*scale)
        
        for element in elements {
            var subView: UIView
            switch element.pt {
            case .banner:
                subView = createBannerView(withElement: element)
            case .image:
                subView = createImgView(withElement: element)
            }
            addSubview(subView)
        }
    }
}

private extension ContainerView {
        
    /// 计算容器的高度
    func computedMaxHeight(elements: [ViewItem]) -> CGFloat {
        var height: Float = 0.0
        height = elements.reduce(into: height) { (h, item) in
            h = h > (item.t + item.h) ? h : (item.t + item.h)
        }
        return CGFloat(height)
    }
    
    @discardableResult
    func createBannerView(withElement element: ViewItem) -> ZCycleView {
        let banners = element.data?.banners
        
        /// 控件frame
        let frame = CGRect(x: scale*CGFloat(element.l), y: scale*CGFloat(element.t), width: scale*CGFloat(element.w), height: scale*CGFloat(element.h))
        let bannerView = ZCycleView(frame: frame)
        bannerView.addCorner(with: element.sb)
        bannerView.delegate = self
        
        let urls = banners?.compactMap({ $0.src })
        bannerView.setUrlsGroup(urls ?? [])
        if let tm = element.pp?.tm {
            let timeInterval = ceil(Double(tm)/1000)
            bannerView.timeInterval = Int(timeInterval)
        }
        bannerActions[bannerView] = banners
        return bannerView
    }
    
    @discardableResult
    func createImgView(withElement element: ViewItem) -> UIImageView {
        let imgItem = element.data?.imgItem
        
        let frame = CGRect(x: scale*CGFloat(element.l), y: scale*CGFloat(element.t), width: scale*CGFloat(element.w), height: scale*CGFloat(element.h))
        let imgView = UIImageView(frame: frame)
        imgView.backgroundColor = UIColor.randomColor
        imgView.addCorner(with: element.sb)
        imgView.contentMode = .scaleToFill
        imgView.kf.setImage(with: URL(string: imgItem?.src ?? ""))
        imgView.addTapGesture(target: self, action: #selector(clickAction(_:)))
        imgViewActions[imgView] = imgItem
        return imgView
    }
    
    @objc func clickAction(_ tap: UITapGestureRecognizer) {
        if let imgView = tap.view as? UIImageView {
            let imgItem = imgViewActions[imgView]
            if delegate != nil {
                delegate?.imgViewDidClick(imgView, actionUrl: imgItem?.au)
            }
        }
    }
}

extension ContainerView: ZCycleViewProtocol {
    func cycleView(_ cycleView: ZCycleView, didSelectIndex index: Int) {
        if let items = bannerActions[cycleView] {
            let imgItem = items[index]
            if delegate != nil {
                delegate?.cycleViewDidClick(cycleView, actionUrl: imgItem?.au)
            }
        }
    }
    
    func cycleViewDidScrollToIndex(_ index: Int) {}
    
    func cycleViewDidSelectedIndex(_ index: Int) {}
}

extension UIView {
    /// 添加圆角
    fileprivate func addCorner(with border: Border?) {
        guard let border = border else { return }
        let topLeft = border.lt
        let topRight = border.rt
        let bottomLeft = border.lb
        let bottomRight = border.rb
        if topLeft > 0 || topRight > 0 || bottomLeft > 0 || bottomRight > 0 {
            let corner = CornerRadii(topLeft: CGFloat(topLeft), topRight: CGFloat(topRight), bottomLeft: CGFloat(bottomLeft), bottomRight: CGFloat(bottomRight))
            addCorner(cornnerRadii: corner)
        }
    }

    /// 添加点击手势
    fileprivate func addTapGesture(target: Any?, action: Selector) {
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(tap)
    }
}
