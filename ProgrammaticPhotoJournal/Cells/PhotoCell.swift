//
//  PhotoCell.swift
//  ProgrammaticPhotoJournal
//
//  Created by Oscar Victoria Gonzalez  on 2/6/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

protocol PhotoCellDelegate: AnyObject {
    func showEdit(_ photoCell: PhotoCell)
}

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
     
    weak var delegate: PhotoCellDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20.0
    }
    
    func configuredCell(imageObject: ImageObject) {
    guard let image = UIImage(data: imageObject.imageData) else {
        return
    }
        textField.text = imageObject.imageText
        photoImageView.image = image
        dateLabel.text = imageObject.date.timeIntervalSince1970.timeConverter()
}
    
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        delegate?.showEdit(self)
    }
    
}

extension Double {
func timeConverter() -> String {
    let date = Date(timeIntervalSince1970: self)
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = DateFormatter.Style.medium
    dateFormatter.dateStyle = DateFormatter.Style.medium
    dateFormatter.dateFormat = "EEEE, MMM d"
    dateFormatter.timeZone = .current
    let localDate = dateFormatter.string(from: date)
    return localDate
}
}
