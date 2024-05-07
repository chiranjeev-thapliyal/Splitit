//
//  RemoteSVGView.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 07/05/24.
//

import SwiftUI
import SVGKit

struct RemoteSVGView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> SVGKFastImageView {
        SVGKFastImageView(frame: .zero)
    }

    func updateUIView(_ uiView: SVGKFastImageView, context: Context) {
        DispatchQueue.global().async {
            if let svgImage = SVGKImage(contentsOf: url) {
                DispatchQueue.main.async {
                    uiView.image = svgImage
                }
            }
        }
    }
}
