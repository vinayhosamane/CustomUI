//
//  CreditScoreUIInputModel.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 28/03/21.
//

import Foundation
import UIKit

public struct CreditScoreUIInput {
    public var score: Double
    public var color: UIColor
    
    public init(score: Double, color: UIColor) {
        self.score = score
        self.color = color
    }
}
