//
//  PlayerViewController.swift
//  SmallPlayer
//
//  Created by dirtmelon on 17/1/8.
//  Copyright © 2017年 dirtmelon. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

	let offsetX = UIScreen.main.bounds.width / 2 - 10
	let offsetY = UIScreen.main.bounds.height / 2 - 60
	
	var panGestureRecognizer: UIPanGestureRecognizer {
		return UIPanGestureRecognizer(target: self,
			action: #selector(PlayerViewController.handleWithPanGestureRecognizer(_:)))
	}
	
	var tapGestureRecognizer: UITapGestureRecognizer {
		return UITapGestureRecognizer(target: self,
			action: #selector(PlayerViewController.handleWithTapGestureRecognizer(_:)))
	}
	
	var shouldCompleteAnimation = false
    override func viewDidLoad() {
        super.viewDidLoad()
		view.addGestureRecognizer(panGestureRecognizer)
		view.addGestureRecognizer(tapGestureRecognizer)
    }
	
	@IBAction func dismiss(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func small(_ sender: UIBarButtonItem) {
		UIView.animate(withDuration: 0.3, animations: {
			self.view.superview!.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
		})
	}
	
	func handleWithPanGestureRecognizer(_ panGestureRecognizer: UIPanGestureRecognizer) {
		switch panGestureRecognizer.state {
			
		case .changed:
			let bounds = UIScreen.main.bounds
			let moveY = panGestureRecognizer.translation(in: panGestureRecognizer.view?.superview!).y
			let const = CGFloat(fminf(fmaxf(Float(moveY / bounds.height), 0.0), 1.0))
			shouldCompleteAnimation = const > 0.5
			if !shouldCompleteAnimation {
				UIView.animate(withDuration: 0.01, animations: {
					self.view.superview?.transform =
						CGAffineTransform(a: 1 - const, b: 0, c: 0, d: 1 - const, tx: self.offsetX * const, ty: self.offsetY * const)
				})
			}
		case .cancelled, .ended:
			if !shouldCompleteAnimation || panGestureRecognizer.state == .cancelled {
				UIView.animate(withDuration: 0.3, animations: {
					self.view.superview?.transform = CGAffineTransform.identity
				})
			} else {
				self.view.removeGestureRecognizer(panGestureRecognizer)
			}
		default:
			break
		}
	}
	
	func handleWithTapGestureRecognizer(_ tapGestureRecognizer: UITapGestureRecognizer) {
		if shouldCompleteAnimation {
			UIView.animate(withDuration: 0.3, animations: {
				self.view.superview?.transform = CGAffineTransform.identity
				self.view.addGestureRecognizer(self.panGestureRecognizer)
			})
		} else {
			// tanru
		}
	}

}
