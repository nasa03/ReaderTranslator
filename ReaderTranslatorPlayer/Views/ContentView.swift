//
//  ContentView.swift
//  ReaderTranslatorPlayer
//
//  Created by Viktor Kushnerov on 29/11/19.
//  Copyright © 2019 Viktor Kushnerov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store = APStore.shared

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                PlayerControlsView()
                FileListView()
                BookmarksView()
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(store.hideNavBar)
            .onAppear { self.store.hideNavBar = true }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @ObservedObject var store = APStore.shared
    
    init() {
//        let bookmarks: Bookmarks = [
//            .init(counter: 1, text: "work 1", created: Date(), changed: Date()),
//            .init(counter: 1, text: "work 2", created: Date(), changed: Date()),
//            .init(counter: 1, text: "work 3", created: Date(), changed: Date())
//        ]
//        if store.bookmarks.isEmpty { store.bookmarks = bookmarks }
    }
    
    static var previews: some View {
        ContentView()
    }
}
