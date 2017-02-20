import Quick
import Nimble
@testable import SwipeToRevealExample

class MainMenuItemViewModelSpec: QuickSpec {

    override func spec() {
        describe("MainMenuItemViewModel") {
            var sut: MainMenuItemViewModel!
            var title: String!
            var delegate: Delegate!

            beforeEach {
                title = "Menu Item Title"
                delegate = Delegate()
                sut = MainMenuItemViewModel(title: title)
                sut.delegate = delegate
            }

            it("should have correct title") {
                expect(sut.title).to(equal(title))
            }

            context("did select") {
                beforeEach {
                    sut.select()
                }

                it("should call delegate") {
                    expect(delegate._menuItemViewModelDidSelect).to(be(sut))
                }
            }
        }
    }

    class Delegate: MenuItemViewModelDelegate {

        func menuItemViewModelDidSelect(_ viewModel: MenuItemViewModel) {
            _menuItemViewModelDidSelect = viewModel
        }

        private(set) var _menuItemViewModelDidSelect: MenuItemViewModel?

    }

}
