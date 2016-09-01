// https://github.com/Quick/Quick

import Quick
import Nimble
import ACKategories
import UIKit

class ControlBlocksSpec: QuickSpec {
    override func spec() {

        describe("Button") {
            it("runs handler on tap") {

                var firstCalled = false

                let button = UIButton()
                button.on(.TouchUpInside) { sender in
                    firstCalled = true
                }

                button.sendActionsForControlEvents(.TouchUpInside)

                expect(firstCalled) == true
            }

            it("runs handlers for all registered events") {

                var firstCalled = false
                var secondCalled = false

                let button = UIButton()
                button.on(.TouchUpInside) { sender in
                    firstCalled = true
                }
                button.on(.TouchDown) { sender in
                    secondCalled = true
                }

                button.sendActionsForControlEvents(.TouchUpInside)
                expect(firstCalled) == true

                button.sendActionsForControlEvents(.TouchDown)
                expect(secondCalled) == true
            }

            it("holds only one handler for particular event") {

                var firstCalled = false
                var secondCalled = false

                let button = UIButton()
                button.on(.TouchUpInside) { sender in
                    firstCalled = true
                }
                button.on(.TouchUpInside) { sender in
                    secondCalled = true
                }

                button.sendActionsForControlEvents(.TouchUpInside)

                expect(firstCalled) == false
                expect(secondCalled) == true
            }

            it("runs one handler for more events") {

                var x = 0

                let button = UIButton()
                button.on([.TouchUpInside, .TouchDown]) { sender in
                    x += 1
                }
                button.on(.TouchUpInside) { sender in
                    x += 1
                }

                button.sendActionsForControlEvents(.TouchUpInside)
                button.sendActionsForControlEvents(.TouchDown)
                expect(x) == 3

                button.sendActionsForControlEvents(.TouchUpInside)
                expect(x) == 5
            }

            itBehavesLike("object without leaks") {
                NSDictionary {

                    let button = UIButton()
                    button.on(.TouchUpInside) { sender in
                        sender.tag = 1
                    }
                    button.sendActionsForControlEvents(.TouchUpInside)
                    return button
                }
            }
        }
    }
}
