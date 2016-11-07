//
//  ViewController.swift
//  APOD
//
//  Created by Eric Chang on 11/6/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var nasaImageViewer: UIImageView!
  @IBOutlet weak var nasaNameLabel: UILabel!
  @IBOutlet weak var nasaTextView: UITextView!
  @IBOutlet weak var nasaDatePicker: UIDatePicker!
  
  var images: Image?
  var dateValue: String {
    let date = nasaDatePicker.date
    let calendar = Calendar.current
    let year = calendar.component(.year, from: date)
    let month = calendar.component(.month, from: date)
    let day = calendar.component(.day, from: date)
    let formattedDate = "&date=\(year)-\(month)-\(day)"
    return formattedDate
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getAPI()
  }
  
  
  func getAPI() {
    let endpointDate = "https://api.nasa.gov/planetary/apod?api_key=ITGHNQKOwQAWIt7gD7pIkveuYouqRgtlqgQx7u1M\(dateValue)"
    
    APIRequestManager.manager.getData(endPoint: endpointDate) { (data: Data?) in
      
      if  let validImages = Image.images(from: data!) {
        self.images = validImages
      }
      
      if self.images?.mediaType == "image"{
        APIRequestManager.manager.downloadImage(urlString: (self.images?.url)!) { (returnedData: Data) in
          DispatchQueue.main.async {
            self.nasaImageViewer.image = UIImage(data: returnedData)
            self.nasaImageViewer.setNeedsLayout()
            self.nasaNameLabel.text = self.images?.title
            self.nasaTextView.text = self.images?.description
          }
        }
      }
        
      else {
        DispatchQueue.main.async {
          self.nasaNameLabel.text = "No image, go to link for video"
          self.nasaTextView.text = self.images?.url
        }
      }
      
      
    }
  }
  
  @IBAction func nasaDatePickerChanged(_ sender: UIDatePicker) {
    getAPI()
  }
}

