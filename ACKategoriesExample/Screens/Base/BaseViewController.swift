//
//  BaseViewController.swift
//  ACKategories-Example
//
//  Created by Jan Misar on 05/04/2019.
//  Copyright © 2019 Ackee, s.r.o. All rights reserved.
//

import UIKit
import ACKategories

class BaseViewController<ViewModelType>: Base.ViewController {

    /// Corresponding viewModel
    let viewModel: ViewModelType

    init(viewModel: ViewModelType) {
        self.viewModel = viewModel

        super.init()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// Empty class for BaseViewControllerNoVM
public struct NoViewModel {}

/// Base VC with no VM
class BaseViewControllerNoVM: BaseViewController<NoViewModel> {
    public init() {
        super.init(viewModel: NoViewModel())
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
}
