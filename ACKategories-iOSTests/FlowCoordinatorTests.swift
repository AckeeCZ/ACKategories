//
//  FlowCoordinatorTests.swift
//  ACKategories-iOSTests
//
//  Created by Lukáš Hromadník on 06/11/2020.
//

import XCTest
@testable import ACKategories

extension UIWindow {
    static var dummy: UIWindow {
        UIWindow(frame: UIScreen.main.bounds)
    }
}

extension Base.FlowCoordinatorNoDeepLink {
    func push(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func present(_ vc: UIViewController) {
        rootViewController.present(vc, animated: false)
    }
}

class SimpleViewController: UIViewController {
    init() { super.init(nibName: nil, bundle: nil) }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
    }
}

class NavigationFC: Base.FlowCoordinatorNoDeepLink {
    override func start(in window: UIWindow) {
        let rootVC = SimpleViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        rootViewController = rootVC
        navigationController = navVC
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        _ = navVC.view
        
        super.start(in: window)
    }
}

class InnerNavigationFC: Base.FlowCoordinatorNoDeepLink {
    override func start(with navigationController: UINavigationController) {
        let controller = SimpleViewController()
        navigationController.pushViewController(controller, animated: false)

        rootViewController = controller

        super.start(with: navigationController)        
    }
}

class PresentFC: Base.FlowCoordinatorNoDeepLink {
    private let completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    override func start(from viewController: UIViewController) {
        let rootVC = SimpleViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        viewController.present(navVC, animated: false, completion: completion)
        
        rootViewController = rootVC
        navigationController = navVC

        super.start(from: viewController)
    }
}

final class FlowCoordinatorTests: XCTestCase {
    private var window: UIWindow!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        window = .dummy
    }
    
    override func tearDown() {
        window = nil
        
        super.tearDown()
    }
    
    // MARK: - Tests

    func testNavigationSubflowIsStopped() {
        let fc = NavigationFC()
        fc.start(in: window)
        _ = fc.rootViewController.view
        
        let childFC = InnerNavigationFC()
        fc.addChild(childFC)
        childFC.start(with: fc.navigationController!)
        childFC.push(UIViewController())
        _ = childFC.rootViewController.view
        
        XCTAssertEqual(fc.navigationController?.viewControllers.count, 3)
        XCTAssertEqual(fc.childCoordinators.count, 1)
        
        let exp = expectation(description: "did stop")
        childFC.stop { exp.fulfill() }
        wait(for: [exp], timeout: 1)
        
        XCTAssertEqual(fc.navigationController?.viewControllers.count, 1)
        XCTAssertEqual(fc.childCoordinators.count, 0)
    }
    
    func testFirstNavigationSubflowStopsSecondAlso() {
        let fc = NavigationFC()
        fc.start(in: window)
        _ = fc.rootViewController.view
        
        let childFC = InnerNavigationFC()
        fc.addChild(childFC)
        childFC.start(with: fc.navigationController!)
        childFC.push(SimpleViewController())
        _ = childFC.rootViewController.view
        
        let child2FC = InnerNavigationFC()
        childFC.addChild(child2FC)
        child2FC.start(with: fc.navigationController!)
        child2FC.push(SimpleViewController())
        _ = child2FC.rootViewController.view
        
        XCTAssertEqual(fc.navigationController?.viewControllers.count, 5)
        XCTAssertEqual(fc.childCoordinators.count, 1)
        XCTAssertEqual(childFC.childCoordinators.count, 1)
        
        let exp = expectation(description: "did stop")
        childFC.stop { exp.fulfill() }
        wait(for: [exp], timeout: 1)
        
        XCTAssertEqual(fc.navigationController?.viewControllers.count, 1)
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

        XCTAssertNotNil(fc.rootViewController!.presentedViewController)
        
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

        XCTAssertNotNil(fc.rootViewController!.presentedViewController)

        let exp2 = expectation(description: "did present")
        let child2FC = PresentFC { exp2.fulfill() }
        childFC.addChild(child2FC)
        child2FC.start(from: childFC.rootViewController)
        _ = child2FC.rootViewController.view
        wait(for: [exp2], timeout: 1)

        XCTAssertNotNil(childFC.rootViewController!.presentedViewController)
        
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
    
    func testPopMoreThanRootViewController() {
        let fc = NavigationFC()
        fc.start(in: window)
        _ = fc.rootViewController.view
        
        let childFC = InnerNavigationFC()
        fc.addChild(childFC)
        childFC.start(with: fc.navigationController!)
        childFC.push(UIViewController())
        _ = childFC.rootViewController.view
        
        XCTAssertEqual(fc.navigationController?.viewControllers.count, 3)
        XCTAssertEqual(fc.childCoordinators.count, 1)
        
        let exp = expectation(description: "did pop")
        
        fc.navigationController?.popToRootViewController(animated: false) { exp.fulfill() }
        
        wait(for: [exp], timeout: 1)
        
        XCTAssertEqual(fc.navigationController?.viewControllers.count, 1)
        XCTAssertEqual(fc.childCoordinators.count, 0)
    }
}

extension UINavigationController {
    func popToViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    func popToRootViewController(animated: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }
}
