//
//  GradientView.swift
//  ACKategories
//
//  Created by Marek Fořt on 10/5/18.
//  Copyright © 2018 Ackee, s.r.o. All rights reserved.
//

import UIKit

/**
    This view creates a gradient view with the defined colors
    - Warning: Please note that if one of your colors is clear, you should usually define to which "clear color" it should go to - i.e. if you want to go from white to clear write:

    `[UIColor.white, UIColor.white.withAlphaComponent(0)]`
 */
open class GradientView: UIView {

    private weak var gradientLayer: CAGradientLayer!

    public init(colors: [UIColor]) {
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
        self.gradientLayer = gradientLayer
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
