//
//  ExampleListViewModel.swift
//  ACKategories
//
//  Created by Jakub Olejník on 12/09/2018.
//  Copyright © 2018 Ackee, s.r.o. All rights reserved.
//

import ACKategories

protocol ExampleListViewModelingActions {

}

protocol ExampleListViewModeling {
	var actions: ExampleListViewModelingActions { get }

    var items: [ExampleItem] { get }
}

extension ExampleListViewModeling where Self: ExampleListViewModelingActions {
    var actions: ExampleListViewModelingActions { return self }
}

final class ExampleListViewModel: Base.ViewModel, ExampleListViewModeling, ExampleListViewModelingActions {
    let items = ExampleItem.allCases
}
