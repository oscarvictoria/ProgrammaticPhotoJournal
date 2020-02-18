//
//  ImageObject.swift
//  ProgrammaticPhotoJournal
//
//  Created by Oscar Victoria Gonzalez  on 2/7/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct ImageObject: Codable, Equatable {
  let imageText: String
  let imageData: Data
  let date: Date
  let identifier = UUID().uuidString
}
