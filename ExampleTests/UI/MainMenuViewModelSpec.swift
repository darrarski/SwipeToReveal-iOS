import Quick
import Nimble
@testable import SwipeToRevealExample

class MainMenuViewModelSpec: QuickSpec {

    override func spec() {
        describe("MainMenuViewModel") {
            var sut: MainMenuViewModel!
            var assembly: Assembly!
            var delegate: Delegate!

            beforeEach {
                assembly = Assembly()
                delegate = Delegate()
                sut = MainMenuViewModel(assembly: assembly)
                sut.delegate = delegate
            }

            it("should have one item") {
                expect(sut.items.count).to(equal(1))
            }

            context("first item did select") {
                beforeEach {
                    sut.menuItemViewModelDidSelect(sut.items.first!)
                }

                it("should call delegate") {
                    expect(delegate._menuViewModelDidPresentViewController?.viewModel).to(be(sut))
                }

                it("should present correct view controller") {
                    expect(delegate._menuViewModelDidPresentViewController?.viewController)
                        .to(be(assembly.tableExampleViewController))
                }
            }

            context("unknown item did select") {
                it("should throw assertion") {
                    expect { () -> Void in
                        sut.menuItemViewModelDidSelect(MainMenuItemViewModel(title: "Unknown"))
                    }.to(throwAssertion())
                }
            }
        }
    }

    struct Assembly: MenuAssembly {
        var viewModel: MenuViewModel { fatalError() }
        let tableExampleViewController = UIViewController(nibName: nil, bundle: nil)
    }

    class Delegate: MenuViewModelDelegate {

        func menuViewModel(_ viewModel: MenuViewModel,
                           presentViewController viewController: UIViewController) {
            _menuViewModelDidPresentViewController = (viewModel, viewController)
        }

        private(set) var _menuViewModelDidPresentViewController:
            (viewModel: MenuViewModel, viewController: UIViewController)?

    }

}
