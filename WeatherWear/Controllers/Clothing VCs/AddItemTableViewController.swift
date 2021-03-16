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
    
    var imageCell: ImageTableViewCell?
    
    var hasSetImage = false
    var selectedImage: UIImage?{
        didSet{
            imageCell?.configure(with: "", image: selectedImage!)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = titleVC
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = saveButton
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(AddDetailsTableViewCell.nib(), forCellReuseIdentifier: AddDetailsTableViewCell.identifier)
        tableView.register(ImageTableViewCell.nib(), forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.register(CategoryTableViewCell.nib(), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let indexPath = IndexPath(row: 0, section: 0)
        let imageCell = tableView.cellForRow(at: indexPath) as! ImageTableViewCell
        //let categoryCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! AddDetailsTableViewCell
        let subCategoryCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! AddDetailsTableViewCell
        let brandCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! AddDetailsTableViewCell
        let colorCell = tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! AddDetailsTableViewCell
        let seasonCell = tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! AddDetailsTableViewCell
        
        // if update fill all fields
        if isUpdate{
            if let previousItem = previousItem{
                DispatchQueue.main.async { [weak self] in
                    imageCell.configure(with: "", image: UIImage(data: previousItem.clothingImage!)!)
                    self!.selectedImage = UIImage(data: previousItem.clothingImage!)
                    
                    //categoryCell.detailTextField.text = previousItem.clothingCategory?.capitalized
                    subCategoryCell.detailTextField.text = previousItem.clothingSubCategory?.capitalized
                    brandCell.detailTextField.text = previousItem.clothingBrand?.capitalized
                    colorCell.detailTextField.text = previousItem.clothingColor?.capitalized
                    seasonCell.detailTextField.text = previousItem.clothingSeason?.capitalized
                }
                
            }
            
        }
    }
    
    @objc func saveItem(){
        
        var clothingItem: ClothingItem?
        
        var fieldIsEmpty = false
        var itemDetails = [String]()
        
        if isUpdate {
            clothingItem = previousItem
        }else{
            clothingItem = ClothingItem(context: self.context)
        }
        
        // check if image was set
        if hasSetImage{
            // check if any fields are empty
            for index in 1...5{
                let indexPath = IndexPath(row: index, section: 0)
                let cell: AddDetailsTableViewCell = self.tableView.cellForRow(at: indexPath) as! AddDetailsTableViewCell
                if cell.detailTextField.text == ""{
                    fieldIsEmpty = true
                    break
                }
                if let details = cell.detailTextField.text{
                    // string checking and manipulation
                    let finalString = details.replacingOccurrences(of: " ", with: "").lowercased()
                    itemDetails.append(finalString)
                }
                
            }
        }
        
        if fieldIsEmpty || !hasSetImage {
            let alert = UIAlertController(title: "Fill in all fields", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
        // save the data
        clothingItem?.clothingId = UUID().uuidString
        clothingItem?.clothingImage = selectedImage?.pngData()
        clothingItem?.clothingCategory = itemDetails[0]
        clothingItem?.clothingSubCategory = itemDetails[1]
        clothingItem?.clothingBrand = itemDetails[2]
        clothingItem?.clothingColor = itemDetails[3]
        clothingItem?.clothingSeason = itemDetails[4]
        
        do {
            try self.context.save()
        }catch{
            fatalError("Could not save item")
        }
        
        isUpdate = false
        navigationController?.popViewController(animated: true)
        
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
            
            return imageCell
            
            
            
        }
        else if indexPath.row == 1{
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
            
            return categoryCell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: AddDetailsTableViewCell.identifier, for: indexPath) as! AddDetailsTableViewCell
            
            switch indexPath.row {
            case 1:
                cell.configure(with: categories[1], placeHolder: categories[1])
                return cell
            case 2:
                cell.configure(with: categories[2], placeHolder: categories[2])
                return cell
            case 3:
                cell.configure(with: categories[3], placeHolder: categories[3])
                return cell
            case 4:
                cell.configure(with: categories[4], placeHolder: categories[4])
                return cell
            case 5:
                cell.configure(with: categories[5], placeHolder: categories[5])
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
        else if indexPath.row == 1{
            return 250
        }
        return 100
    }
    
    
    
    @objc func imgTap(){
        let ac = UIAlertController(title: "Image Options", message: "", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in self.openCamera()}))
        ac.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in self.openGallery()}))
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        selectedImage = image
        
    }
    
}
