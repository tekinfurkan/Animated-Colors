//
//  ViewController.swift
//  Animated-Colors
//
//  Created by Furkan Tekin on 26.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let cellPerRow = 15
    var cellLocations = [String : UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenHeight = view.frame.height
        let oneEdge = view.frame.width / CGFloat(cellPerRow)
        let cellPerColumn = screenHeight / oneEdge
        
        
        
        for j in 0...Int(cellPerColumn) {
            for i in 0...cellPerRow {
                let colorCell = UIView()
                colorCell.backgroundColor = randomColor()
                colorCell.layer.borderWidth = 0.5
                colorCell.frame = CGRect(x: CGFloat(i) * oneEdge,
                                         y: CGFloat(j) * oneEdge,
                                         width: oneEdge,
                                         height: oneEdge)
                
                view.addSubview(colorCell)
                let key = "\(i),\(j)"
                cellLocations[key] = colorCell
                
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self , action: #selector(HandlePan)))
        
    }
    var selectedCell : UIView?
    
    @objc func HandlePan( gesture : UIPanGestureRecognizer ) {
        
        let location = gesture.location(in: view)
        let oneEdge = view.frame.width / CGFloat(cellPerRow)
        
        let x = Int(location.x / oneEdge)
        let y = Int(location.y / oneEdge)
        print("\(x),\(y)")
        guard let colorCell = cellLocations["\(x),\(y)"] else { return }
        
        if selectedCell != colorCell {
            UIView.animate(withDuration: 0.5 , delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { self.selectedCell?.layer.transform = CATransform3DIdentity
            })
        }
        selectedCell = colorCell
        view.bringSubviewToFront(colorCell)
        
        UIView.animate(withDuration: 0.5 , delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            colorCell.layer.transform = CATransform3DMakeScale(3,3,3)
        }
        
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                colorCell.layer.transform = CATransform3DIdentity
            })
        }
    }
    
    func randomColor() -> UIColor {
        let randomColor = UIColor(red:   CGFloat.random(in: 0...1),
                                  green: CGFloat.random(in: 0...1),
                                  blue:  CGFloat.random(in: 0...1),
                                  alpha: 1 )
        return randomColor
    }
}
