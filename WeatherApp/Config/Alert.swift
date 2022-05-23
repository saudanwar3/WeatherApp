//
//  Alert.swift
//  WeatherApp
//
//  Created by Muhammad Saud Anwar on 24/05/2022.
//

import UIKit
import Foundation
import MBProgressHUD

class Alert: NSObject {
    
    static var loadingAlert : MBProgressHUD!
    static var blurEffectView : UIVisualEffectView?
    
    static func showLoader(message : String){
        showBlurView()
        loadingAlert = MBProgressHUD.showAdded(to: AppDelegate.getInstance().window!, animated: true)
        loadingAlert.label.text = message
    }
    
    static func hideLoader(){
        loadingAlert.hide(animated: true)
        Alert.blurEffectView?.removeFromSuperview()
        Alert.blurEffectView = nil
        Alert.blurEffectView?.removeSubviews()
        loadingAlert.removeFromSuperview()
    }
    
    static func showAlert(title : String,message : String){
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "") , style: UIAlertAction.Style.default) { (action) -> Void in
        }
        alert.addAction(alertAction)
        let currentTopVC: UIViewController? = currentTopViewController()
        currentTopVC!.present(alert, animated: true, completion: nil)
    }
    
    static func currentTopViewController() -> UIViewController {
        var topVC: UIViewController? = UIApplication.shared.delegate?.window?!.rootViewController
        while ((topVC?.presentedViewController) != nil) {
            topVC = topVC?.presentedViewController
        }
        return topVC!
    }
    
    static func showBlurView()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemThickMaterialDark)
        Alert.blurEffectView = UIVisualEffectView(effect: blurEffect)
        Alert.blurEffectView!.alpha = 0.0
        UIView.animate(withDuration: 0.3, delay: 0, options:[], animations: {
            Alert.blurEffectView!.alpha = 0.5
        })
        Alert.blurEffectView!.frame = AppDelegate.getInstance().window!.bounds
        Alert.blurEffectView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        AppDelegate.getInstance().window?.addSubview(Alert.blurEffectView!)
    }
}
public extension UIView {
    
    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
}
