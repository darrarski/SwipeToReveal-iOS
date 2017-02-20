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

            context("select first item") {
                beforeEach {
                    sut.items.first?.select()
                }

                it("should call delegate") {
                    expect(delegate._menuViewModelDidPresentViewController?.viewModel).to(be(sut))
                }

                it("should present correct view controller") {
                    expect(delegate._menuViewModelDidPresentViewController?.viewController)
                        .to(be(assembly.tableViewExampleController))
                }
            }
        }
    }

    struct Assembly: MenuAssembly {
        var viewModel: MenuViewModel { fatalError() }
        let tableViewExampleController = UIViewController(nibName: nil, bundle: nil)
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
