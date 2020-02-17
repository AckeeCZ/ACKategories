//
//  Aliases.swift
//  ACKategories-iOS
//
//  Created by Jakub Olejník on 10/01/2020.
//

/// As _ACKategories-iOS_ does not embed _ACKategoriesCore_ in Carthage distribution (so it is simpler to develop and also to integrate),
/// we need to somehow bridge types from _ACKategoriesCore_ in other distribution channels, this is the purpose of this file,
/// so it should be part of SwiftPM and Cocoapods distributions, but not compiled with Carthage distribution.

import ACKategoriesCore

public typealias Base = ACKategoriesCore.Base

@available(iOS 10.0, *)
typealias Logger = ACKategoriesCore.Logger

typealias Reusable = ACKategoriesCore.Reusable
