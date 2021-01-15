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
    
    var selectedImage: UIImage?{
        didSet{
            imageCell?.configure(with: "MY IMAGE", image: selectedImage!)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Add Item"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = saveButton
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(AddDetailsTableViewCell.nib(), forCellReuseIdentifier: AddDetailsTableViewCell.identifier)
        tableView.register(ImageTableViewCell.nib(), forCellReuseIdentifier: ImageTableViewCell.identifier)

    }
    
    @objc func saveItem(){
        
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
            imageCell.configure(with: "Image", image: UIImage(systemName: "person")!)
            
            return imageCell
            
        }else{
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
            imageCell = tableView.cellForRow(at: indexPath) as! ImageTableViewCell
            imgTap()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
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
