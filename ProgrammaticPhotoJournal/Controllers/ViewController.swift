//
//  ViewController.swift
//  ProgrammaticPhotoJournal
//
//  Created by Oscar Victoria Gonzalez  on 2/6/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dataPersistance = PersistenceHelper(filename: "images.plist")
    
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
            imageObjects = try dataPersistance.loadEvents()
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
    
    @objc func onClickedToolbeltButton() {
        let detailVC = DetailViewController()
        detailVC.modalPresentationStyle = .fullScreen
//        detailVC.imageObject = imageObjects
        detailVC.photosDelegate = self
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
    func updateCollectionView(images: ImageObject) {
        imageObjects.append(images)
        do {
            try dataPersistance.create(item: images)
        } catch {
            print("could not create")
        }
        
        mainView.collectionView.reloadData()
        print("there are \(imageObjects.count) images saved")
    }
}
