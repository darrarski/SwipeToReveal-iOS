import Quick
import Nimble
import SwipeToReveal

class SwipeToRevealViewSpec: QuickSpec {

    override func spec() {
        describe("SwipeToRevealView") {
            var sut: SwipeToRevealView!

            beforeEach {
                sut = SwipeToRevealView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
            }

            it("should not be nil") {
                expect(sut).notTo(beNil())
            }
        }
    }

}
