//
//  ViewController2.swift
//  phw11-1-iosSdkController
//
//  Created by jasonhung on 2023/12/24.
//

import UIKit

class ViewController2: UIViewController {
    var callbackDelegate: CallbackProtocal?
    
    // 創建一個回傳資料按鈕
    let returnStringDelegateButton = UIButton(type: .system)
    
    //添加一個用於保存異步回調的屬性
    // typealias CompletionHandler = (String) -> Void
    // var completionHandler: CompletionHandler?
    var callbackHandler: (String) -> Void = { _ in }
    let textField = UITextField()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設置背景顏色為其他顏色
        view.backgroundColor = UIColor.green
        
        // 創建一個關閉按鈕
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("關閉", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.frame = CGRectMake(self.view.frame.maxX-100, 100, 80, 30);
        
        // 創建一個 Label
        let label = UILabel()
        label.text = "Hello!"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: closeButton.frame.maxY + 20, width: view.bounds.width, height: 30)
        
        // 創建一個 Label
        textField.text = ""
        textField.backgroundColor = UIColor.white
        textField.frame = CGRect(x:80, y: label.frame.maxY + 20, width: view.bounds.width-160, height: 30)
        
        // 將按鈕和 Label 添加到模態視圖控制器的視圖
        view.addSubview(closeButton)
        view.addSubview(label)
        view.addSubview(textField)
        
        // 創建一個回傳資料按鈕
        returnStringDelegateButton.setTitle("回傳資料", for: .normal)
        returnStringDelegateButton.addTarget(self, action: #selector(returnStringButtonTapped), for: .touchUpInside)
        returnStringDelegateButton.frame = CGRectMake(self.view.frame.maxX-100, textField.frame.maxY + 20, 80, 30);
        
        view.addSubview(returnStringDelegateButton)

    }
    
    // 關閉按鈕的點擊事件
    @objc func closeButtonTapped() {
        callbackHandler(textField.text!)
        dismiss(animated: true, completion: nil)
    }
    
    // 回傳資料按鈕的點擊事件
    @objc func returnStringButtonTapped() {
        // 使用可選鏈接和可選綁定確保 callbackDelegate 是有值的
        if let delegate = callbackDelegate {
            delegate.callbackString(String: textField.text!)
        } else {
            print("callbackDelegate is nil")
        }

        dismiss(animated: true, completion: nil)
    }
}
