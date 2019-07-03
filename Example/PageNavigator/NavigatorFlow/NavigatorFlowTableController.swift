//
//  NavigatorFlowTableController.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class NavigatorFlowTableController: UITableViewController {

    var dataSource: [[String: Any]] {
        return [
            ["title": "打开一个内部red页面",
             "url": "webus://red#push"],
            ["title": "打开一个内部green页面",
             "url": "webus://green#modal"],
            ["title": "打开一个内部blue页面",
             "url": "webus://blue#modalNavigation"],
            ["title": "打开一个内部collection页面",
             "url": "webus://collection#modalNavigation"],
            ["title": "打开一个http外链 百度",
             "url": "http://www.baidu.com#modal"],
            ["title": "打开一个https外链 京东",
             "url": "https://www.jd.com#modal"],
            ["title": "打开一个错误链接",
             "url": "webus://notarget"],
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = (dataSource[indexPath.row]["title"] as? String) ?? ""
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let url = dataSource[indexPath.row]["url"] as! String
        navigator.url(URL(string: url)!) {
            print("导航完成")
        }
    }

}
