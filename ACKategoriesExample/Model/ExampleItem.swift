//
//  ExampleItem.swift
//  ACKategories-Example
//
//  Created by Jakub Olejník on 12/09/2018.
//  Copyright © 2018 Ackee, s.r.o. All rights reserved.
//

import Foundation

enum ExampleItem: CaseIterable {
    case uiControlBlocks
    case viewControllerComposition
    case mapViewController
    case present
    case gradientView

    var title: String { return data.title }
    var subtitle: String { return data.subtitle }

    private var data: (title: String, subtitle: String) {
        switch self {
        case .uiControlBlocks: return ("UIControl blocks", "Use closures instead of target - selector pattern")
        case .viewControllerComposition: return ("View controller composition", "Simply embed view controller into another one")
        case .mapViewController: return ("Map View Controller", "Operations on MKMapView")
        case .present: return ("Present", "Example usage of starting flow coordinator with modal present")
        case .gradientView: return ("GradientView", "Example usage of gradient view")
        }
    }
}
