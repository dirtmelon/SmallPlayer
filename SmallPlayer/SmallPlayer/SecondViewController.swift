//
//  SecondViewController.swift
//  SmallPlayer
//
//  Created by dirtmelon on 17/1/4.
//  Copyright © 2017年 dirtmelon. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

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
extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 20
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
		cell.textLabel?.text = "SecondViewControllerUITableViewCell----\(indexPath.row)"
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let anotherViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnotherViewController")
		navigationController?.pushViewController(anotherViewController, animated: true)
	}
}
