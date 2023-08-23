//
//  ContentView.swift
//  DailyCat2
//
//  Created by Mike Cohen on 6/8/23.
//  Copyright © 2023 Mike Cohen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var catFacts = CatFacts()
    @ObservedObject var catImage = CatApi()
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: catImage.imageInfo?.url ?? ""), scale: 1.0, content: { image in
                image.resizable().aspectRatio(contentMode: .fit)
            }) {
                ProgressView()
            }
            Text(catFacts.fact?.text ?? "")
            Spacer()
            HStack {
                Spacer()
                Button(action:{
                    catFacts.reload()
                    catImage.reload()

                }) {
                    Text("Next")
                    Image(systemName: "arrow.triangle.2.circlepath")
                }
            }
            .scenePadding()
        }
        .padding()
        .onAppear() {
            catFacts.reload()
            catImage.reload()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
