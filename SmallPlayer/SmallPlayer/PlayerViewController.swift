//
//  PlayerViewController.swift
//  SmallPlayer
//
//  Created by dirtmelon on 17/1/8.
//  Copyright © 2017年 dirtmelon. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
	
	static func presentPlayerViewController() {
		if var topPlayerViewController = UIApplication.shared.keyWindow?.rootViewController {
			while let presentedViewController = topPlayerViewController.presentedViewController {
				topPlayerViewController = presentedViewController
			}
			if !(topPlayerViewController is PlayerViewController) {
				let playerViewController =
					UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
				playerViewController.modalPresentationStyle = .overCurrentContext
				playerViewController.modalTransitionStyle = .crossDissolve
				UIApplication.shared.keyWindow?.rootViewController?.present(playerViewController, animated: true, completion: nil)
			}
		}
	}
	
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
	var isSmallState = false
	
	@IBOutlet weak var navigationBar: UINavigationBar!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.addGestureRecognizer(panGestureRecognizer)
		view.addGestureRecognizer(tapGestureRecognizer)
    }
	
	@IBAction func dismiss(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func small(_ sender: UIBarButtonItem) {
		isSmallState = true
		smallAnimate(withConst: 0.5, time: 0.3)
	}
	
	func handleWithPanGestureRecognizer(_ panGestureRecognizer: UIPanGestureRecognizer) {
		switch panGestureRecognizer.state {
			
		case .changed:
			if isSmallState {
				
			} else {
				let bounds = UIScreen.main.bounds
				let moveY = panGestureRecognizer.translation(in: panGestureRecognizer.view?.superview!).y
				let const = CGFloat(fminf(fmaxf(Float(moveY / bounds.height), 0.0), 1.0))
				shouldCompleteAnimation = const >= 0.5
				if !shouldCompleteAnimation {
					smallAnimate(withConst: const, time: 0.01)
				} else{
					
				}
			}
		case .cancelled, .ended:
			
			if !shouldCompleteAnimation || panGestureRecognizer.state == .cancelled {
				UIView.animate(withDuration: 0.3, animations: {
					self.view.superview?.transform = CGAffineTransform.identity
				})
			} else {
				isSmallState = true
			}
		default:
			break
		}
	}
	
	func handleWithTapGestureRecognizer(_ tapGestureRecognizer: UITapGestureRecognizer) {
		if isSmallState {
			UIView.animate(withDuration: 0.3, animations: {
				self.view.superview?.transform = CGAffineTransform.identity
			}, completion: { _ in
				self.isSmallState = false
				self.navigationBar.isHidden = false
			})
		} else {
			
		}
	}

	func smallAnimate(withConst const: CGFloat, time: TimeInterval) {
		UIView.animate(withDuration: time, animations: {
			self.view.superview?.transform =
				CGAffineTransform(a: 1 - const, b: 0, c: 0, d: 1 - const, tx: self.offsetX * const, ty: self.offsetY * const)
		}, completion: { _ in
			self.navigationBar.isHidden = true
		})
	}
}
