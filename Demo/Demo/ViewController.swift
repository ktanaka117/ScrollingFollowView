//
//  ViewController.swift
//  ScrollingFollowView
//
//  Created by 田中賢治 on 2016/07/05.
//  Copyright © 2016年 田中賢治. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var navBarScrollingFollowView: ScrollingFollowView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navBarTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let sfViewHeight = navBarScrollingFollowView.frame.size.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        
        navBarScrollingFollowView.setup(constraint: navBarTopConstraint, maxFollowPoint: sfViewHeight + statusBarHeight, minFollowPoint: 0)
        navBarScrollingFollowView.setupDelayPoints(pointOfStartingHiding: 100, pointOfStartingShowing: 0)
        
        navBarScrollingFollowView.backgroundColor = UIColor.red
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { fatalError("Empty Cell") }
        cell.textLabel?.text = "\((indexPath as NSIndexPath).row)"
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.contentOffset.y > 200 {
            navBarScrollingFollowView.show(true) {
                print("show")
            }
        } else {
            navBarScrollingFollowView.hide(true) {
                print("hide")
            }
        }
        
        navBarScrollingFollowView.resetPreviousPoint(tableView)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navBarScrollingFollowView.didScrolled(scrollView)
    }
}
