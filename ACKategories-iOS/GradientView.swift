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
    - Warning: Please note that if one of your colors is clear, you should usually define to which "clear color" it should go to - i.e. if you want to go from white to clear, write:

    `[UIColor.white, UIColor.white.withAlphaComponent(0)]`
 */
open class GradientView: UIView {
    override open class var layerClass: Swift.AnyClass { CAGradientLayer.self }

    // MARK: - Private properties

    /// The axis of the gradient: `.vertical` for bottom-to-top gradient, `.horizontal` for left-to-right gradient.
    ///
    /// Default value is `.vertical`
    public var axis: NSLayoutConstraint.Axis {
        didSet {
            setupAxis()
        }
    }

    /// The colors to be used for the gradient
    public var colors: [UIColor] {
        didSet {
            setupGradientColors()
        }
    }

    // MARK: - Initializers

    /**
     Creates a gradient view with colors and axis
     - Parameters:
        - colors: The colors to be used for the gradient.
        - axis: The axis of the gradient: `.vertical` for bottom-to-top gradient, `.horizontal` for left-to-right gradient.
     */
    public init(colors: [UIColor] = [], axis: NSLayoutConstraint.Axis = .vertical) {
        self.axis = axis
        self.colors = colors
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))

        guard let gradientLayer = layer as? CAGradientLayer else { return }
        gradientLayer.frame = bounds

        isUserInteractionEnabled = false

        setupAxis()
        setupGradientColors()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        setupGradientColors()
    }

    // MARK: - Helpers

    private func setupGradientColors() {
        guard let gradientLayer = layer as? CAGradientLayer else { return }
        gradientLayer.colors = colors.map { $0.cgColor }
    }

    private func setupAxis() {
        guard let gradientLayer = layer as? CAGradientLayer else { return }
        if axis == .vertical {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
    }
}
