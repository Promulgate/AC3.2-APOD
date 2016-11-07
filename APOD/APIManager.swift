//
//  APIManager.swift
//  APOD
//
//  Created by Eric Chang on 11/6/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import Foundation


internal class APIRequestManager {
  
  internal static let manager: APIRequestManager = APIRequestManager()
  private init() {}
  
  
  func getData(endPoint: String, callback: @escaping (Data?) -> Void) {
    guard let myURL = URL(string: endPoint) else { return }
    let session = URLSession(configuration: URLSessionConfiguration.default)
    session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
      if error != nil {
        print("Error durring session: \(error)")
      }
      guard let validData = data else { return }
      callback(validData)
      }.resume()
  }
  
  
  
  func downloadImage(urlString: String, callback: @escaping (Data) -> () ) {
    
    guard let imageURL = URL(string: urlString) else { return }
    let session = URLSession.shared
    session.dataTask(with: imageURL) { (data: Data?, response: URLResponse?, error: Error?) in
      if error != nil {
        print("Error encountered!: \(error!)")
      }
      guard let imageData = data else { return }
      callback(imageData)
      }.resume()
  }
  
}
