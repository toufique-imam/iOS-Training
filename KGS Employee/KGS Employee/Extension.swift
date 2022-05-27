//
//  UITextFieldWIconBorder.swift
//  KGS Employee
//
//  Created by Nuhash on 5/19/22.
//

import UIKit

extension UITextField {
    func setLeftIcon(iconName : String){
        self.leftView = UIView(frame: CGRect(x: 10, y: 0, width: 40, height: 40))
        self.leftViewMode = .always
        //self.leftView?.backgroundColor = .blue
        let leftViewItSelf = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        leftViewItSelf.contentMode = .scaleAspectFit
        leftViewItSelf.image = UIImage(named: iconName)
        leftView?.addSubview(leftViewItSelf)
    }
    func roundBorder(){
        self.borderStyle = .roundedRect
        
        // self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.darkText.cgColor
        
    }
}

extension UIView {
    
    enum ShadowPath{
        case top
        case bottom
        case left
        case right
    }
    
    func getPath(for arr: [ShadowPath]) -> CGPath{
        let cgPath: CGMutablePath = CGMutablePath()
        if(arr.contains(.top)) {
            var boundNow:CGRect = self.bounds
            boundNow.size.height = 5
            let path = UIBezierPath.init( rect: boundNow).cgPath
            cgPath.addPath(path)
        }
        if(arr.contains(.bottom)){
            var boundNow:CGRect = self.bounds
            boundNow.origin.y += boundNow.size.height
            boundNow.size.height = 5
            let path = UIBezierPath.init( rect: boundNow).cgPath
            cgPath.addPath(path)
        }
        if(arr.contains(.left)){
            var boundNow:CGRect = self.bounds
            boundNow.size.width = 5
            let path = UIBezierPath.init( rect: boundNow).cgPath
            cgPath.addPath(path)
        }
        if(arr.contains(.right)){
            var boundNow:CGRect = self.bounds
            boundNow.origin.x += boundNow.size.width
            boundNow.size.width = 5
            let path = UIBezierPath.init( rect: boundNow).cgPath
            cgPath.addPath(path)
        }
        return cgPath
    }
    

    func dropShadowPath(_ bounds: CGPath, color : UIColor , opacity : Float = 0.5 , offset : CGSize , radius : CGFloat = 1 , scale : Bool = true){
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowPath = bounds
        layer.shouldRasterize = false
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadow(color : UIColor , opacity : Float = 0.5 , offset : CGSize , radius : CGFloat = 1 , scale : Bool = true){
        let path = UIBezierPath(rect: self.bounds).cgPath
        dropShadowPath(path, color: color, opacity: opacity, offset: offset, radius: radius, scale: scale)
    }
    
    func dropShadowHalfRounded(color : UIColor , opacity : Float = 0.5 , offset : CGSize , radius : CGFloat = 1 , scale : Bool = true){
        
        let path = UIBezierPath(arcCenter: CGPoint(x: layer.bounds.width / 2, y: layer.bounds.height / 2), radius: layer.frame.width / 2 , startAngle: 0.14, endAngle: 3.0, clockwise: true).cgPath
        dropShadowPath(path, color: color, opacity: opacity, offset: offset, radius: radius, scale: scale)
   }
    func dropShadowRounded(color : UIColor , opacity : Float = 0.5 , offset : CGSize , radius : CGFloat = 1 , scale : Bool = true){
        let path = UIBezierPath.init(ovalIn: self.bounds).cgPath
        dropShadowPath(path, color: color, opacity: opacity, offset: offset, radius: radius, scale: scale)
    }
    func dropShadowRectTop(color: UIColor , opacity : Float = 0.5 , offset :CGSize , radius : CGFloat = 1 , scale : Bool = true){
        var boundNow:CGRect = self.bounds
        boundNow.size.height = 5
        let path = UIBezierPath.init( rect: boundNow).cgPath
        dropShadowPath(path, color: color, opacity: opacity, offset: offset, radius: radius, scale: scale)
    }
    
    func dropShadowRectBottom(color: UIColor , opacity : Float = 0.5 , offset :CGSize , radius : CGFloat = 1 , scale : Bool = true){
        var boundNow:CGRect = self.bounds
        boundNow.origin.y += boundNow.size.height+5
        boundNow.size.height = 5
        let path = UIBezierPath.init( rect: boundNow).cgPath
        dropShadowPath(path, color: color, opacity: opacity, offset: offset, radius: radius, scale: scale)
    }
    
    func dropShadowRectLeading(color: UIColor , opacity : Float = 0.5 , offset :CGSize , radius : CGFloat = 1 , scale : Bool = true){
        var boundNow:CGRect = self.bounds
        boundNow.size.width = 5
        let path = UIBezierPath.init( rect: boundNow).cgPath
        dropShadowPath(path, color: color, opacity: opacity, offset: offset, radius: radius, scale: scale)
    }
    
    
    func dropShadowRectTrailing(color: UIColor , opacity : Float = 0.5 , offset :CGSize , radius : CGFloat = 1 , scale : Bool = true){
        var boundNow:CGRect = self.bounds
        boundNow.origin.x += boundNow.size.width+5
        boundNow.size.width = 5
        let path = UIBezierPath.init( rect: boundNow).cgPath
        dropShadowPath(path, color: color, opacity: opacity, offset: offset, radius: radius, scale: scale)
    }
}

extension UIView{
    // For insert layer in background
    func addBlackGradientLayerInBackground(frame: CGRect, colors:[UIColor] , cornerRadius : CGFloat? = nil ){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        gradient.startPoint  = CGPoint.zero
        gradient.masksToBounds = true
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        if let cornerRadius = cornerRadius {
            gradient.cornerRadius = cornerRadius
        }
        layer.insertSublayer(gradient, at: 0)
    }
}

extension UIButton {
    func loadFont(fontName:String , size : CGFloat = 14){
        if let customFont = UIFont(name: fontName, size: size) {
            self.titleLabel?.font = UIFontMetrics.default.scaledFont(for: customFont)
        } else {
            print("""
                Failed to load the "\(fontName)" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
    }
}
