import Quick
import Nimble
import Nimble_Snapshots
@testable import SwipeToRevealExample
import UIKit

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

            context("setup") {
                beforeEach {
                    sut.frame = CGRect(x: 0, y: 0, width: 320, height: 88)
                    sut.label.text = "Snapshot Test"
                }

                it("should have valid snapshot") {
                    expect(sut).to(haveValidSnapshot())
                }
            }
        }
    }

}
