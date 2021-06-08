//
//  AddItemTableViewController.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-01-08.
//

import UIKit

class AddItemTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    private var categories: [String] = [
        "Image",
        "Category",
        "Sub Category",
        "Brand",
        "Color",
        "Season"
    ]
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveItem))
        return button
    }()
    
    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelSave))
        return button
    }()
    
    var imageCell: ImageTableViewCell?
    
    var hasSetImage: Bool = false
    
    var selectedImage: UIImage?{
        didSet{
            if selectedImage != nil {
                imageCell?.configure(with: "", image: selectedImage!)
            }
            
            hasSetImage = true
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var titleVC: String?
    var isUpdate = false{
        didSet{
            hasSetImage = true
        }
    }
    var previousItem: ClothingItem?
    
    var clothing_category: String?
    var clothing_subcategory: String?
    var clothing_brand: String?
    var clothing_color: String?
    var clothing_season: [String]?
    var seasons = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = titleVC
        setupNavigationBar()
        registerTableViewCells()
        
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    func registerTableViewCells(){
        tableView.register(AddDetailsTableViewCell.nib(), forCellReuseIdentifier: AddDetailsTableViewCell.identifier)
        tableView.register(ImageTableViewCell.nib(), forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.register(CategoryTableViewCell.nib(), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        tableView.register(SeasonTableViewCell.nib(), forCellReuseIdentifier: SeasonTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        let imageCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ImageTableViewCell
        let categoryCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! CategoryTableViewCell
        let subCategoryCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! AddDetailsTableViewCell
        let brandCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! AddDetailsTableViewCell
        let colorCell = tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! AddDetailsTableViewCell
        let seasonCell = tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! SeasonTableViewCell
        
        // fields will be populated if user has tapped on item in the collectionView
        if isUpdate{
            if let previousItem = previousItem{
                DispatchQueue.main.async { [weak self] in
                    
                    guard let prevItemImage = previousItem.clothingImage else { return }
                    guard let itemImage = UIImage(data: prevItemImage) else { return }
                    guard let self = self else { return }
                    
                    imageCell.configure(with: "", image: itemImage)
                    
                    self.selectedImage = itemImage
                    
                    for btn in categoryCell.categoryButtons{
                        if previousItem.clothingCategory?.capitalized == btn.titleLabel?.text?.capitalized{
                            btn.isChecked = true
                        }
                    }
                    
                    for seasonBtn in seasonCell.seasonButtons{
                        previousItem.clothingSeason?.forEach({ season in
                            if seasonBtn.titleLabel?.text == season{
                                seasonBtn.isChecked = true
                            }
                        })
                    }
                    
                    subCategoryCell.detailTextField.text = previousItem.clothingSubCategory?.capitalized
                    brandCell.detailTextField.text = previousItem.clothingBrand?.capitalized
                    colorCell.detailTextField.text = previousItem.clothingColor?.capitalized
                    
                    
                
                    self.clothing_category = previousItem.clothingCategory
                    self.clothing_subcategory = previousItem.clothingSubCategory
                    self.clothing_brand = previousItem.clothingBrand
                    self.clothing_color = previousItem.clothingBrand
                    self.clothing_season = previousItem.clothingSeason
                    self.seasons = previousItem.clothingSeason!
                    
                }
            }
            
        }
    }
    
    @objc func cancelSave(){
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func saveItem(){
        
        var clothingItem: ClothingItem?
        
        if isUpdate {
            clothingItem = previousItem
            clothingItem?.clothingImage = selectedImage?.pngData()
            clothingItem?.clothingCategory = clothing_category
            clothingItem?.clothingSubCategory = clothing_subcategory
            clothingItem?.clothingBrand = clothing_brand
            clothingItem?.clothingColor = clothing_color
            clothingItem?.clothingSeason = clothing_season
            
        }else{
            clothingItem = ClothingItem(context: self.context)
            clothingItem?.clothingId = UUID().uuidString
            clothingItem?.clothingImage = selectedImage?.pngData()
            clothingItem?.clothingCategory = clothing_category
            clothingItem?.clothingSubCategory = clothing_subcategory
            clothingItem?.clothingBrand = clothing_brand
            clothingItem?.clothingColor = clothing_color
            clothingItem?.clothingSeason = clothing_season
        }
       
        var c1 = false, c2 = false, c3 = false, c4 = false, c5 = false, c6 = false
        // check for empty fields
        if hasSetImage {
            c1 = true
        }
        if clothingItem?.clothingCategory != nil {
            c2 = true
        }
        if clothingItem?.clothingSubCategory != nil{
            c3 = true
        }
        if clothingItem?.clothingBrand != nil {
            c4 = true
        }
        if clothingItem?.clothingColor != nil {
            c5 = true
        }
        if clothingItem?.clothingSeason != nil{
            c6 = true
        }
        
        if c1 && c2 && c3 && c4 && c5 && c6{
            do {
                try self.context.save()
                isUpdate = false
                navigationController?.popViewController(animated: true)
            }catch{
                fatalError("Could not save item")
            }
        }
        
        else{
             let alert = UIAlertController(title: "Fill in all fields", message: "", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "OK", style: .default))
             present(alert, animated: true)
             context.delete(clothingItem!)
         }
            
    } //end of save item
    
    func userHasSetImage(){
        if selectedImage != nil{
            hasSetImage = true
        }
    }
    
    
    // MARK: TableView Functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
        
            let imageCell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as! ImageTableViewCell
            
            imageCell.configure(with: "Pick a Picture", image: UIImage(systemName: "camera.circle")!)
            
            if let userImage = selectedImage{
                imageCell.configure(with: "", image: userImage)
                hasSetImage = true
            }

            return imageCell
        }
        
        else if indexPath.row == 1{
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
            categoryCell.delegate = self
            
            userHasSetImage()
            
            return categoryCell
        }
        else if indexPath.row == 5{
            let seasonCell = tableView.dequeueReusableCell(withIdentifier: SeasonTableViewCell.identifier, for: indexPath) as! SeasonTableViewCell
            seasonCell.delegate = self
            userHasSetImage()
            
            return seasonCell
        }
        
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: AddDetailsTableViewCell.identifier, for: indexPath) as! AddDetailsTableViewCell
            
            switch indexPath.row {
            case 2:
                cell.configure(with: categories[2], placeHolder: categories[2])
                cell.textViewTextChangeCallback = { [unowned self] text in
                    clothing_subcategory = text
                }
                userHasSetImage()
                return cell
            case 3:
                cell.configure(with: categories[3], placeHolder: categories[3])
                cell.textViewTextChangeCallback = { [unowned self] text in
                    clothing_brand = text
                }
                userHasSetImage()
                return cell
            case 4:
                cell.configure(with: categories[4], placeHolder: categories[4])
                cell.textViewTextChangeCallback = { [unowned self] text in
                  clothing_color = text
                }
                userHasSetImage()
                return cell
            default:
                fatalError()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            imageCell = (tableView.cellForRow(at: indexPath) as! ImageTableViewCell)
            imgTap()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 250
        }
        else if indexPath.row == 1 {
            return 275
        }
        else if indexPath.row == 5{
            return 250
        }
        return 100
    }
    
    
    
    @objc func imgTap(){
        let ac = UIAlertController(title: "Image Options", message: "", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self]  _  in self?.openCamera()}))
        ac.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { [weak self] _ in self?.openGallery()}))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(ac, animated: true)
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.delegate = self
            vc.allowsEditing = true
            self.present(vc, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Warning", message: "You don't have a camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Warning", message: "You don't have permision to photo library", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension AddItemTableViewController: UIImagePickerControllerDelegate{
    
    /// takes the chosen image by the user and assigns it to local UIImage variable
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        selectedImage = image
        hasSetImage = true
        
    }
    
    
    
}

extension AddItemTableViewController: CategoryTableViewCellDelegate{
    
    /// this function ensures only 1 category button is selected and assigns the chosen buttons title to the items clothing category
    func didTapCategoryButton(sender: UIButton, categoryBtns: [RadioButton]) {
        for button in categoryBtns{
            if button.tag != sender.tag {
                button.isChecked = false
            }
        }
        clothing_category = sender.titleLabel?.text
        
    }
}


extension AddItemTableViewController: SeasonTableViewCellDelegate{
    
    /// this function checks which radio button has been selected and ensures no duplicate seasons are added in the "seasons" array
    func didTapButton(sender: UIButton, summer: RadioButton, spring: RadioButton, fall: RadioButton, winter: RadioButton) {
       
        switch sender.tag{
        case 1:
            if !summer.isChecked{
                seasons.append("Summer")
            }else{
                while let idx = seasons.firstIndex(of: "Summer"){
                    seasons.remove(at: idx)
                }
            }
        case 2:
            if !spring.isChecked{
                seasons.append("Spring")
                
            }else{
                while let idx = seasons.firstIndex(of: "Spring"){
                    seasons.remove(at: idx)
                }
            }
        case 3:
            if !fall.isChecked{
                seasons.append("Fall")
            }else{
                while let idx = seasons.firstIndex(of: "Fall"){
                    seasons.remove(at: idx)
                }
            }
        case 4:
            if !winter.isChecked{
                seasons.append("Winter")
            }else{
                while let idx = seasons.firstIndex(of: "Winter"){
                    seasons.remove(at: idx)
                }
            }
        default:
            print("")
        }
        
        clothing_season = seasons
    } // end of didTapButton

}

