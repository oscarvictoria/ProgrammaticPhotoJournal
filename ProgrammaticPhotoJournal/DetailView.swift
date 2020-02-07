//
//  DetailView.swift
//  ProgrammaticPhotoJournal
//
//  Created by Oscar Victoria Gonzalez  on 2/6/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    public lazy var textField: UITextField = {
        let textField = UITextField()
        textField.text = "Text goes here"
        return textField
    }()
    
    public lazy var photo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "gear")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    public lazy var bottomToolBar: UIToolbar = {
        let toolBar = UIToolbar()
        return toolBar
    }()
    
    public lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        return toolBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        
    }
    
    func commonInit() {
        configureToolBar()
        configureTextField()
        configurePhoto()
        configureBottomToolBar()
    }
    
    func configureToolBar() {
        addSubview(toolBar)
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            toolBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            toolBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
    

    func configurePhoto() {
        addSubview(photo)
        photo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            photo.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            photo.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            photo.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.72)
        ])
    }
    
    func configureBottomToolBar() {
        addSubview(bottomToolBar)
         bottomToolBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomToolBar.topAnchor.constraint(equalTo: photo.bottomAnchor),
            bottomToolBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            bottomToolBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),

        ])
    }
    
    func configureTextField() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: toolBar.bottomAnchor, constant: 0),
            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            textField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
        ])
    }
    
}
