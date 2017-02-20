import Quick
import Nimble
@testable import SwipeToRevealExample

class MenuViewControllerSpec: QuickSpec {

    override func spec() {
        context("init with coder") {
            it("should throw asserion") {
                expect { () -> Void in _ = MenuViewController(coder: NSCoder()) }.to(throwAssertion())
            }
        }

        context("init") {
            var sut: MenuViewController!
            var assembly: Assembly!
            var viewModel: ViewModel!

            beforeEach {
                viewModel = ViewModel()
                assembly = Assembly(viewModel: viewModel)
                sut = MenuViewController(assembly: assembly)
            }

            context("load view") {
                beforeEach {
                    _ = sut.view
                }

                it("should have correct title") {
                    expect(sut.navigationItem.title).to(equal(viewModel.title))
                }

                describe("table view") {
                    it("should have 1 section") {
                        expect(sut.numberOfSections(in: sut.tableView)).to(equal(1))
                    }

                    it("should have 3 rows in first section") {
                        expect(sut.tableView(sut.tableView, numberOfRowsInSection: 0)).to(equal(3))
                    }

                    it("should have 0 rows in second section") {
                        expect(sut.tableView(sut.tableView, numberOfRowsInSection: 1)).to(equal(0))
                    }

                    func testCell(section: Int, row: Int) {
                        describe("cell \(row) in section \(section)") {
                            var cell: UITableViewCell!

                            beforeEach {
                                cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: row, section: section))
                            }

                            it("should have correct title") {
                                expect(cell.textLabel?.text).to(equal(viewModel.items[row].title))
                            }

                            it("should have correct accessory type") {
                                expect(cell.accessoryType).to(equal(UITableViewCellAccessoryType.disclosureIndicator))
                            }

                            it("should not be selected") {
                                expect(viewModel._items[row]._isSelected).to(beFalse())
                            }

                            context("select") {
                                beforeEach {
                                    sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: row, section: section))
                                }

                                it("should select view model") {
                                    expect(viewModel._items[row]._isSelected).to(beTrue())
                                }
                            }
                        }
                    }

                    testCell(section: 0, row: 0)
                    testCell(section: 0, row: 1)
                    testCell(section: 0, row: 2)

                    func testInvalidCell(section: Int, row: Int) {
                        describe("invalid cell \(row) in section \(section)") {
                            it("should throw assertion") {
                                expect { () -> Void in
                                    _ = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: row, section: section))
                                }.to(throwAssertion())
                            }

                            it("should throw assertion when selected") {
                                expect { () -> Void in
                                    sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: row, section: section))
                                }.to(throwAssertion())
                            }
                        }
                    }

                    testInvalidCell(section: 0, row: 3)
                    testInvalidCell(section: 1, row: 0)

                }
            }
        }
    }

    struct Assembly: MenuAssembly {
        let viewModel: MenuViewModel
        var tableViewExampleController: UIViewController { fatalError() }
    }

    class ViewModel: MenuViewModel {
        weak var delegate: MenuViewModelDelegate?

        let title = "Menu Title"

        var items: [MenuItemViewModel] {
            return _items
        }

        let _items: [ItemViewModel] = [
            ItemViewModel(title: "Menu Item 1"),
            ItemViewModel(title: "Menu Item 2"),
            ItemViewModel(title: "Menu Item 3")
        ]
    }

    class ItemViewModel: MenuItemViewModel {
        init(title: String) {
            self.title = title
        }

        weak var delegate: MenuItemViewModelDelegate?

        let title: String

        func select() {
            _isSelected = true
        }

        private(set) var _isSelected = false
    }

}
