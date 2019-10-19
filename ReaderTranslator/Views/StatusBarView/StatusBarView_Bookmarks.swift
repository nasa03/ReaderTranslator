//
//  StatusBarView_Safari.swift
//  ReaderTranslator
//
//  Created by Viktor Kushnerov on 10/5/19.
//  Copyright © 2019 Viktor Kushnerov. All rights reserved.
//

import SwiftUI

struct StatusBarView_Bookmarks: View {
    @EnvironmentObject var store: Store
    @State var show: Bool = false
    
    var body: some View {
        Group {
            Divider().fixedSize()
            self.bookmarkView
            Button(action: { self.show = true } ) { Text(show ? "􀉛" : "􀉚") }
        }
        .sheet(isPresented: $show) {
            self.listView
        }
    }
    
    private var bookmarkView: some View {
        let text = self.store.translateAction.getText()
        
        return Group {
            if text != "" {
                if self.store.bookmarks.contains(text) {
                    Button(action: {
                        self.store.bookmarks.remove(object: text)
                    }) { Text("􀉟") }
                }else{
                    Button(action: {
                        self.store.bookmarks.append(text)
                    }) { Text("􀉞") }
                }
            }else{
                EmptyView()
            }
        }
    }
    
    private var listView: some View {
        VStack {
            ForEach(self.store.bookmarks, id: \.self) { text in
                Text("\(text)").onTapGesture {
                    self.store.translateAction = .translator(text: text)
                    self.show = false
                }
            }
            HStack {
                Button(action: {
                    Clipboard.copy(self.store.bookmarks.joined(separator: "\n"))
                } ) { Text("􀉃") }
                Button(action: { self.show = false} ) { Text("􀁠") }
            }
        }
    }
}
