//
//  SwiftUIPracticeApp.swift
//  SwiftUIPractice
//
//  Created by Melih on 19.08.2024.
//

import SwiftUI
import SwiftfulRouting

@main
struct SwiftUIPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }
            
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate{
    override open func viewDidLoad(){
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
