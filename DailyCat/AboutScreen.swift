//
//  AboutScreen.swift
//  DailyCat
//
//  Created by Mike Cohen on 4/6/20.
//  Copyright © 2020 Mike Cohen. All rights reserved.
//

import UIKit

let info = "<html><body><font size=5><h4 align=center>Daily Cat Facts</h4><p>We all need more cats to get us through these times, so I'm bringing you random cat facts & cute cats to look at.</p><p>Written by Mike Cohen</p><p>Based on two public APIs: <a href='https://github.com/alexwohlbruck/cat-facts'>Cat Facts</a> by Alex Wohlbruck, and <a href='https://thecatapi.com'>The Cat API</a></p></font></body></html>"

class AboutScreen: UIViewController {
    private let aboutView = UITextView()
    private let backgroundView = UIView()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .clear
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 10;
        backgroundView.layer.borderColor = UIColor.black.cgColor
        backgroundView.layer.borderWidth = 0.5
        backgroundView.clipsToBounds  =  true

        aboutView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutView)
        aboutView.backgroundColor = .clear
        aboutView.isEditable = false
        aboutView.isSelectable = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            backgroundView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            backgroundView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundView.heightAnchor.constraint(equalTo: aboutView.widthAnchor),
            
            aboutView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 5),
            aboutView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 5),
            aboutView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -5),
            aboutView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -5),
        ])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapHandler(_ sender: UITapGestureRecognizer) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let htmlData = NSString(string: info).data(using: String.Encoding.utf8.rawValue),
          let attributedString = try? NSMutableAttributedString(data: htmlData,
                                                         options: [.documentType: NSAttributedString.DocumentType.html],
                                                         documentAttributes: nil) {
            aboutView.attributedText = attributedString
        }

    }

}
