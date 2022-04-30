//
//  HomePageViewController.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 29/4/22.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var allTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        navBar.barTintColor = .backgroundColor
        allTableView.layer.cornerRadius = 10
    }
    
    private func setupTableView() {
        allTableView.delegate = self
        allTableView.dataSource = self
    }
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed(PostTableViewCell.identifier, owner: self, options: nil)?.first as! PostTableViewCell

        return cell
    }
    
    
}

extension UIColor {
    static let backgroundColor = UIColor(named: "BackgroundColor")
}

