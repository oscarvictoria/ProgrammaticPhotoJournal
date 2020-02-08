//
//  DetailViewController.swift
//  ProgrammaticPhotoJournal
//
//  Created by Oscar Victoria Gonzalez  on 2/6/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailView = DetailView()
    
    //    var items = [UIBarButtonItem]()
    //
    //    var itemsTwo = [UIBarButtonItem]()
    
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureButtons()
        
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
    
    
    
    
    //    func configureToolBar() {
    //        self.navigationController?.isToolbarHidden = false
    //        items.append( UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel)))
    //        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) )
    //        items.append( UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save)))
    //        detailView.toolBar.items = items
    //    }
    
    //    func configureBottomToolBar() {
    //        self.navigationController?.isToolbarHidden = false
    //        itemsTwo.append( UIBarButtonItem(barButtonSystemItem: .search , target: self, action: #selector(photos)))
    //        itemsTwo.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) )
    //        itemsTwo.append( UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(camera)))
    //        detailView.bottomToolBar.items = itemsTwo
    //        detailView.bottomToolBar.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
    //    }
    
    //    @objc func cancel() {
    //        dismiss(animated: true, completion: nil)
    //    }
    
    @objc func save() {
        print("save button pressed")
    }
    
    @objc func photos() {
        print("photo button pressed")
        
    }
    
    @objc func camera() {
        print("camera button pressed")
    }
    
    
    
}
