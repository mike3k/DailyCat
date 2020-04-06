//
//  AboutScreen.swift
//  DailyCat
//
//  Created by Mike Cohen on 4/6/20.
//  Copyright © 2020 Mike Cohen. All rights reserved.
//

import UIKit

let info = "<html><body><font size=5><h4 align=center>Daily Cat Facts</h4><p>We all need more cats to get us through these times, so I'm bringing you random cat facts & cute cats to look at.</p><p>Written by Mike Cohen</p><p>Based on two public APIs: <a href='https://github.com/alexwohlbruck/cat-facts'>Cat Facts</a> by Alex Wohlbruck, and <a href='https://thecatapi.com'>The Cat AAPI</a></p></font></body></html>"

class AboutScreen: UIViewController {
    private let aboutView = UITextView()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        aboutView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutView)
        aboutView.backgroundColor = .clear
        aboutView.isEditable = false
        aboutView.isSelectable = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            aboutView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            aboutView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            aboutView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            aboutView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.preferredContentSize = CGSize(width: 500, height: 500)
        // Do any additional setup after loading the view.
        if let htmlData = NSString(string: info).data(using: String.Encoding.utf8.rawValue),
          let attributedString = try? NSMutableAttributedString(data: htmlData,
                                                         options: [.documentType: NSAttributedString.DocumentType.html],
                                                         documentAttributes: nil) {
            attributedString.addAttributes([
                NSAttributedString.Key.backgroundColor: UIColor.clear,
                NSAttributedString.Key.foregroundColor: UIColor.darkText
            ], range: NSRange(location: 0, length: attributedString.length-1))
            aboutView.attributedText = attributedString
        }

    }

}
