import Quick
import Nimble
@testable import SwipeToRevealExample

class MenuViewControllerSpec: QuickSpec {

    override func spec() {
        describe("MenuViewController") {
            var sut: MenuViewController!
            var assembly: Assembly!

            beforeEach {
                assembly = Assembly()
                sut = MenuViewController(assembly: assembly)
            }

            context("load view") {
                beforeEach {
                    _ = sut.view
                }

                // TODO:
            }
        }
    }

    struct Assembly: MenuAssembly {}

}
