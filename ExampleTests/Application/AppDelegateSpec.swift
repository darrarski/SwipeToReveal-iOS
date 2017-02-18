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

                it("should have correct root view controller") {
                    expect(sut.window?.rootViewController).to(equal(assembly.rootViewController))
                }
            }
        }
    }

    struct Assembly: AppDelegateAssembly {
        let windowSpy = WindowSpy(frame: .zero)
        var window: UIWindow { return windowSpy }
        let rootViewController = UIViewController(nibName: nil, bundle: nil)
    }

}
