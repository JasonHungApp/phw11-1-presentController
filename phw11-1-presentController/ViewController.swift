//
//  ViewController.swift
//  phw11-1-iosSdkController
//
//  Created by jasonhung on 2023/12/24.
//

import UIKit

@objc protocol CallbackProtocal{
    @objc func callbackString(String:String)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var vc2SayLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func present01(_ sender: UIButton) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.green
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func persent02_fullScreen(_ sender: Any) {
        let viewController2 = ViewController2()
        viewController2.modalPresentationStyle = .fullScreen
        viewController2.modalTransitionStyle = .coverVertical
        present(viewController2, animated: true, completion: {
            viewController2.textField.isHidden = true
            viewController2.returnStringDelegateButton.isHidden = true
        })
    }
    
    
    @IBAction func otherSetting(_ sender: UIButton) {
        let setting = 5
        let viewController2 = ViewController2()
        
        switch setting{
        case 0:
            viewController2.modalPresentationStyle = .formSheet
            viewController2.modalTransitionStyle = .coverVertical
        case 1:
            viewController2.modalPresentationStyle = .formSheet
            viewController2.modalTransitionStyle = .flipHorizontal
        case 2:
            viewController2.modalPresentationStyle = .fullScreen
            viewController2.view.alpha = 0.8
            //viewController2.modalTransitionStyle = .crossDissolve
        case 3:
            viewController2.modalPresentationStyle = .overFullScreen
            viewController2.view.alpha = 0.8
            //viewController2.modalTransitionStyle = .crossDissolve
        case 4:
            //viewController2.modalPresentationStyle = .overCurrentContext
            viewController2.view.alpha = 0.5
            viewController2.modalTransitionStyle = .crossDissolve
            
        case 5:
            //viewController2.modalPresentationStyle = .overCurrentContext
            viewController2.view.alpha = 0.5
            viewController2.modalTransitionStyle = .flipHorizontal
            
        default:
            break
        }
        present(viewController2, animated: true, completion: {
            viewController2.textField.isHidden = true
            viewController2.returnStringDelegateButton.isHidden = true
        })    }
    
    @IBAction func present03_CustomPresentAnimation(_ sender: Any) {
        let viewController2 = ViewController2()
        viewController2.transitioningDelegate = self
        viewController2.modalPresentationStyle = .custom
        
        present(viewController2, animated: true, completion: {
            viewController2.textField.isHidden = true
            viewController2.returnStringDelegateButton.isHidden = true
        })
    }
    
    @IBAction func testCompletion(_ sender: Any) {
        let viewController2 = ViewController2()
        present(viewController2, animated: true, completion: {
            viewController2.textField.text = "輸入你的名字！"
            viewController2.returnStringDelegateButton.isHidden = true

            
        })
        
    }
    
    @IBAction func testCallbackHandler(_ sender: Any) {
        
        let viewController2 = ViewController2()
        
        // 設定異步回調的 closure
        viewController2.callbackHandler = { enteredText in
            // 在這裡處理回傳的內容
            print("Entered text from ViewController2: \(enteredText)")
            self.vc2SayLabel.text = enteredText
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                let resultAlert = UIAlertController(title: "回傳的資料", message: enteredText, preferredStyle: .alert)
                let okResultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                resultAlert.addAction(okResultAction)
                self.present(resultAlert, animated: true, completion: nil)
            }
        }
        
        present(viewController2, animated: true, completion: {
            viewController2.returnStringDelegateButton.isHidden = true
            viewController2.textField.text = "輸入你的名字！"
        })
        
        
    }
    
    @IBAction func testCallbackProtocal(_ sender: Any) {
        let viewController2 = ViewController2()
        viewController2.callbackDelegate = self
        
        present(viewController2, animated: true, completion: {
            viewController2.textField.text = "Delegate test！"
        })
    }
    
    
}




class CustomPresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        
        toVC.view.alpha = 0.0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toVC.view.alpha = 1.0
        }) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil // 如果需要自定義dismiss轉場，同樣實現相關代理方法
    }
}


extension ViewController: CallbackProtocal{
    func callbackString(String: String) {
        vc2SayLabel.text = String
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let resultAlert = UIAlertController(title: "回傳的資料", message: String, preferredStyle: .alert)
            let okResultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            resultAlert.addAction(okResultAction)
            self.present(resultAlert, animated: true, completion: nil)
        }
    }
    
}
