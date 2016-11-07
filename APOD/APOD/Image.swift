//
//  Image.swift
//  APOD
//
//  Created by Eric Chang on 11/6/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import Foundation

enum ImageParseError: Error {
  case response, title, description, mediaType, url
}

class Image {
  internal let description: String
  internal let hdurl: String
  internal let title: String
  internal let mediaType: String
  internal let url: String
  
  init(description: String, hdurl: String, title: String, mediaType: String, url: String) {
    self.description = description
    self.hdurl = hdurl
    self.title = title
    self.mediaType = mediaType
    self.url = url
  }
  
  static func images(from data: Data) -> Image? {
    
    do {
      // 1. Attempt to serialize data
      let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
      
      // 2. begin parsing to our array of user data objects
      guard let response: [String: String] = jsonData as? [String: String]
        else { throw ImageParseError.response }
      
      guard let description = response["explanation"]
        else { throw ImageParseError.description }
      
      var img = ""
      if let hdurl = response["hdurl"] {
        img = hdurl
      }
      else { img = "" }
      
      guard let imageTitle = response["title"]
        else { throw ImageParseError.title }
      
      guard let mediaType = response["media_type"]
        else { throw ImageParseError.mediaType }
      
      guard let url = response["url"]
        else { throw ImageParseError.url }
      
      let validImage: Image = Image(description: description,
                                    hdurl: img,
                                    title: imageTitle,
                                    mediaType: mediaType,
                                    url: url)
      
      return validImage
    }
    catch {
      print("error: \(error)")
    }
    return nil
  }
  
  
  
}
