import Quick
import Nimble
@testable import SwipeToRevealExample

class AppDelegateSpec: QuickSpec {

    override func spec() {
        describe("AppDelegate") {
            var sut: AppDelegate!
            var assembly: Assembly!

            beforeEach {
                assembly = Assembly()
                sut = AppDelegate(assembly: assembly)
            }

            context("app did finish launching") {
                var returnValue: Bool!

                beforeEach {
                    returnValue = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
                }

                it("should return true") {
                    expect(returnValue).to(beTrue())
                }

                it("should make window key and visible") {
                    expect(assembly.windowSpy.makeKeyAndVisibleCalled).to(beTrue())
                }

                describe("root navigation controller") {
                    var controller: UINavigationController!

                    beforeEach {
                        controller = sut.window?.rootViewController as? UINavigationController
                    }

                    it("should be correct") {
                        expect(controller).to(equal(assembly.navigationController))
                    }

                    it("should have correct root") {
                        expect(controller.viewControllers.first).to(equal(assembly.rootViewController))
                    }
                }
            }
        }
    }

    struct Assembly: AppDelegateAssembly {
        let windowSpy = WindowSpy(frame: .zero)
        var window: UIWindow { return windowSpy }
        let navigationController = UINavigationController()
        let rootViewController = UIViewController(nibName: nil, bundle: nil)
    }

}
