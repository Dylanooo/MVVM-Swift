//
//  UIBarButtonItemFixSpace.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/8.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//


import Foundation
import UIKit

extension NSObject {
    static func swizzleMethod(_ cls: AnyClass, originalSelector: Selector, swizzleSelector: Selector){
        
        let originalMethod = class_getInstanceMethod(cls, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(cls, swizzleSelector)!
        let didAddMethod = class_addMethod(cls,
                                           originalSelector,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(cls,
                                swizzleSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod,
                                           swizzledMethod)
        }
    }
}

public var cm_defultFixSpace: CGFloat = 16

public var cm_disableFixSpace: Bool = false

extension UIImagePickerController {
    
    private struct AssociatedKeys {
        static var tempDisableFixSpace = "tempDisableFixSpace"
    }
    
    static let cm_swizzleMethod: Void = {
        DispatchQueue.once(UUID().uuidString) {
            swizzleMethod(UIImagePickerController.self,
                          originalSelector: #selector(UIImagePickerController.viewWillAppear(_:)),
                          swizzleSelector: #selector(UIImagePickerController.cm_viewWillAppear(_:)))
            
            
            swizzleMethod(UIImagePickerController.self,
                          originalSelector: #selector(UIImagePickerController.viewWillDisappear(_:)),
                          swizzleSelector: #selector(UIImagePickerController.cm_viewWillDisappear(_:)))
            
        }
    }()
    
    var tempDisableFixSpace: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.tempDisableFixSpace) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.tempDisableFixSpace,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc func cm_viewWillAppear(_ animated: Bool) {
        tempDisableFixSpace = cm_disableFixSpace
        cm_disableFixSpace = true
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .automatic
        }
        cm_viewWillAppear(animated)
    }
    
    @objc func cm_viewWillDisappear(_ animated: Bool) {
        cm_disableFixSpace = tempDisableFixSpace
        cm_viewWillDisappear(animated)
    }
}


extension UINavigationBar {

    static let cm_swizzleMethod: Void = {
        DispatchQueue.once(UUID().uuidString) {
            swizzleMethod(UINavigationBar.self,
                          originalSelector: #selector(UINavigationBar.layoutSubviews),
                          swizzleSelector: #selector(UINavigationBar.cm_layoutSubviews))
            
        }
    }()
    
    @objc func cm_layoutSubviews() {
        cm_layoutSubviews()
        
        if #available(iOS 11.0, *) {
            if cm_disableFixSpace == false {
                layoutMargins = .zero
                let space = cm_defultFixSpace
                for view in subviews {
                    if NSStringFromClass(view.classForCoder).contains("ContentView") {
                        view.layoutMargins = UIEdgeInsetsMake(0, space, 0, space)
                    }
                }
            }
        }
    }
}

extension UINavigationItem {
    
    private enum BarButtonItem: String {
        case left = "_leftBarButtonItem"
        case right = "_rightBarButtonItem"
    }
    
    open override func setValue(_ value: Any?, forKey key: String) {
        
        if #available(iOS 11.0, *) {
            super.setValue(value, forKey: key)
        } else {
            if cm_disableFixSpace == false && (key == BarButtonItem.left.rawValue || key == BarButtonItem.right.rawValue) {
                
                guard let item = value as? UIBarButtonItem else { return }
                let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                space.width = cm_defultFixSpace - 16
                
                if key == BarButtonItem.left.rawValue {
                    leftBarButtonItems = [space, item]
                } else {
                    rightBarButtonItems = [space, item]
                }
            }
        }
    }
}


