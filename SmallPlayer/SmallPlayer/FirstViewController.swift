//
//  FirstViewController.swift
//  SmallPlayer
//
//  Created by dirtmelon on 17/1/4.
//  Copyright © 2017年 dirtmelon. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.dataSource = self
			tableView.delegate = self
			tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
}

// mark - UITableViewDataSource, UITableViewDelegate
extension FirstViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 20
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
		cell.textLabel?.text = "FirstViewControllerUITableViewCell----\(indexPath.row)"
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		let playerViewController =
			UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
		playerViewController.modalPresentationStyle = .overCurrentContext
		playerViewController.modalTransitionStyle = .crossDissolve
		UIApplication.shared.keyWindow?.rootViewController?.present(playerViewController, animated: true, completion: nil)
//		tabBarController?.present(playerViewController, animated: true, completion: nil)
	}
}
