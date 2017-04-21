//  SBHUD.swift
//  Created by 周辉 on 2017/4/17.

import Foundation
import UIKit

// StatusBarHud
class SBHUD {
  private struct SBVar {
    static let WindowHeight: CGFloat = 20
    static let WindowWidth: CGFloat = UIScreen.main.bounds.size.width
    static let AnimationDuration: TimeInterval = 0.5
    static let Delay: TimeInterval = 1.5
  }
  private static var _window: UIWindow?
  
  init() {
    fatalError("this class dont use to create an instance")
  }
  
  private static func showMessage(message: String?, image: UIImage?) {
    if SBHUD._window != nil {
      return
    }
    
    let button = UIButton(type: .custom)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
    button.setTitle(message, for: .normal)
    button.setImage(image, for: .normal)
    
    SBHUD._window = UIWindow()
    SBHUD._window?.backgroundColor = UIColor.black
    SBHUD._window?.windowLevel = UIWindowLevelAlert
    SBHUD._window?.frame = CGRect(x: 0,
                                  y: -SBVar.WindowHeight,
                                  width: SBVar.WindowWidth,
                                  height: SBVar.WindowHeight)
    button.frame = (SBHUD._window?.bounds)!
    SBHUD._window?.addSubview(button)
    
    SBHUD._window?.isHidden = false
    
    UIView.animate(withDuration: SBVar.AnimationDuration,
                   animations: { 
                    var aframe = SBHUD._window?.frame
                    aframe?.origin.y = 0
                    SBHUD._window?.frame = aframe!
    }) { (finished) in
      UIView.animate(withDuration: SBVar.AnimationDuration,
                     delay: SBVar.Delay,
                     options: UIViewAnimationOptions(rawValue: 0),
                     animations: { 
                      var aframe = SBHUD._window?.frame
                      aframe?.origin.y = -SBVar.WindowHeight
                      SBHUD._window?.frame = aframe!
      }, completion: { (finished) in
        SBHUD._window = nil
      })
    }
  }
  class func showMessage(msg: String, img: String) {
    showMessage(message: msg, image: UIImage(named: img))
  }
  class func showSuccess(msg: String) {
    showMessage(message: msg, image: UIImage(named: "success"))
  }
  class func showError(msg: String) {
     showMessage(message: msg, image: UIImage(named: "error"))
  }
  
  class func showLoading(msg: String?) {
    if SBHUD._window != nil {
      return
    }
    
    SBHUD._window = UIWindow()
    SBHUD._window?.backgroundColor = UIColor.black
    SBHUD._window?.windowLevel = UIWindowLevelAlert
    SBHUD._window?.frame = CGRect(x: 0,
                                  y: -SBVar.WindowHeight,
                                  width: SBVar.WindowWidth,
                                  height: SBVar.WindowHeight)
    SBHUD._window?.isHidden = false
    let label = UILabel()
    label.frame = (SBHUD._window?.bounds)!
    label.font = UIFont.systemFont(ofSize: 11)
    label.text = msg ?? ""
    label.textColor = UIColor.white
    label.textAlignment = .center
    SBHUD._window?.addSubview(label)
    
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    indicator.frame = CGRect(x: 0,
                             y: 0,
                             width: SBVar.WindowHeight,
                             height: SBVar.WindowHeight)
    indicator.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    indicator.startAnimating()
    SBHUD._window?.addSubview(indicator)
    
    UIView.animate(withDuration: SBVar.AnimationDuration) { 
      var frame = SBHUD._window?.frame
      frame?.origin.y = 0
      SBHUD._window?.frame = frame!
    }
  }
  class func hideLoading() {
    if SBHUD._window == nil {
      return
    }
    UIView.animate(withDuration: SBVar.AnimationDuration,
                   animations: { 
                    var frame = SBHUD._window?.frame
                    frame?.origin.y = -SBVar.WindowHeight
                    SBHUD._window?.frame = frame!
    }) { (finished) in
      SBHUD._window = nil
    }
  }
}
