//
//  FlexibleHeader.swift
//  FlexibleHeader
//
//  Created by Macbook Pro on 24/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

@objc protocol FlexibleHeaderDelegate : class {
    @objc optional func getHeader(_ percentage : CGFloat)
    @objc optional func getHeaderState( _ state : HeaderState)
}

@objc public enum HeaderState : Int {
    case contracted, expanded, between
}

class FlexibleHeader: UIImageView {
    
    //MARK : Public
    public weak var delegate : FlexibleHeaderDelegate?
    lazy public var headerLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK : Private
    private unowned var scrollView: UIScrollView
    private var statusBarHeight : CGFloat = 0
    private var headerMinHeight: CGFloat = 180
    private var headerMaxHeight : CGFloat = 300
    
    //MARK: Inits
    init(frame: CGRect, scrollView: UIScrollView, image : UIImage) {
        self.scrollView = scrollView
        super.init(frame:frame)
        self.image = image
        setInitialConfig()
    }
    
    init(minHeight : CGFloat, maxHeight : CGFloat, scrollView : UIScrollView, image : UIImage) {
        self.scrollView = scrollView
        headerMinHeight = minHeight
        headerMaxHeight = maxHeight
        let initialFrame = CGRect(origin: CGPoint(x: 0, y: -headerMaxHeight), size: CGSize(width: scrollView.frame.width, height: headerMaxHeight))
        super.init(frame:initialFrame)
        self.image = image
        setInitialConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setInitialConfig() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        self.scrollView.contentInset.top += headerMaxHeight
        self.scrollView.insertSubview(self, at: 0)
        self.addSubview(self.headerLabel)
        headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant : -16).isActive = true
        headerLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant : 16).isActive = true
        headerLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}

extension FlexibleHeader: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let difference = headerMaxHeight - headerMinHeight
        var visibleHeigh = max(-(scrollView.contentOffset.y + scrollView.contentInset.top),-(difference - statusBarHeight))
        if statusBarHeight == 0 {
            statusBarHeight = visibleHeigh
            self.scrollView.contentInset.top -= statusBarHeight
            return
        }
        visibleHeigh -= statusBarHeight
        let ratio = superview!.frame.width / headerMaxHeight
        let newHeight =  headerMaxHeight + visibleHeigh
        bounds.size = CGSize(width: superview!.frame.width * ratio, height: newHeight)
        frame.origin.y = scrollView.contentOffset.y
        
        let percentage = min(1,  1 + (visibleHeigh / difference))
        let state : HeaderState
        if percentage == 1 {
            state = .expanded
        } else if percentage == 0{
            state = .contracted
        } else {
            state = .between
        }
        delegate?.getHeaderState?(state)
        delegate?.getHeader?(percentage)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
}

