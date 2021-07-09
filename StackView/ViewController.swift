//
//  ViewController.swift
//  StackView
//
//  Created by Harbros47 on 22.02.21.
//

import UIKit

private enum Constants {
    static let heightSearchbar: CGFloat = 44
    static let placeholder = "Я ищу..."
    static let helpOriginYSearchBar: CGFloat = 40
    static let helpSharesValue: CGFloat = 3.5
    static let helpShopingValue: CGFloat = 1.8
    static let helpAdvertisingValue: CGFloat = 6.4
    static let labelText = "Хиты продаж"
    static let helpValue: CGFloat = 20
    static let fontSize: CGFloat = 16
    static let helpOriginXLabel: CGFloat = 5
}

class ViewController: UIViewController {
    
    var mainView = UIView()
    var searchBar = UISearchBar()
    var shareView = UIView()
    var mainScrollView = UIScrollView()
    var shopingView = ShopingView(frame: .zero)
    var advertising = UIView()
    var search = [Phone]()
    var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addTapGestureToHideKeyboard()
        
        searchBar = UISearchBar(
            frame: CGRect(
                x: .zero,
                y: view.safeAreaInsets.top + Constants.helpOriginYSearchBar,
                width: view.frame.width,
                height: Constants.heightSearchbar
            )
        )
        searchBar.autoresizingMask = [
            .flexibleTopMargin,
            .flexibleBottomMargin
        ]
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        createMainView()
    }
    
    private func createMainView() {
        
        mainView = UIView(
            frame: CGRect(
                x: .zero,
                y: searchBar.frame.origin.y + searchBar.frame.height,
                width: view.frame.width,
                height: view.frame.height - searchBar.frame.maxY
            )
        )
        mainView.backgroundColor = .darkGray
        
        shareView = SharesView(
            frame: CGRect(
                x: .zero,
                y: .zero,
                width: mainView.frame.width,
                height: mainView.frame.height / Constants.helpSharesValue
            )
        )
        shareView.backgroundColor = .white
        mainView.addSubview(shareView)
        
        newShopingView()
        
         advertising = AdvertisingView(
            frame: CGRect(
                x: .zero,
                y: shopingView.frame.maxY,
                width: mainView.frame.width,
                height: mainView.frame.height / Constants.helpAdvertisingValue
            )
        )
        advertising.backgroundColor = .white
        mainView.addSubview(advertising)
        view.addSubview(mainView)
    }
    
    private func newShopingView() {
        
        shopingView.frame = CGRect(
            x: .zero,
            y: shareView.frame.maxY,
            width: mainView.frame.width,
            height: mainView.frame.height / Constants.helpShopingValue
        )
        shopingView.backgroundColor = .white
        
        if searching {
            let iteration: Double = Double(search.count).rounded(.awayFromZero) / 4
            let cycle = iteration.rounded(.awayFromZero)
            print(cycle)
            shopingView.setup(data: search, numberOfIterations: Int(cycle))
        } else {
            shopingView.setup(data: Shoping.setup(), numberOfIterations: 4)
        }
        mainView.addSubview(shopingView)
        
        let label = UILabel(
            frame: CGRect(
                x: Constants.helpOriginXLabel,
                y: .zero,
                width: shopingView.frame.width,
                height: Constants.helpValue
            )
        )
        label.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .bold)
        label.text = Constants.labelText
        shopingView.addSubview(label)
    }
}

extension UIView {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        addGestureRecognizer(tapGesture)
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.placeholder = Constants.placeholder
        searchBar.setShowsCancelButton(true, animated: true)
        
        mainScrollView.isScrollEnabled = true
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        mainScrollView.isScrollEnabled = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        mainScrollView.isScrollEnabled = false
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let arrayShoping = Shoping.createArrayPhone()
        search = arrayShoping
            .filter { $0.name.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        print(search)
        newShopingView()
        mainView.addSubview(advertising)
        search = [Phone]()
        if searchText.isEmpty {
            searching = false
            shopingView.setNeedsLayout()
            newShopingView()
            mainView.addSubview(advertising)
        }
    }
}
