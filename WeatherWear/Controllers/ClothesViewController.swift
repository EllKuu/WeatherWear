//
//  ClothesViewController.swift
//  WeatherWear
//
//  Created by elliott kung on 2020-12-29.
//

import UIKit

class ClothesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    private var collectionView: UICollectionView?
    
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addItem))
        return button
    }()
    
    lazy var selectButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(self.selectItem))
        return button
    }()
    
    lazy var deleteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(self.deleteItem))
        return button
    }()
    
    enum Mode{
        case view
        case select
    }
    
    var mMode: Mode = .view{
        didSet{
            switch mMode{
            case .view:
                
                for (key, value) in dictionarySelectedIndexPath{
                    if value{
                        collectionView?.deselectItem(at: key, animated: true)
                    }
                }
                dictionarySelectedIndexPath.removeAll()
                
                selectButton.title = "Select"
                navigationItem.rightBarButtonItem = addButton
                navigationItem.leftBarButtonItem = selectButton
                collectionView?.allowsMultipleSelection = false
            case .select:
                selectButton.title = "Cancel"
                navigationItem.leftBarButtonItem = deleteButton
                navigationItem.rightBarButtonItem = selectButton
                collectionView?.allowsMultipleSelection = true
            }
        }
    }
    
    var dictionarySelectedIndexPath: [IndexPath: Bool] = [ : ]
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "New Search"
        searchController.searchBar.searchBarStyle = .minimal
        
        return searchController
    }()
    
    var clothingItems:[ClothingItem]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Clothing"
        fetchItems()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutCollectionView())
        guard let collectionView = collectionView else { return }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        // Register cell
        collectionView.register(ClothingCollectionViewCell.self, forCellWithReuseIdentifier: ClothingCollectionViewCell.identifier)
        
        // Navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        setupBarButtonItems()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
        fetchItems()
    }
    
    
    func layoutCollectionView() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-4, height: (view.frame.size.width/3)-4)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        return layout
    }
    
    func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = selectButton
        //navigationItem.titleView = searchBar
    }
    
    // MARK: Navbar Functions: ADD, DELETE
    
    @objc func addItem(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "addItem") as! AddItemTableViewController
        vc.modalPresentationStyle = .fullScreen
        vc.titleVC = "Add Item"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func selectItem(){
        mMode = mMode == .view ? .select : .view
    }
    
    @objc func deleteItem(){
        var deleteAtIndexPaths: [IndexPath] = [ ]
        for(key, value) in dictionarySelectedIndexPath{
            if value{
                deleteAtIndexPaths.append(key)
            }
        }
        
        for i in deleteAtIndexPaths.sorted(by: {$0.item > $1.item}){
            self.context.delete(clothingItems![i.item])
        }
        
        do{
            try self.context.save()
        }catch{
            fatalError("could not save context")
        }
        fetchItems()
        
        dictionarySelectedIndexPath.removeAll()
        
    }
    
    func fetchItems(){
        do {
            self.clothingItems = try context.fetch(ClothingItem.fetchRequest())
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }catch{
            fatalError("Could not fetch items")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothingItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClothingCollectionViewCell.identifier, for: indexPath) as! ClothingCollectionViewCell
        
        if let image = UIImage(data: (clothingItems?[indexPath.row].clothingImage)!){
            cell.configure(image: image)
            cell.contentMode = .scaleAspectFill
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch mMode{
        case .view:
            collectionView.deselectItem(at: indexPath, animated: true)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "addItem") as! AddItemTableViewController
            vc.modalPresentationStyle = .fullScreen
            vc.titleVC = "Update Item"
            vc.isUpdate = true
            vc.previousItem = clothingItems?[indexPath.row]
        
            navigationController?.pushViewController(vc, animated: true)
        case .select:
            dictionarySelectedIndexPath[indexPath] = true
            
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if mMode == .select{
            dictionarySelectedIndexPath[indexPath] = false
        }
    }
    
    

}
