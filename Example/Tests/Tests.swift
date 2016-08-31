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

            it("holds only one handler") {

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
