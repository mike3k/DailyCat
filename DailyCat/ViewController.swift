//
//  ViewController.swift
//  DailyCat
//
//  Created by Mike Cohen on 4/4/20.
//  Copyright © 2020 Mike Cohen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let imageView = UIImageView()
    private let caption = UILabel()
    private let button = UIButton(type: .custom)
    
    private let catFacts = CatFacts()
    private let catApi = CatApi()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetch()
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .black
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        
        caption.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(caption)
        caption.numberOfLines = 0
        caption.textAlignment = .center
        caption.lineBreakMode = .byWordWrapping
        caption.backgroundColor = .clear
        caption.textColor = .white
        caption.font = .systemFont(ofSize: 18)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(fetchNext(_:)), for: .touchUpInside)
        
        
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            imageView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            caption.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            caption.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 10),
            caption.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10),
            caption.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            caption.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -10),
            caption.bottomAnchor.constraint(greaterThanOrEqualTo: safeArea.bottomAnchor, constant: -80),
            button.topAnchor.constraint(equalTo: imageView.topAnchor),
            button.bottomAnchor.constraint(equalTo: caption.bottomAnchor),
            button.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            button.rightAnchor.constraint(equalTo: imageView.rightAnchor),
        ])
        
    }
    
    @objc func fetchNext(_ sender: Any?) {
        fetch()
    }

    private func fetch() {
        catApi.getRandomImage { (imageInfo) in
            if let imageUrlString = imageInfo?["url"] as? String, let imageUrl = URL(string: imageUrlString) {
                let dataTask = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                }
                dataTask.resume()
            }
        }
        catFacts.getRandomFact { (fact) in
            if let fact = fact, let text = fact["text"] as? String {
                DispatchQueue.main.async {
                    self.caption.text = text
                }
            }
        }
        
    }

}

