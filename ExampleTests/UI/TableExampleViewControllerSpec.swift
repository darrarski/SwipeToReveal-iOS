import Quick
import Nimble
@testable import SwipeToRevealExample

class TableExampleViewControllerSpec: QuickSpec {

    override func spec() {
        context("init with coder") {
            it("should throw asserion") {
                expect { () -> Void in _ = TableExampleViewController(coder: NSCoder()) }.to(throwAssertion())
            }
        }

        context("init") {
            var sut: TableExampleViewController!

            beforeEach {
                sut = TableExampleViewController(assembly: Assembly())
            }

            context("load view") {
                beforeEach {
                    _ = sut.view
                    sut.view.frame = CGRect(x: 0, y: 0, width: 320, height: 240)
                }

                describe("table view") {
                    it("should have 1 section") {
                        expect(sut.numberOfSections(in: sut.tableView)).to(equal(1))
                    }

                    it("should have 100 rows in first section") {
                        expect(sut.tableView(sut.tableView, numberOfRowsInSection: 0)).to(equal(100))
                    }

                    it("should throw when asked for number of rows in second section") {
                        expect { () -> Void in
                            _ = sut.tableView(sut.tableView, numberOfRowsInSection: 1)
                        }.to(throwAssertion())
                    }

                    it("shuld not throw when asked for cell at valid index path") {
                        expect { () -> Void in
                            _ = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                        }.notTo(throwAssertion())
                    }

                    it("should return correct height for a row") {
                        expect(sut.tableView(sut.tableView, heightForRowAt: IndexPath(row: 0, section: 0)))
                            .to(equal(88))
                    }

                    it("should throw when asked for row height at invalid index path") {
                        expect { () -> Void in
                            _ = sut.tableView(sut.tableView, heightForRowAt: IndexPath(row: 0, section: 1))
                        }.to(throwAssertion())
                    }
                }
            }
        }
    }

    struct Assembly: TableExampleAssembly {}

}
