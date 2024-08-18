import UIKit

extension CALayer {
    func addGradientColor() {
        let leftColor = UIColor.leftGradientColor
        let centerColor = UIColor.centerGradientColor
        let rightColor = UIColor.rightGradientColor
        let colors = [leftColor, centerColor, rightColor]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame =  bounds
        gradientLayer.startPoint = CGPointMake(0.0, 0.5)
        gradientLayer.endPoint = CGPointMake(1.0, 0.5)
        gradientLayer.colors = colors.map({ $0.cgColor })
        gradientLayer.cornerRadius = 16
        gradientLayer.masksToBounds = true
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 2
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        gradientLayer.mask = shapeLayer
        
        self.insertSublayer(gradientLayer, at: 0)
    }
}
