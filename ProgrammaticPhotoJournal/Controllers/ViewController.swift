//
//  ViewController.swift
//  ProgrammaticPhotoJournal
//
//  Created by Oscar Victoria Gonzalez  on 2/6/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dataPersistance = DataPersistence<ImageObject>(filename: "images.plist")
    
    var mainView = MainView()
    
    var selectedImage: UIImage?
    
    
    
    var imageObjects = [ImageObject]() {
        didSet {
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = mainView
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil) )
    }
    
    var items = [UIBarButtonItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
        configureToolBar()
        loadImageObjects()
    }
    
    
    private func loadImageObjects() {
        do {
            imageObjects = try dataPersistance.loadItems()
            print("there are \(imageObjects.count) images saved")
        } catch {
            print("error, could not load images")
        }
    }
    
    func configureToolBar() {
        self.navigationController?.isToolbarHidden = false
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) )
        items.append( UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onClickedToolbeltButton)))
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) )
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) )
        
        self.toolbarItems = items
    }
    
//    func updatePhoto(image: ImageObject, indexPath: IndexPath) {
//        dataPersistance.synchronize(imageObjects)
//        do {
//
//        } catch {
//
//        }
//    }
    
    func deletePhoto(indexPath: IndexPath) {
        dataPersistance.synchronize(imageObjects)
        do {
            imageObjects = try dataPersistance.loadItems()
        } catch {
            print("error")
        }
        
        imageObjects.remove(at: indexPath.row)
//        guard let index = imageObjects.firstIndex(of: photo) else {
//            return
//        }
        
        do {
            try dataPersistance.deleteItem(at: indexPath.row)
        } catch {
            print("error")
        }
    }
    
    @objc func onClickedToolbeltButton() {
        let detailVC = DetailViewController()
        detailVC.modalPresentationStyle = .fullScreen
        //        detailVC.imageObject = imageObjects
        detailVC.photosDelegate = self
        
        
        present(detailVC, animated: true, completion: nil)
    }
    
    func updatePicture(photo: ImageObject) {
        let detailVC = DetailViewController()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.photosDelegate = self
        let imageData = photo.imageData
        detailVC.selectedImage = UIImage(data: imageData)
        detailVC.imageObject = photo

        present(detailVC, animated: true, completion: nil)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            fatalError("could not get cell")
        }
        
        let photos = imageObjects[indexPath.row]
        cell.configuredCell(imageObject: photos)
        cell.delegate = self
        //        cell.editButton.addTarget(self, action: #selector(didSelectEditButton), for: .touchUpInside)
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth: CGFloat = UIScreen.main.bounds.size.width
        let itemWidth: CGFloat = maxWidth * 0.90
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension ViewController: AddPhotoToCollection {
    func editPhoto(original: ImageObject, newPhoto: ImageObject) {
        let index = imageObjects.firstIndex(of: original)!
             imageObjects.remove(at: index)
             imageObjects.insert(newPhoto, at: index)
             dataPersistance.update(original, with: newPhoto)
    }
    
    func updateCollectionView(old: ImageObject?, new: ImageObject, photoState: PhotoStatus) {
        if photoState == .new {
            do {
                try dataPersistance.createItem(new)
            } catch {
                print("could not create")
            }
            imageObjects.append(new)
        } else {
            dataPersistance.update(old!, with: new)
            loadImageObjects()
        }
    }
    
}

extension ViewController: PhotoCellDelegate {
    func showEdit(_ photoCell: PhotoCell) {
        guard let indexPath = mainView.collectionView.indexPath(for: photoCell) else {
            return
        }
        
        let imageObject = imageObjects[indexPath.row]
        
        let alertAction = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
            alertAction in
            self.deletePhoto(indexPath: indexPath)
        }
        let editAction = UIAlertAction(title: "Edit", style: .default) { (action) in
            self.updatePicture(photo: imageObject)
//            let downloadView = DetailViewController()
//            self.present(downloadView, animated:true)
        }
        
        let shareAction = UIAlertAction(title: "Share", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertAction.addAction(deleteAction)
        alertAction.addAction(editAction)
        alertAction.addAction(shareAction)
        alertAction.addAction(cancelAction)
        present(alertAction, animated: true)
    }
}
