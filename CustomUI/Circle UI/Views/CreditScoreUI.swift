//
//  CreditScoreUI.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 25/03/21.
//
import UIKit
import Foundation

public protocol CreditScoreExternalInterface {
    func configure(with config: CreditScoreUIInput)
}

// this class is responsible for building credit score circle UI.
@IBDesignable
public class CreditScoreUI: UIView, CreditScoreExternalInterface {
    
    private var strokeColor = ColorUtils.strokeColor
    
    // score received from report
    private var creditScore: CGFloat = 0.0

    // it is in percentage
    private var myCreditScore: CGFloat = 0.0
    
    // start angle for the arc
    private lazy var startAngle: CGFloat = {
        return 0 + CGFloat.pi / 2 // pi starts at 180 degree from right, so I have move it down to 90 degree
    }()
    
    // end angle for the arc
    private lazy var endAngle: CGFloat = {
        return 2 * CGFloat.pi // it has to be 270 degree
    }()
    
    // gives radius of the arc
    private lazy var radius: CGFloat = {
        let halfSize: CGFloat = min(bounds.size.width/2, bounds.size.height/2)
        let desiredLineWidth: CGFloat = 30.0
        return halfSize - (desiredLineWidth / 2) - 4.0 // we have to calculate this from the arc size..need to think out loud.
    }()
    
    private var circleShapeLayer: CAShapeLayer!
    private var circleMaskShapeLayer: CAShapeLayer!

    // gives another arc layer to mimic the empty or un-filled state.
    private lazy var maskLayer: (_ rect: CGRect, _ radius: CGFloat, _ startAngle: CGFloat, _ endAngle: CGFloat) -> CAShapeLayer = { (rect, radius, startAngle, endAngle) in
        let maskLayer = CAShapeLayer()
        maskLayer.fillColor = ColorUtils.arcFillingColor

        let circularPath = UIBezierPath(arcCenter: self.getViewCenter(for: rect), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        circularPath.fill()

        maskLayer.path = circularPath.cgPath
        maskLayer.strokeColor = ColorUtils.emptyStrokeColor
        maskLayer.lineWidth = Constants.strokeLineWidth
        maskLayer.lineCap = .square

        return maskLayer
    }
    
    private lazy var circleLayer: (_ rect: CGRect, _ radius: CGFloat, _ startAngle: CGFloat, _ endAngle: CGFloat) -> CAShapeLayer = { (rect, radius, startAngle, endAngle) in
        // stroked circle
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = ColorUtils.arcFillingColor

        let circularPath = UIBezierPath(arcCenter: self.getViewCenter(for: rect), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        circularPath.fill()
        shapeLayer.path = circularPath.cgPath

        shapeLayer.strokeColor = self.strokeColor
        shapeLayer.lineWidth = Constants.strokeLineWidth
        shapeLayer.strokeEnd = Constants.strokeEnd
        shapeLayer.lineCap = .square

        return shapeLayer
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //setup()
    }
    
//    private func setup() {
//        // let's set the corner radius to look like circle.
//        layer.cornerRadius = frame.width / 2
//
//        // let add circle and it's mask to the layer.
//        let belowLayer = maskLayer(frame, radius, startAngle, endAngle)
//        let strokeLayer = circleLayer(frame, radius, startAngle, endAngle)
//
//        self.layer.addSublayer(belowLayer)
//
//        // stroked circle
//        self.layer.addSublayer(strokeLayer)
//
//        // let's add some animation
//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        animation.toValue = myCreditScore
//        animation.duration = 2
//        animation.fillMode = .forwards
//        animation.isRemovedOnCompletion = false
//
//        strokeLayer.add(animation, forKey: "basicAnimation")
//    }
    
    public override func draw(_ rect: CGRect) {
        // let's set the corner radius to look like circle.
        layer.cornerRadius = frame.width / 2
        
        // we should manually set background color if view is drawn inside draw rect.
        UIColor.white.setFill()

        // let add circle and it's mask to the layer.
        circleShapeLayer = maskLayer(frame, radius, startAngle, endAngle)
        circleMaskShapeLayer = circleLayer(frame, radius, startAngle, endAngle)

        self.layer.addSublayer(circleShapeLayer)
        
        // stroked circle
        self.layer.addSublayer(circleMaskShapeLayer)
        
        // let's add some animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = myCreditScore
        animation.duration = 2
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false

        circleMaskShapeLayer.add(animation, forKey: "basicAnimation")
       // we can use either draw rect or CSLayer to draw some custome or heirarchiel views into the parent view.
       // this might be slower than drawing in the CALayer.
    }
    
    public func configure(with config: CreditScoreUIInput) {
        // set credit score in the view state and re-draw the view.
        myCreditScore = CGFloat((config.score - 300.0) / 600.0)
        strokeColor = config.color.cgColor
        creditScore = CGFloat(config.score)
        // re-draw layers
        //setup()
        self.setNeedsDisplay()
    }
    
}

extension CreditScoreUI {

    // returns arc radius, calculated from drawn view bounds size.
    fileprivate func getRadius(for rect: CGRect) -> CGFloat {
        return rect.width / 2
    }
    
    // returns center of the view for arc circl to calculate the angle.
    fileprivate func getViewCenter(for rect: CGRect) -> CGPoint {
        return CGPoint(x: rect.width / 2, y: rect.height / 2)
    }
    
}
