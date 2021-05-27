//
//  ViewController.swift
//  CZBViewContainer
//
//  Created by DoubleK on 2021/5/26.
//

import UIKit
import CZBCycleView
import SnapKit

class ViewController: UIViewController, ContainerViewProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let model = JsonTools.shared.readLocalJson(fileName: "local.json")
//        let tempView = ContainerView(with: model!)
        let tempView = ContainerView(frame: .zero)
        tempView.setModel(model)
        tempView.backgroundColor = .gray
        tempView.delegate = self
        view.addSubview(tempView)
        
        tempView.snp.makeConstraints({
            $0.top.equalTo(100)
            $0.left.equalTo(0)
            $0.width.equalTo(tempView.viewWidth)
            $0.height.equalTo(tempView.viewHeight)
        })
        
        let testBtn = UIButton(frame: .zero)
        testBtn.backgroundColor = .red
        view.addSubview(testBtn)
        testBtn.snp.makeConstraints({
            $0.left.equalTo(100)
            $0.top.equalTo(tempView.snp.bottom).offset(50)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        })
    }
        
    func imgViewDidClick(_ imgView: UIImageView, actionUrl: String?) {
        print("跳转 --\(actionUrl ?? "")")
    }
    
    func cycleViewDidClick(_ cycleView: ZCycleView, actionUrl: String?) {
        print("跳转 --\(actionUrl ?? "")")
    }
}

extension ViewController {
    
}
