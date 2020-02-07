//
//  ViewController.swift
//  ProgrammaticPhotoJournal
//
//  Created by Oscar Victoria Gonzalez  on 2/6/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var mainView = MainView()
    
    override func loadView() {
        view = mainView
        //        self.navigationController?.toolbarItems = [UIBarButtonItem]()
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil) )
        
    }
    
    var items = [UIBarButtonItem]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
//        navigationBar.backgroundColor = .systemGray
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        //        mainView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
        mainView.collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
        configureToolBar()
        
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
            present(detailVC, animated: true)
    }
    
    
    
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            fatalError("could not get cell")
        }
        
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
