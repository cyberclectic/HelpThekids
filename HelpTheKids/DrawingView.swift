//
//  DrawingView.swift
//  HelpTheKids
//
//  Created by Gerald Wood on 4/18/19.
//  Copyright © 2019 Gerald Wood. All rights reserved.
//

import UIKit

protocol DrawingProtocol
{
    func touchDidMoveToOutSideThePath(str:String)
}

class DrawingView: UIView {

    var bezierPath:UIBezierPath?, path:UIBezierPath?
    var startPoint:CGPoint?
    var pts = [CGPoint?](repeating: nil, count: 5)
    var ctr = 0;
    var delegate:DrawingProtocol! = nil
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        path = UIBezierPath()
    }
    
    func createShape()
    {
        let center: CGPoint = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        
        
        bezierPath = UIBezierPath()
        bezierPath?.move(to: CGPoint(x: center.x-100, y: center.y-100))
        bezierPath?.addLine(to: CGPoint(x: center.x+100, y: center.y-100))
        bezierPath?.addLine(to: CGPoint(x: center.x+100, y: center.y+100))
        bezierPath?.addLine(to: CGPoint(x: center.x-100, y: center.y+100))
        bezierPath?.close()
        UIColor.black.setStroke()
        bezierPath?.stroke()
    }

    override func draw(_ rect: CGRect) {
        
        createShape()
        
        /// pen
        path?.lineWidth = 8
        UIColor.blue.setStroke()
        path?.stroke()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        ctr = 0;
        
        if let touch = touches.first {
            
            startPoint = touch.location(in: self)
            pts[0] = startPoint
            
        }
        super.touchesBegan(touches , with:event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
           
            let endPoint:CGPoint = touch.location(in: self)
            
            if(!bezierPath!.contains(endPoint))
            {
                delegate.touchDidMoveToOutSideThePath(str: "Outside")
            }
            else
            {
                delegate.touchDidMoveToOutSideThePath(str: "Inside")
            }
            
            ctr += 1;
            pts[ctr] = endPoint;
            if (ctr == 4)
            {
                // move the endpoint to the middle of the line joining the second control point of the first Bezier segment and the first control point of the second Bezier segment
                pts[3] = CGPoint(x: (pts[2]!.x + pts[4]!.x)/2.0, y: (pts[2]!.y + pts[4]!.y)/2.0);
                path!.move(to: pts[0]!);
                path?.addCurve(to: pts[3]!, controlPoint1: pts[1]!, controlPoint2: pts[2]!)
                
                self.setNeedsDisplay();
                // replace points and get ready to handle the next segment
                pts[0] = pts[3];
                pts[1] = pts[4];
                ctr = 1;
            
            }
        super.touchesBegan(touches , with:event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
