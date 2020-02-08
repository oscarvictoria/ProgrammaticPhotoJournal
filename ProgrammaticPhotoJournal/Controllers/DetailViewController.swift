//
//  DetailViewController.swift
//  ProgrammaticPhotoJournal
//
//  Created by Oscar Victoria Gonzalez  on 2/6/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

protocol AddPhotoToCollection {
    func updateCollectionView(images: ImageObject)
}

class DetailViewController: UIViewController {
    
    var detailView = DetailView()
    
    var imagePickerController = UIImagePickerController()
    
    var selectedImage: UIImage?
    
    var imageObject: ImageObject?
    
    let dataPersistance = PersistenceHelper(filename: "images.plist")
    
    var imageObjects = [ImageObject]()
    
    var photosDelegate: AddPhotoToCollection?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureButtons()
        imagePickerController.delegate = self
    }
    
    private func loadImageObjects() {
         do {
            imageObjects = try dataPersistance.loadEvents().reversed()
         } catch {
             print("error, could not load images")
         }
     }
    
    func configureButtons() {
        detailView.cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        detailView.saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        detailView.cameraButton.addTarget(self, action: #selector(camera), for: .touchUpInside)
        detailView.photoButton.addTarget(self, action: #selector(photos), for: .touchUpInside)
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func save() {
        guard let image = selectedImage else {
            print("image is nil")
            return
        }
        
//        print("original image size is \(image.size)")
        
        guard let resizedImageData = image.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        // create an image object using the image selected
        let imageObject = ImageObject(imageData: resizedImageData, date: Date())
        //        let imageObject = ImageObject(imageData: resizedImageData, date: Date())
        
        // insert new imageObject into imageObjects
        imageObjects.insert(imageObject, at: 0)
        
        // Persist imageObject to documents directory
        do {
            try dataPersistance.create(item: imageObject)
            print("photo succesfully saved")
        } catch {
            print("saving error")
        }
        
        loadImageObjects()
        
        photosDelegate?.updateCollectionView(images: imageObject)
        
         self.dismiss(animated: true, completion: nil)
    }
    
    @objc func photos() {
       self.showImageController(isCameraSelected: false)
        
    }
    
    @objc func camera() {
        print("camera button pressed")
    }
    
    private func showImageController(isCameraSelected: Bool) {
        imagePickerController.sourceType = .photoLibrary
        if isCameraSelected {
            imagePickerController.sourceType = .camera
        }
        present(imagePickerController, animated: true)
    }
    
}

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("Image selected not found")
            return
        }
        selectedImage = image
        detailView.photo.image = image
        
        dismiss(animated: true)
    }
}

