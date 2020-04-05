//
//  ViewController.swift
//  DailyCat
//
//  Created by Mike Cohen on 4/4/20.
//  Copyright © 2020 Mike Cohen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let caption = UILabel()
    private let nextButton = UIButton(type: .custom)
    private let shareButton = UIButton(type: .custom)
    private let footer = UIView()
    
    
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
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        
        caption.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(caption)
        caption.numberOfLines = 0
        caption.textAlignment = .center
        caption.lineBreakMode = .byWordWrapping
        caption.backgroundColor = .clear
        caption.textColor = .white
        caption.font = .systemFont(ofSize: 18)
        
        footer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(footer)
        footer.backgroundColor = .clear
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        footer.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(fetchNext(_:)), for: .touchUpInside)
        nextButton.setTitle("Next", for: .normal)
        nextButton.tintColor = .white
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        footer.addSubview(shareButton)
        shareButton.addTarget(self, action: #selector(share(_:)), for: .touchUpInside)
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .white
        
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            
            footer.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            footer.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            footer.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            footer.heightAnchor.constraint(equalToConstant: 50),
            
            imageView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            caption.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 10),
            caption.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -10),
            
            nextButton.rightAnchor.constraint(equalTo: footer.rightAnchor, constant: -20),
            nextButton.centerYAnchor.constraint(equalTo: footer.centerYAnchor),
            
            shareButton.leftAnchor.constraint(equalTo: footer.leftAnchor, constant: 20),
            shareButton.centerYAnchor.constraint(equalTo: footer.centerYAnchor),
        ])
        
    }
    
    @objc func fetchNext(_ sender: Any?) {
        fetch()
    }

    @objc func share(_ sender: Any?) {
        var items: [Any] = [caption.text ?? ""]
        if let image: UIImage = imageView.image {
            items.append(image)
        }
        let vc = UIActivityViewController(activityItems: items, applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
    
    private func fetch() {
        var theText: String? = nil
        var theImage: UIImage? = nil
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        catApi.getRandomImage { (imageInfo) in
            if let imageUrlString = imageInfo?["url"] as? String, let imageUrl = URL(string: imageUrlString) {
                let dataTask = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                    if let data = data, let image = UIImage(data: data) {
                        theImage = image
                    }
                    dispatchGroup.leave()
                }
                dataTask.resume()
            }
        }
        
        dispatchGroup.enter()
        catFacts.getRandomFact { (fact) in
            if let fact = fact, let text = fact["text"] as? String {
                theText = text
            }
            dispatchGroup.leave()
        }
  
        dispatchGroup.wait()

        if let theText = theText {
            self.caption.text = theText
        }
        
        if let theImage = theImage {
            self.imageView.image = theImage
        }

    }

}

