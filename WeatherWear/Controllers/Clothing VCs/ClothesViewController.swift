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

    
    var clothingItems:[ClothingItem] = []
    var clothingItemIndexes: [(clothing: ClothingItem, index: Int)]? = []
    var filteredClothingItems: [(clothing: ClothingItem, index: Int)] = []
   
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        mMode = .view
        return searchController.isActive && !isSearchBarEmpty
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        fetchItems()
        setupCollectionView()
        setupBarButtonItems()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        fetchItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
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
        self.navigationItem.title = "Clothing"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = selectButton
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func setupCollectionView(){
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutCollectionView())
        guard let collectionView = collectionView else { return }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        // Register cell
        collectionView.register(ClothingCollectionViewCell.self, forCellWithReuseIdentifier: ClothingCollectionViewCell.identifier)
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
        
        if !filteredClothingItems.isEmpty{
            print(dictionarySelectedIndexPath)
            print("filter results not empty")
            for(key, value) in dictionarySelectedIndexPath{
                if value{
                    let idx = IndexPath(row: filteredClothingItems[key.item].index, section: 0)
                    print(idx)
                    deleteAtIndexPaths.append(idx)
                    filteredClothingItems.remove(at: key.row)
                }
                print("this is \(deleteAtIndexPaths)")
            }
        }
        else{
            print("no filter")
            print(dictionarySelectedIndexPath)
            for(key, value) in dictionarySelectedIndexPath{
                if value{
                    print(key)
                    deleteAtIndexPaths.append(key)
                }
                print(deleteAtIndexPaths)
            }

        }
        
        
        for i in deleteAtIndexPaths.sorted(by: {$0.item > $1.item}){
            print(clothingItems[i.item])
            self.context.delete(clothingItems[i.item])
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
            clothingItems = try context.fetch(ClothingItem.fetchRequest())
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }catch{
            fatalError("Could not fetch items")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredClothingItems.count
        }
        return clothingItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClothingCollectionViewCell.identifier, for: indexPath) as! ClothingCollectionViewCell
        
        let clothing: ClothingItem
          if isFiltering {
            clothing = filteredClothingItems[indexPath.row].clothing
          } else {
            clothing = clothingItems[indexPath.row]
          }
        
        
        if let image = clothing.clothingImage {
            let dataImage = UIImage(data: image)
            cell.configure(image: dataImage!)
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
            if isFiltering{
                vc.previousItem = filteredClothingItems[indexPath.row].clothing
            }else{
                vc.previousItem = clothingItems[indexPath.row]
            }
        
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
    
    func filterContentForSearchText(_ compareText: String) {
        
        guard var clothingItemIndexes = clothingItemIndexes else { return }
       
        for index in 0..<clothingItems.count{
            clothingItemIndexes += [(clothingItems[index], index)]
        }
        
        filteredClothingItems = clothingItemIndexes.filter ({
            return
            $0.clothing.clothingCategory == compareText.capitalized ||
                    $0.clothing.clothingSubCategory == compareText ||
                    $0.clothing.clothingBrand == compareText ||
                    $0.clothing.clothingColor == compareText
                || ($0.clothing.clothingSeason!.contains(compareText.capitalized))
            
        })
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
}

extension ClothesViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        if let search = searchController.searchBar.text?.lowercased(){
            filterContentForSearchText(search)
        }
    }
    
} // end of extension

extension ClothesViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let search = searchBar.text?.lowercased(){
            filterContentForSearchText(search)
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        fetchItems()
    }

    
}

