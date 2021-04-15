//
//  ScaleMarkerViewUIInputModel.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 28/03/21.
//

import Foundation
import UIKit

public struct ScaleMarkerViewUIInput {
    var bgColor: UIColor
    var markerLabeltext: String
    
    public init(bgColor: UIColor, markerLabeltext: String) {
        self.bgColor = bgColor
        self.markerLabeltext = markerLabeltext
    }
}
