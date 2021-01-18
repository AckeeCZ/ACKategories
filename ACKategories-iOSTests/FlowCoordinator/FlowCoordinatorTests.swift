//
//  FlowCoordinatorTests.swift
//  ACKategories-iOSTests
//
//  Created by Lukáš Hromadník on 06/11/2020.
//

import XCTest
@testable import ACKategories

final class FlowCoordinatorTests: XCTestCase {
    private var window: UIWindow!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        ErrorHandlers.rootViewControllerDeallocatedBeforeStop = nil
        
        window = .dummy
    }
    
    override func tearDown() {
        window = nil
        
        super.tearDown()
    }
    
    // MARK: - Tests

    func testNavigationSubflowIsStopped() throws {
        let fc = NavigationFC()
        fc.start(in: window)
        _ = fc.rootViewController.view
        
        let navigationController = try XCTUnwrap(fc.navigationController)
        
        let childFC = InnerNavigationFC()
        fc.addChild(childFC)
        childFC.start(with: navigationController)
        childFC.push(UIViewController())
        _ = childFC.rootViewController.view
        
        XCTAssertEqual(fc.navigationController?.viewControllers.count, 3)
        XCTAssertEqual(fc.childCoordinators.count, 1)
        
        let exp = expectation(description: "did stop")
        childFC.stop { exp.fulfill() }
        wait(for: [exp], timeout: 1)
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(fc.childCoordinators.count, 0)
    }
    
    func testFirstNavigationSubflowStopsSecondAlso() throws {
        let fc = NavigationFC()
        fc.start(in: window)
        _ = fc.rootViewController.view
        
        let navigationController = try XCTUnwrap(fc.navigationController)
        
        let childFC = InnerNavigationFC()
        fc.addChild(childFC)
        childFC.start(with: navigationController)
        childFC.push(UIViewController())
        _ = childFC.rootViewController.view
        
        let child2FC = InnerNavigationFC()
        childFC.addChild(child2FC)
        child2FC.start(with: navigationController)
        child2FC.push(UIViewController())
        _ = child2FC.rootViewController.view
        
        XCTAssertEqual(navigationController.viewControllers.count, 5)
        XCTAssertEqual(fc.childCoordinators.count, 1)
        XCTAssertEqual(childFC.childCoordinators.count, 1)
        
        let exp = expectation(description: "did stop")
        childFC.stop { exp.fulfill() }
        wait(for: [exp], timeout: 1)
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(fc.childCoordinators.count, 0)
    }
    
    func testDismiss() {
        let fc = NavigationFC()
        fc.start(in: window)
        _ = fc.rootViewController.view
        
        let exp = expectation(description: "did present")
        let childFC = PresentFC { exp.fulfill() }
        fc.addChild(childFC)
        childFC.start(from: fc.rootViewController)
        _ = childFC.rootViewController.view
        wait(for: [exp], timeout: 1)

        XCTAssertNotNil(fc.rootViewController?.presentedViewController)
        
        let exp2 = expectation(description: "did stop")
        childFC.stop { exp2.fulfill() }
        wait(for: [exp2], timeout: 1)
        
        XCTAssertNil(fc.rootViewController.presentedViewController)
        XCTAssertEqual(fc.childCoordinators.count, 0)
    }
    
    func testDismissMultipleFlows() {
        let fc = NavigationFC()
        fc.start(in: window)
        _ = fc.rootViewController.view

        let exp = expectation(description: "did present")
        let childFC = PresentFC { exp.fulfill() }
        fc.addChild(childFC)
        childFC.start(from: fc.rootViewController)
        _ = childFC.rootViewController.view
        wait(for: [exp], timeout: 1)

        XCTAssertNotNil(fc.rootViewController?.presentedViewController)

        let exp2 = expectation(description: "did present")
        let child2FC = PresentFC { exp2.fulfill() }
        childFC.addChild(child2FC)
        child2FC.start(from: childFC.rootViewController)
        _ = child2FC.rootViewController.view
        wait(for: [exp2], timeout: 1)

        XCTAssertNotNil(childFC.rootViewController?.presentedViewController)
        
        let exp3 = expectation(description: "did stop")
        childFC.stop { exp3.fulfill() }
        wait(for: [exp3], timeout: 1)

        XCTAssertNil(fc.rootViewController.presentedViewController)
        XCTAssertEqual(fc.childCoordinators.count, 0)
    }
    
    func testNavigationStopsPresent() {
        let fc = NavigationFC()
        fc.start(in: window)
        _ = fc.rootViewController.view
        
        let exp = expectation(description: "did present")
        let navFC = PresentFC { exp.fulfill() }
        fc.addChild(navFC)
        navFC.start(from: fc.rootViewController)
        wait(for: [exp], timeout: 1)
        
        let exp2 = expectation(description: "did present")
        let presentFC = PresentFC { exp2.fulfill() }
        navFC.addChild(presentFC)
        presentFC.start(from: navFC.rootViewController)
        wait(for: [exp2], timeout: 1)
        
        XCTAssertNotNil(navFC.rootViewController.presentingViewController)
        XCTAssertEqual(navFC.childCoordinators.count, 1)
        
        let exp3 = expectation(description: "did stop")
        navFC.stop { exp3.fulfill() }
        wait(for: [exp3], timeout: 1)
        
        XCTAssertNil(navFC.rootViewController.presentingViewController)
        XCTAssertEqual(navFC.childCoordinators.count, 0)
    }
    
    func testPopMoreThanRootViewController() throws {
        let fc = NavigationFC()
        fc.start(in: window)
        _ = fc.rootViewController.view
        
        let navigationController = try XCTUnwrap(fc.navigationController)
        
        let childFC = InnerNavigationFC()
        fc.addChild(childFC)
        childFC.start(with: navigationController)
        childFC.push(UIViewController())
        _ = childFC.rootViewController.view
        
        XCTAssertEqual(navigationController.viewControllers.count, 3)
        XCTAssertEqual(fc.childCoordinators.count, 1)
        
        let exp = expectation(description: "did pop")
        
        navigationController.popToRootViewController(animated: false) { exp.fulfill() }
        
        wait(for: [exp], timeout: 1)
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(fc.childCoordinators.count, 0)
    }
    
    func testRootViewControllerIsNil() {
        let fc = NavigationFC()
        fc.start(in: window)
        _ = fc.rootViewController.view
        fc.rootViewController = nil
        
        let exp = expectation(description: "Flow did finish")
        fc.stop(animated: false) { exp.fulfill() }
        wait(for: [exp], timeout: 0.3)
    }
    
    func testErrorCallbackIsCalled() {
        let rootExp = expectation(description: "Root is deallocated")
        ErrorHandlers.rootViewControllerDeallocatedBeforeStop = { rootExp.fulfill() }
        
        let fc = NavigationFC()
        fc.start(in: window)
        _ = fc.rootViewController.view
        fc.rootViewController = nil
        
        let exp = expectation(description: "Flow did finish")
        fc.stop(animated: false) { exp.fulfill() }
        wait(for: [exp, rootExp], timeout: 0.3)
    }

    func testAllChildCoordinatorsAreCorrectlyStoppedWhenPreseting() throws {
        let fc = NavigationFC()
        fc.start(in: window)
        _ = fc.rootViewController.view

        let navigationController = try XCTUnwrap(fc.navigationController)

        let exp = expectation(description: "did present")
        let childFC = PresentFC { exp.fulfill() }
        childFC.navigationController?.modalPresentationStyle = .overFullScreen
        fc.addChild(childFC)
        childFC.start(from: fc.rootViewController)
        _ = childFC.rootViewController.view
        wait(for: [exp], timeout: 1)

        XCTAssertEqual(fc.childCoordinators.count, 1)
        XCTAssertNotNil(fc.rootViewController?.presentedViewController)

        let exp2 = expectation(description: "did present")
        let child2FC = PresentFC { exp2.fulfill() }
        childFC.addChild(child2FC)
        child2FC.start(from: childFC.rootViewController)
        _ = child2FC.rootViewController.view
        wait(for: [exp2], timeout: 1)

        XCTAssertEqual(childFC.childCoordinators.count, 1)
        XCTAssertNotNil(childFC.rootViewController?.presentedViewController)

        let exp3 = expectation(description: "did present")
        let child3FC = PresentFC { exp3.fulfill() }
        child2FC.addChild(child3FC)
        child3FC.start(from: child2FC.rootViewController)
        _ = child3FC.rootViewController.view
        wait(for: [exp3], timeout: 1)

        XCTAssertEqual(child2FC.childCoordinators.count, 1)
        XCTAssertNotNil(child2FC.rootViewController?.presentedViewController)

        let exp4 = expectation(description: "did stop")
        childFC.stop { exp4.fulfill() }
        wait(for: [exp4], timeout: 1)

        XCTAssertEqual(fc.childCoordinators.count, 0)
        XCTAssertNil(fc.rootViewController?.presentedViewController)
        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }
}
