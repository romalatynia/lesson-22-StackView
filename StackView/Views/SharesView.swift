//
//  SharesView.swift
//  StackView
//
//  Created by Harbros47 on 15.02.21.
//

import UIKit
private enum Constants {
    static let labelText = "* условия акции внутри"
    static let helpValue: CGFloat = 2
    static let helpSizeShares: CGFloat = 30
    static let helpSizeValue: CGFloat = 8
    static let helpLabelSize: CGFloat = 5
    static let heightPageControl: CGFloat = 15
    static let heightLabel: CGFloat = 10
    static let globalValue: CGFloat = 4
    static let helpValueWidthLabel: CGFloat = 3
}

class SharesView: UIView {
    
    private let scrollView = UIScrollView()
    private let sharesStackView = UIStackView()
    private var pageControl = UIPageControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView.delegate = self
        addSubview(scrollView)

        sharesStackView.backgroundColor = .systemGray
        sharesStackView.axis = .horizontal

        sharesStackView.addArrangedSubview(getImgageView(nameImage: "image2"))
        sharesStackView.addArrangedSubview(getImgageView(nameImage: "image3"))
        sharesStackView.addArrangedSubview(getImgageView(nameImage: "image4"))
        sharesStackView.addArrangedSubview(getImgageView(nameImage: "image5"))

        sharesStackView.alignment = .center
        sharesStackView.distribution = .fillEqually
        scrollView.addSubview(sharesStackView)
        
        createLabel()
        createPageControl()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame = bounds
        let count: CGFloat = CGFloat(sharesStackView.arrangedSubviews.count)
        sharesStackView.frame = CGRect(
            origin: .zero,
            size: .init(width: count * bounds.width, height: bounds.height - Constants.helpSizeShares)
        )
        scrollView.contentSize = sharesStackView.frame.size
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    private func createLabel() {
        let label = UILabel(
            frame: CGRect(
                x: Constants.helpLabelSize,
                y: bounds.height - Constants.helpSizeShares + Constants.helpLabelSize,
                width: frame.width / Constants.helpValueWidthLabel ,
                height: Constants.heightLabel
            )
        )
        
        label.font = UIFont.systemFont(ofSize: Constants.helpSizeValue, weight: .light)
        label.tintColor = .systemGray
        label.text = Constants.labelText
        addSubview(label)
    }
    
    @objc private func changePage(sender: AnyObject) {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: .zero), animated: true)
    }
    
    private func getImgageView(nameImage: String) -> UIImageView {
        let imageView = UIImageView(
            frame: CGRect(
                origin: .zero,
                size: .init(width: bounds.width, height: bounds.height)
            )
        )
        imageView.image = UIImage(named: nameImage)
        
        return imageView
    }
    
    private func createPageControl() {
        let pageControl = UIPageControl(
            frame: CGRect(
                x: bounds.maxX / Constants.globalValue,
                y: bounds.height - Constants.helpSizeShares + Constants.helpLabelSize,
                width: bounds.width / Constants.helpValue,
                height: Constants.heightPageControl
            )
        )
        pageControl.addTarget(self, action: #selector(changePage), for: .valueChanged)
        pageControl.autoresizingMask = [
            .flexibleHeight,
            .flexibleWidth
        ]
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = .blue
        pageControl.numberOfPages = sharesStackView.arrangedSubviews.count
        self.pageControl = pageControl
        addSubview(pageControl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SharesView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
