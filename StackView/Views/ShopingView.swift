//
//  ShopingView.swift
//  StackView
//
//  Created by Harbros47 on 15.02.21.
//

import UIKit

private enum Constatnts {
    static let helpValue: CGFloat = 20
    static let fontSizeLabel: CGFloat = 13
    static let helpDividendHeight: CGFloat = 2.8
    static let differenceSizeHeightCell: CGFloat = 10
    static let globalValue = 4
}

class ShopingView: UIView {
    
    private let scrollView = UIScrollView()
    private let shopingStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(scrollView)
        scrollView.addSubview(shopingStackView)
        registerForKeyboardNotifications()
    }
    
    func setup(data: [Phone], numberOfIterations: Int) {
        
        shopingStackView.arrangedSubviews.forEach { view in
            shopingStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for _ in 1...numberOfIterations {
            let oneView = createFirstView(
                frame: CGRect(
                    x: .zero,
                    y: .zero,
                    width: bounds.width,
                    height: bounds.height
                ),
                informationProduct: data
            )
            shopingStackView.addArrangedSubview(oneView)
        }
        shopingStackView.axis = .vertical
        shopingStackView.alignment = .fill
        shopingStackView.distribution = .fillEqually
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame = CGRect(
            origin: CGPoint(x: bounds.origin.x, y: bounds.origin.y + Constatnts.helpValue),
            size: bounds.size
        )
        let count: CGFloat = CGFloat(shopingStackView.subviews.count)
        shopingStackView.frame = CGRect(
            origin: CGPoint(x: bounds.origin.x, y: bounds.origin.y),
            size: .init(
                width: bounds.width,
                height: (count * (bounds.height / Constatnts.helpDividendHeight))
            )
        )
        scrollView.contentSize = shopingStackView.frame.size
        scrollView.isPagingEnabled = true
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(kbWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(kbWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        guard let size = kbFrameSize else { return }
        scrollView.contentInset.bottom = size.height
    }
    
    @objc private func kbWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = .zero
    }
    
    private func createFirstView(frame: CGRect, informationProduct: [Phone]) -> UIStackView {
        
        let shopingStackView = UIStackView(frame: frame)
        shopingStackView.distribution = .fillEqually
        var x: CGFloat = .zero
        for product in informationProduct {
            let stackView = createPhoneStackView(
                frame: CGRect(
                    x: x,
                    y: .zero,
                    width: bounds.width / CGFloat(Constatnts.globalValue),
                    height: (bounds.height / Constatnts.helpDividendHeight) - Constatnts.helpValue
                ),
                informationProduct: product
            )
            shopingStackView.addSubview(stackView)
            x += bounds.width / CGFloat(Constatnts.globalValue)
        }
        
        if shopingStackView.subviews.count < Constatnts.globalValue {
            let view = UIView(
                frame: CGRect(
                    x: x,
                    y: .zero,
                    width: bounds.width / CGFloat(Constatnts.globalValue),
                    height: (bounds.height / Constatnts.helpDividendHeight) - Constatnts.helpValue
                )
            )
            shopingStackView.addSubview(view)
            x += bounds.width / CGFloat(Constatnts.globalValue)
        }
        x = .zero
        
        return shopingStackView
    }
    
    private func createLabel(x: CGFloat, y: CGFloat, textLabel: String, font: UIFont) -> UILabel {
        let label = UILabel(
            frame: CGRect(
                x: x,
                y: y,
                width: shopingStackView.frame.width,
                height: Constatnts.differenceSizeHeightCell
            )
        )
        label.font = font
        label.text = textLabel
        
        return label
    }
    
    private func getImageView(nameImage: String) -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: nameImage)
        
        return imageView
    }
    
    private func createPhoneStackView(frame: CGRect, informationProduct: Phone) -> UIStackView {
        
        let shopingStackView = UIStackView(frame: frame)
        shopingStackView.axis = .vertical
        shopingStackView.alignment = .fill
        shopingStackView.distribution = .equalSpacing
        shopingStackView.addArrangedSubview(getImageView(nameImage: "image1"))
        
        let price = createLabel(
            x: .zero,
            y: .zero,
            textLabel: "\(informationProduct.price)",
            font: UIFont.systemFont(ofSize: Constatnts.fontSizeLabel, weight: .bold)
        )
        shopingStackView.addArrangedSubview(price)
        
        let name = createLabel(
            x: .zero,
            y: .zero,
            textLabel: informationProduct.name,
            font: UIFont.systemFont(ofSize: Constatnts.differenceSizeHeightCell, weight: .light)
        )
        shopingStackView.addArrangedSubview(name)
        
        return shopingStackView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
