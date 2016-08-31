// https://github.com/Quick/Quick

import Quick
import Nimble
import ACKategories
import UIKit

class ControlBlocksSpec: QuickSpec {
    override func spec() {

        describe("Button") {
            it("runs handler on tap") {

                var x = "Button not pressed"

                let button = UIButton()
                button.on(.TouchUpInside) { sender in
                    x = "Button pressed"
                }

                button.sendActionsForControlEvents(.TouchUpInside)

                expect(x) == "Button pressed"
            }

            it("runs handlers for all registered events") {

                var x = "Button not pressed"
                var y = "Button not pressed"

                let button = UIButton()
                button.on(.TouchUpInside) { sender in
                    x = "Button TouchUpInside"
                }
                button.on(.TouchDown) { sender in
                    y = "Button TouchDown"
                }

                button.sendActionsForControlEvents(.TouchUpInside)
                expect(x) == "Button TouchUpInside"

                button.sendActionsForControlEvents(.TouchDown)
                expect(y) == "Button TouchDown"
            }

            it("holds only one handler for particular event") {

                var x = "First handler not called"
                var y = "Second handler not called"

                let button = UIButton()
                button.on(.TouchUpInside) { sender in
                    x = "First handler called"
                }
                button.on(.TouchUpInside) { sender in
                    y = "Second handler called"
                }

                button.sendActionsForControlEvents(.TouchUpInside)

                expect(x) == "First handler not called"
                expect(y) == "Second handler called"
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
                    return button
                }
            }
        }
    }
}
