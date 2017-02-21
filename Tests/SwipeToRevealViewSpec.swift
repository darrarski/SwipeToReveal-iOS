import Quick
import Nimble
import SwipeToReveal

class SwipeToRevealViewSpec: QuickSpec {

    override func spec() {
        context("init with coder") {
            it("should throw asserion") {
                expect { () -> Void in _ = SwipeToRevealView(coder: NSCoder()) }.to(throwAssertion())
            }
        }

        context("init") {
            var sut: SwipeToRevealView!
            var size: CGSize!

            beforeEach {
                size = CGSize(width: 100, height: 20)
                sut = SwipeToRevealView(frame: .zero)
                sut.translatesAutoresizingMaskIntoConstraints = false
                sut.widthAnchor.constraint(equalToConstant: size.width).isActive = true
                sut.heightAnchor.constraint(equalToConstant: size.height).isActive = true
                sut.setNeedsLayout()
                sut.layoutIfNeeded()
            }

            it("should not have content view") {
                expect(sut.contentView).to(beNil())
            }

            it("should not have right view") {
                expect(sut.rightView).to(beNil())
            }

            it("should have correct size") {
                expect(sut.frame.size).to(equal(size))
            }

            context("set content view") {
                var contentView: UIView!

                beforeEach {
                    contentView = UIView(frame: .zero)
                    sut.contentView = contentView
                    sut.setNeedsLayout()
                    sut.layoutIfNeeded()
                }

                it("should have content view") {
                    expect(sut.contentView).to(be(contentView))
                }

                it("should content view have correct size") {
                    expect(contentView.frame.size).to(equal(sut.frame.size))
                }

                it("should content view have correct origin") {
                    let origin = contentView.convert(contentView.frame.origin, to: sut)
                    expect(origin).to(equal(CGPoint.zero))
                }

                context("set right view") {
                    var rightView: UIView!
                    var rightViewWidth: CGFloat!

                    beforeEach {
                        rightViewWidth = 30
                        rightView = UIView(frame: .zero)
                        rightView.translatesAutoresizingMaskIntoConstraints = false
                        rightView.widthAnchor.constraint(equalToConstant: rightViewWidth).isActive = true
                        sut.rightView = rightView
                        sut.setNeedsLayout()
                        sut.layoutIfNeeded()
                    }

                    it("should have right view") {
                        expect(sut.rightView).to(be(rightView))
                    }

                    it("should right view have correct size") {
                        expect(rightView.frame.width).to(equal(rightViewWidth))
                        expect(rightView.frame.height).to(equal(sut.bounds.height))
                    }

                    it("should right view have correct origin") {
                        let origin = rightView.convert(rightView.frame.origin, to: sut)
                        let expectation = CGPoint(x: sut.bounds.maxX, y: sut.bounds.minY)
                        expect(origin).to(equal(expectation))
                    }

                    context("reveal right") {
                        beforeEach {
                            sut.revealRight(animated: false)
                            sut.setNeedsLayout()
                            sut.layoutIfNeeded()
                        }

                        it("should right view have correct size") {
                            expect(rightView.frame.width).to(equal(rightViewWidth))
                            expect(rightView.frame.height).to(equal(sut.bounds.height))
                        }

                        it("should right view have correct origin") {
                            let origin = rightView.convert(rightView.frame.origin, to: sut)
                            let expectation = CGPoint(
                                x: sut.bounds.maxX - rightView.frame.width,
                                y: sut.bounds.minY
                            )
                            expect(origin).to(equal(expectation))
                        }

                        context("close") {
                            beforeEach {
                                sut.close(animated: false)
                                sut.setNeedsLayout()
                                sut.layoutIfNeeded()
                            }

                            it("should right view have correct size") {
                                expect(rightView.frame.width).to(equal(rightViewWidth))
                                expect(rightView.frame.height).to(equal(sut.bounds.height))
                            }

                            it("should right view have correct origin") {
                                let origin = rightView.convert(rightView.frame.origin, to: sut)
                                let expectation = CGPoint(x: sut.bounds.maxX, y: sut.bounds.minY)
                                expect(origin).to(equal(expectation))
                            }
                        }
                    }
                }
            }
        }
    }

}
