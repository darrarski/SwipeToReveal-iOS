import Quick
import Nimble
@testable import SwipeToRevealExample

class TableExampleCellSpec: QuickSpec {

    override func spec() {
        context("init with coder") {
            it("should throw asserion") {
                expect { () -> Void in _ = TableExampleCell(coder: NSCoder()) }.to(throwAssertion())
            }
        }

        context("init") {
            var sut: TableExampleCell!

            beforeEach {
                sut = TableExampleCell(style: .default, reuseIdentifier: "cell")
            }

            context("prepare for reuse") {
                beforeEach {
                    sut.label.text = "Test"
                    sut.prepareForReuse()
                }

                it("should clear label text") {
                    expect(sut.label.text).to(beNil())
                }
            }
        }
    }

}
