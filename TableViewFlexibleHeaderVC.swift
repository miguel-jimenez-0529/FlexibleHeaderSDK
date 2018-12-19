//
//  ViewController.swift
//  FlexibleHeader
//
//  Created by Macbook Pro on 24/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

enum HeaderSize  {
    case custom(CGFloat)
    case navigationHeader(UINavigationBar)
    
    func getSize() -> CGFloat {
        switch self {
        case .custom( let value ): return value
        case .navigationHeader(let navBar): return navBar.bounds.height + UIApplication.shared.statusBarFrame.height
        }
    }
}

class TableViewFlexibleHeaderVC: UITableViewController {
    //MARK : Private
    private var header : FlexibleHeader?
    
    //MARK: Public
    public var image : UIImage = #imageLiteral(resourceName: "pepperoni pizza")
    public var headerTitle : String?
    public var maxHeaderSize : CGFloat = 300
    lazy public var minHeaderSize = HeaderSize.navigationHeader(self.navigationController!.navigationBar)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.title = headerTitle
    }
    
    func insertImage() {
        header = FlexibleHeader(minHeight: minHeaderSize.getSize(), maxHeight: maxHeaderSize, scrollView: tableView, image: image)
        header?.delegate = self
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        header?.scrollViewDidScroll(scrollView)
    }
}

extension TableViewFlexibleHeaderVC : FlexibleHeaderDelegate {
    func getHeaderState(_ state: HeaderState) {
        switch state {
        case .contracted:
            self.navigationController?.isNavigationBarHidden = false
            header?.headerLabel.text = ""
        case .expanded, .between:
            header?.headerLabel.text = headerTitle
            self.navigationController?.isNavigationBarHidden = true
        }
    }
}

