//
//  PageWebView.swift
//  ReaderTranslator
//
//  Created by Viktor Kushnerov on 10/4/19.
//  Copyright © 2019 Viktor Kushnerov. All rights reserved.
//
import Combine
import SwiftUI
import WebKit

class WKPage: WKWebView {
    @ObservedObject private var store = Store.shared
    private var zoomLevel: CGFloat = 1
        
    @Published var newUrl: String

    private var cancellableSet: Set<AnyCancellable> = []

    init(defaultUrl: String) {
        let config = WKWebViewConfiguration()
        let contentController = WKUserContentController()

        config.userContentController = contentController
        config.websiteDataStore = .nonPersistent()

        self.newUrl = defaultUrl
        super.init(frame: .zero, configuration: config)
    
        if let url = URL(string: defaultUrl) {
            self.load(URLRequest(url: url))
        }
        
        $newUrl
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { url in
                if self.url?.absoluteString.decodeUrl != url {
                    self.evaluateJavaScript("document.documentElement.innerHTML = ''")
                    if let url = URL(string: url.encodeUrl) {
                        self.load(URLRequest(url: url))
                    }else{
                        self.evaluateJavaScript("window.location = 'about:blank'")
                    }
                }
            }
            .store(in: &cancellableSet)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func goBack() {
        super.goBack()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let url = self.url?.absoluteString { self.newUrl = url }
            self.store.canGoBack = self.canGoBack
        }
    }
}

#if os(macOS)
extension WKPage {
//    override func layout() {
//        super.layout()
//        self.frame.size = CGSize(width: frame.width * (1/zoomLevel), height: frame.height * (1/zoomLevel))
//        self.layer?.transform = CATransform3DMakeScale(zoomLevel, zoomLevel, 1)
//    }
//
    func setZoom(zoomLevel: CGFloat) {
//        self.zoomLevel = zoomLevel
//        self.needsLayout = true
    }
}
#else
extension WKPage {
    func setZoom(zoomLevel: CGFloat) {
        self.scrollView.setZoomScale(zoomLevel, animated: true)
        self.scrollView.minimumZoomScale = zoomLevel
//TODO: I don't know to need call it        self.setNeedsDisplay(self.bounds)
    }
}
#endif