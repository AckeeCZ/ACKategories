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
                button.on(.touchUpInside) { sender in
                    firstCalled = true
                }

                button.sendActions(for: .touchUpInside)

                expect(firstCalled) == true
            }

            it("runs handlers for all registered events") {

                var firstCalled = false
                var secondCalled = false

                let button = UIButton()
                button.on(.touchUpInside) { sender in
                    firstCalled = true
                }
                button.on(.touchDown) { sender in
                    secondCalled = true
                }

                button.sendActions(for: .touchUpInside)
                expect(firstCalled) == true

                button.sendActions(for: .touchDown)
                expect(secondCalled) == true
            }

            it("holds only one handler for particular event") {

                var firstCalled = false
                var secondCalled = false

                let button = UIButton()
                button.on(.touchUpInside) { sender in
                    firstCalled = true
                }
                button.on(.touchUpInside) { sender in
                    secondCalled = true
                }

                button.sendActions(for: .touchUpInside)

                expect(firstCalled) == false
                expect(secondCalled) == true
            }

            it("runs one handler for more events") {

                var x = 0

                let button = UIButton()
                button.on([.touchUpInside, .touchDown]) { sender in
                    x += 1
                }
                button.on(.touchUpInside) { sender in
                    x += 1
                }

                button.sendActions(for: .touchUpInside)
                button.sendActions(for: .touchDown)
                expect(x) == 3

                button.sendActions(for: .touchUpInside)
                expect(x) == 5
            }

            it("can unregister action block") {

                var firstCalled = false

                let button = UIButton()
                button.on(.touchUpInside) { sender in
                    firstCalled = true
                }

                button.sendActions(for: .touchUpInside)
                expect(firstCalled) == true

                firstCalled = false
                button.off(.touchUpInside)

                button.sendActions(for: .touchUpInside)
                expect(firstCalled) == false
            }
        }
    }
}
