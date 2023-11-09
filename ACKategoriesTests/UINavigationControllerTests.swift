//
//  UINavigationControllerTests.swift
//  ACKategories-iOSTests
//
//  Created by Jakub Olejník on 08.12.2020.
//

import ACKategories
import UIKit
import XCTest

final class UINavigationControllerTests: XCTestCase {
    func testPushCompletionWhenEmpty() {
        let navigationController = UINavigationController()
        let pushExpectation = expectation(description: "Push completion")
        
        navigationController.pushViewController(UIViewController(), animated: true) {
            pushExpectation.fulfill()
        }
        
        wait(for: [pushExpectation], timeout: 0.5)
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }
    
    func testPushCompletionWhenNotEmpty() {
        let navigationController = UINavigationController(rootViewController: UIViewController())
        let pushExpectation = expectation(description: "Push completion")
        
        navigationController.pushViewController(UIViewController(), animated: true) {
            pushExpectation.fulfill()
        }
        
        wait(for: [pushExpectation], timeout: 0.5)
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
    }
    
    func testPopCompletion() {
        let navigationController = UINavigationController(rootViewController: UIViewController())
        let popExpectation = expectation(description: "Pop completion")
        
        navigationController.popViewController(animated: true) {
            popExpectation.fulfill()
        }
        
        wait(for: [popExpectation], timeout: 0.5)
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }
    
    func testPopToCompletion() {
        let navigationController = UINavigationController()
        let targetController = UIViewController()
        let popExpectation = expectation(description: "Pop completion")
        
        navigationController.viewControllers = [
            UIViewController(),
            UIViewController(),
            targetController,
            UIViewController(),
            UIViewController()
        ]
        
        navigationController.popToViewController(targetController, animated: true) {
            popExpectation.fulfill()
        }
        
        wait(for: [popExpectation], timeout: 0.5)
        
        XCTAssertEqual(navigationController.viewControllers.count, 3)
        XCTAssertEqual(navigationController.topViewController, targetController)
    }
    
    func testPopToRootCompletion() {
        let navigationController = UINavigationController()
        let popExpectation = expectation(description: "Pop completion")
        
        navigationController.viewControllers = [
            UIViewController(),
            UIViewController(),
            UIViewController(),
        ]
        
        navigationController.popToRootViewController(animated: true) {
            popExpectation.fulfill()
        }
        
        wait(for: [popExpectation], timeout: 0.5)
        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }
}
