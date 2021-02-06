//
//  WeatherViewController.swift
//  WeatherWear
//
//  Created by elliott kung on 2020-12-29.
//

import UIKit

class WeatherViewController: UIViewController {

    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search a location"
        searchController.searchBar.searchBarStyle = .minimal
        
        return searchController
    }()
    
    lazy var worldMapBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(self.openMap))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Weather"
        
        // navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        setupBarButtons()
    }
    
    func setupBarButtons(){
        navigationItem.leftBarButtonItem = worldMapBtn
        navigationItem.searchController = searchController
    }
    
    @objc func openMap(){
        
    }
    
    

}
