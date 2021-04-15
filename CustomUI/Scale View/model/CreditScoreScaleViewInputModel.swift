//
//  CreditScoreScaleViewInputModel.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 28/03/21.
//

import Foundation
import UIKit

public struct CreditScoreScaleViewInput {
    var percentageValue: String
    var scaleContainerViewBGColor: UIColor
    var scaleLabelValue: String
    var shouldShowMarker: Bool
    var markerLabelText: String?
    
    public init(percentageValue: String,
                scaleContainerViewBGColor: UIColor,
                scaleLabelValue: String,
                shouldShowMarker: Bool,
                markerLabelText: String? = nil) {
        self.percentageValue = percentageValue
        self.scaleContainerViewBGColor = scaleContainerViewBGColor
        self.scaleLabelValue = scaleLabelValue
        self.shouldShowMarker = shouldShowMarker
        self.markerLabelText = markerLabelText
    }
}
