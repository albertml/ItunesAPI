//
//  UIViewController+Extensions.swift
//  ItunesAPI
//
//  Created by Albert on 30/07/2019.
//  Copyright © 2019 Alberto Gaudicos Jr. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID: String {
        return "\(self)ID"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    func showLoader() {
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.center = self.view.center
        activityView.startAnimating()
        let dimView = LoaderView(frame: self.view.frame)
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        dimView.addSubview(activityView)
        self.view.addSubview(dimView)
    }
    
    func hideLoader() {
        for iv in view.subviews where iv is LoaderView {
            iv.removeFromSuperview()
        }
    }
}
