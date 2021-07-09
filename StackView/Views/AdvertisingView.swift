//
//  AdvertisingView.swift
//  StackView
//
//  Created by Harbros47 on 15.02.21.
//

import UIKit

class AdvertisingView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let advertisingView = UIStackView(
            frame: CGRect(
                x: bounds.origin.x,
                y: bounds.origin.y,
                width: bounds.width,
                height: bounds.height
            )
        )
        advertisingView.axis = .horizontal
        let imageView = UIImageView(frame: bounds)
        imageView.image = UIImage(named: "image4") ?? UIImage()
        advertisingView.addArrangedSubview(imageView)
        let imageView2 = UIImageView(frame: bounds)
        imageView2.image = UIImage(named: "image5") ?? UIImage()
        advertisingView.addArrangedSubview(imageView2)
        advertisingView.alignment = .center
        advertisingView.distribution = .fillEqually
        advertisingView.spacing = 5
        addSubview(advertisingView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
