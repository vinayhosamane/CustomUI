//
//  CircleUI.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 29/03/21.
//

import Foundation
import UIKit

public class CircleUI: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var creditScoreView: CreditScoreUI!
    
    @IBOutlet weak var centerLabel: UILabel!
    
    @IBOutlet weak var arcStartLabel: UILabel!
    @IBOutlet weak var arcEndLabel: UILabel!
    
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
    
    private func configure() {
        guard let view = self.loadViewFromNib(nibName: String(describing: CircleUI.self)) else {
            return
        }
        contentView = view
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    public func configure(with config: CreditScoreUIInput) {
        // set credit score in the view state and re-draw the view.
        creditScoreView.configure(with: config)
        
        centerLabel.text = "\(Int(config.score))"
        centerLabel.textColor = config.color
    }
}

extension UIView {

    func loadViewFromNib(nibName name: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
