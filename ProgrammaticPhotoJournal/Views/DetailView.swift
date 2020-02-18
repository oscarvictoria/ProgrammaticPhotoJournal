//
//  DetailView.swift
//  ProgrammaticPhotoJournal
//
//  Created by Oscar Victoria Gonzalez  on 2/6/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit


class DetailView: UIView {
    
    public lazy var cameraButton: UIButton = {
          let button = UIButton()
        button.setTitle("Camera", for: .normal)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.systemBlue, for: .normal)
          return button
      }()
    
    public lazy var photoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Photos", for: .normal)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    public lazy var buttonStackViewTwo: UIStackView = {
          let buttonStack = UIStackView()
          return buttonStack
      }()
    
    public lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    public lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    public lazy var buttonStackView: UIStackView = {
        let buttonStack = UIStackView()
        return buttonStack
    }()
    
    public lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    public lazy var photo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "seattle")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.backgroundColor = .systemGray3
        return image
    }()
    
    public lazy var bottomToolBar: UIToolbar = {
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
        configureButtonStackView()
        configureTextField()
        configurePhoto()
        conifgureButtonStackViewTwo()
    }
    
    
    func configureTextField() {
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo:trailingAnchor),
            textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
        ])
    }
    
    
    func configurePhoto() {
        addSubview(photo)
        photo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: textView.bottomAnchor),
            photo.leadingAnchor.constraint(equalTo: leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: trailingAnchor),
            photo.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.70)
        ])
    }
    
    func conifgureButtonStackViewTwo() {
         addSubview(buttonStackViewTwo)
         buttonStackViewTwo.addArrangedSubview(photoButton)
         buttonStackViewTwo.addArrangedSubview(cameraButton)
         
         buttonStackViewTwo.alignment = .fill
         buttonStackViewTwo.distribution = .fillEqually
         buttonStackViewTwo.spacing = 240
         
         photoButton.translatesAutoresizingMaskIntoConstraints = false
         cameraButton.translatesAutoresizingMaskIntoConstraints = false
         
         buttonStackViewTwo.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            buttonStackViewTwo.topAnchor.constraint(equalTo: photo.bottomAnchor),
             buttonStackViewTwo.leadingAnchor.constraint(equalTo: leadingAnchor),
             buttonStackViewTwo.trailingAnchor.constraint(equalTo: trailingAnchor),
             buttonStackViewTwo.heightAnchor.constraint(equalToConstant: 50)
         ])
        
    }
    
    

    func configureButtonStackView() {
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(saveButton)
        
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 240
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
}
