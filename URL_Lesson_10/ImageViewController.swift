//
//  ImageViewController.swift
//  URL_Lesson_10
//
//  Created by Valerii D on 22.06.2021.
//

import UIKit

class ImageViewController: UIViewController {
    
    private let imageUrl = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"

    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    private func fetchImage() {
        guard let url = URL(string: imageUrl) else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let response = response {
                print(response)
            }
            
            if let data = data, let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.imageView.image = image
                }
            }
        }.resume()
    }

 

}
