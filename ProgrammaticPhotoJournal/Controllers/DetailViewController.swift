//
//  DetailViewController.swift
//  ProgrammaticPhotoJournal
//
//  Created by Oscar Victoria Gonzalez  on 2/6/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import AVFoundation

enum PhotoStatus {
    case old
    case new
}

protocol AddPhotoToCollection {
    func updateCollectionView(old: ImageObject?, new: ImageObject, photoState: PhotoStatus)
    func editPhoto(original: ImageObject, newPhoto: ImageObject)
}

class DetailViewController: UIViewController {
    
    var detailView = DetailView()
    
    var imagePickerController = UIImagePickerController()
    
    var selectedImage: UIImage?
    
    var photoState = PhotoStatus.new
    
    var caption = "Hello User"
    
    var imageObject: ImageObject? {
        didSet {
            photoState = .old
        }
    }
    
    
    
    let dataPersistance = DataPersistence<ImageObject>(filename: "images.plist")
    
    var imageObjects = [ImageObject]()
    
    var photosDelegate: AddPhotoToCollection?
    
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        guard let image = imageObject?.imageData else {
                 return
             }
        detailView.photo.image = UIImage(data: image)
        configureButtons()
        imagePickerController.delegate = self
        detailView.textView.delegate = self
        detailView.textView.text = "Caption Goes Here"
        detailView.textView.textColor = UIColor.lightGray
    }
    
    private func loadImageObjects() {
        do {
            imageObjects = try dataPersistance.loadItems()
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
        
        let size = UIScreen.main.bounds.size
        
        let rec = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
        
        
        let resizeImage = image.resizeImage(to: rec.size.width, height: rec.size.height)
        
        guard let resizedImageData = resizeImage.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        // create an image object using the image selected
        let imageObject = ImageObject(imageText: detailView.textView.text ?? "" , imageData: resizedImageData, date: Date())

        do {
            try dataPersistance.createItem(imageObject)
            print("photo succesfully saved")
        } catch {
            print("saving error")
        }
        
        loadImageObjects()
        
        photosDelegate?.updateCollectionView(old: nil, new: imageObject, photoState: photoState)
        
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

extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
  
}



extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
