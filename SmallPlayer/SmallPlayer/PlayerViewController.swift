//
//  PlayerViewController.swift
//  SmallPlayer
//
//  Created by 李国锋 on 17/1/8.
//  Copyright © 2017年 dirtmelon. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

	var shouldCompleteTransition = false
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let panGestureRecognizer =
			UIPanGestureRecognizer(target: self, action: #selector(PlayerViewController.handle(_:)))
		view.addGestureRecognizer(panGestureRecognizer)
    }
	
	@IBAction func dismiss(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func small(_ sender: UIBarButtonItem) {
		UIView.animate(withDuration: 0.3, animations: {
			self.view.superview!.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
		})
	}
	
	func handle(_ gestureRecognizer: UIPanGestureRecognizer) {
		let viewTranslation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
		switch gestureRecognizer.state {
//		case .began:
//			transitionInProgress = true
		case .changed:
			let bounds = UIScreen.main.bounds
			
			let const = CGFloat(fminf(fmaxf(Float(viewTranslation.y / bounds.height), 0.0), 1.0))
			shouldCompleteTransition = const > 0.5
			
		case .cancelled, .ended:
			if !shouldCompleteTransition || gestureRecognizer.state == .cancelled {
				
			} else {
				
			}
		default:
			print("Swift switch must be exhaustive, thus the default")
		}
	}

}
