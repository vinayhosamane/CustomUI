//
//  SearchScoreView.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 27/03/21.
//

import Foundation
import UIKit

public protocol ActionDelegate: class {
    func searchButtonClicked()
}

@IBDesignable
public class SearchScoreView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchLabel: BaselineAlignedLabel!
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    
    weak var delegate: ActionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    public override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        delegate?.searchButtonClicked()
    }
    
    public func configure(with delegate: ActionDelegate? = nil) {
        guard let view = self.loadViewFromNib(nibName: String(describing: SearchScoreView.self)) else {
            return
        }
        contentView = view
        addSubview(contentView)
        contentView.frame = self.bounds
        
        // let's add underline to the label
        let attributedString = NSMutableAttributedString(string: searchLabel.text ?? "See My Score Analysis")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange(location: 0, length: attributedString.length))
        
        searchLabel.attributedText = attributedString
        searchLabel.sizeToFit()
        
        self.delegate = delegate
        
        view.bringSubviewToFront(searchButton)
    }
    
}

