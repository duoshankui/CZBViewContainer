//
//  ViewController.swift
//  CZBViewContainer
//
//  Created by DoubleK on 2021/5/26.
//

import UIKit
import CZBCycleView
import SnapKit
import SwiftyJSON

public let ServerUrl = "https://appdynamiccontainer.oss-cn-beijing.aliyuncs.com/test.autolayout/config.json"

class ViewController: UIViewController {
    
//    var txtLabel =
    lazy var txtLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 400, width: 300, height: 50))
        label.textAlignment = .center
        label.backgroundColor = .gray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        loadLocalFile()
        loadNetWorkData()
        
        view.addSubview(txtLabel)
    }
    
    func loadLocalFile() {
        let model = JsonTools.shared.readLocalJson(fileName: "local1.json")
        handleRequestData(model: model!)
    }
    
    func loadNetWorkData() {
        let url = URL(string: ServerUrl)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("request fail")
                return
            }
            
            if let json = try? JSON(data: data!) {
                let model = ContainerItem(json: json)
                DispatchQueue.main.async {
                    self.handleRequestData(model: model)
                }
            }
        }
        task.resume()
    }
    
    func handleRequestData(model: ContainerItem) {
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
    }
}

extension ViewController: ContainerViewProtocol {
    func imgViewDidClick(_ imgView: UIImageView, actionUrl: String?) {
        print("跳转 --\(actionUrl ?? "")")
        txtLabel.text = actionUrl
    }
    
    func cycleViewDidClick(_ cycleView: ZCycleView, actionUrl: String?) {
        print("跳转 --\(actionUrl ?? "")")
        txtLabel.text = actionUrl
    }
}
