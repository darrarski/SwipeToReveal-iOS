import UIKit
import SnapKit

public protocol SwipeToRevealViewDelegate: class {
  func swipeToRevealView(view: SwipeToRevealView, didClose animated: Bool)
  func swipeToRevealView(view: SwipeToRevealView, didRevealRight animated: Bool)
  func swipeToRevealView(view: SwipeToRevealView, didPan pan: UIPanGestureRecognizer)
}

/// Swipe-to-reveal view
public class SwipeToRevealView: UIView {
  
    public weak var delegate: SwipeToRevealViewDelegate?

    /// Create SwipeToRevealView
    ///
    /// - Parameter frame: frame
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadSubviews()
        setupLayout()
        setupGestureRecognizing()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Close, so not extra content is revealed
    ///
    /// - Parameter animated: perform with animation
    public func close(animated: Bool) {
        contentOffset = closedOffset
        layoutIfNeeded(animated: animated)
        delegate?.swipeToRevealView(view: self, didClose: animated)
    }

    /// Reveal right view
    ///
    /// - Parameter animated: perform with animation
    public func revealRight(animated: Bool) {
        contentOffset = rightRevealedOffset
        layoutIfNeeded(animated: animated)
        delegate?.swipeToRevealView(view: self, didRevealRight: animated)
    }

    // MARK: Subviews

    /// Main view, displayed fully when no extra content is revealed
    public var contentView: UIView? {
        didSet {
            if let oldValue = oldValue {
                oldValue.removeFromSuperview()
            }
            if let newValue = contentView {
                centerContainer.addSubview(newValue)
                newValue.snp.makeConstraints { $0.edges.equalToSuperview() }
            }
        }
    }

    /// Right view, hidden by default, can be revelead with swipe gesture
    public var rightView: UIView? {
        didSet {
            if let oldValue = oldValue {
                oldValue.removeFromSuperview()
            }
            if let newValue = rightView {
                rightContainer.addSubview(newValue)
                newValue.snp.makeConstraints { $0.edges.equalToSuperview() }
            }
        }
    }

    private func loadSubviews() {
        addSubview(centerContainer)
        addSubview(rightContainer)
    }

    private let centerContainer = UIView(frame: .zero)
    private let rightContainer = UIView(frame: .zero)

    // MARK: Layout

    /// Content offset - changes when swiping
    public var contentOffset = CGFloat(0) {
        didSet { centerContainer.snp.updateConstraints { $0.left.equalTo(contentOffset) } }
    }

    /// Value for content offset in default state
    public let closedOffset = CGFloat(0)

    /// Value for content offset when right view is fully revealed
    public var rightRevealedOffset: CGFloat {
        return -rightContainer.frame.width
    }

    private func setupLayout() {
        centerContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.size.equalToSuperview()
            $0.left.equalTo(contentOffset)
        }
        rightContainer.snp.makeConstraints {
            $0.top.equalTo(centerContainer.snp.top)
            $0.left.equalTo(centerContainer.snp.right)
            $0.bottom.equalTo(centerContainer.snp.bottom)
        }
    }

    private func layoutIfNeeded(animated: Bool) {
        guard animated else {
            super.layoutIfNeeded()
            return
        }

        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: { [weak self] in self?.layoutIfNeeded() })
    }

    // MARK: Gesture recognizing

    private func setupGestureRecognizing() {
        panGeastureRecognizer.delegate = self
        panGeastureRecognizer.addTarget(self, action: #selector(self.panGestureRecognizerUpdate(_:)))
        addGestureRecognizer(panGeastureRecognizer)
    }

    private let panGeastureRecognizer = UIPanGestureRecognizer()

    private struct Pan {
        let startPoint: CGFloat
        let startOffset: CGFloat

        var currentPoint: CGFloat {
            didSet { previousPoint = oldValue }
        }

        private var previousPoint: CGFloat

        var lastDelta: CGFloat {
            return currentPoint - previousPoint
        }

        var delta: CGFloat {
            return currentPoint - startPoint
        }

        init(point: CGFloat, offset: CGFloat) {
            self.startPoint = point
            self.startOffset = offset
            self.currentPoint = point
            self.previousPoint = point
        }
    }

    private var pan: Pan?

    func panGestureRecognizerUpdate(_ pgr: UIPanGestureRecognizer) {
        switch pgr.state {
        case .possible: break
        case .began:
            handlePanBegan(point: pgr.translation(in: self).x)
        case .changed:
            handlePanChanged(point: pgr.translation(in: self).x)
        case .ended, .cancelled, .failed:
            handlePanEnded()
        }
      
        delegate?.swipeToRevealView(view: self, didPan: pgr)
    }

    private func handlePanBegan(point: CGFloat) {
        pan = Pan(point: point, offset: contentOffset)
    }

    private func handlePanChanged(point: CGFloat) {
        pan?.currentPoint = point
        guard let pan = pan else { return }
        let targetOffset = pan.startOffset + pan.delta
        contentOffset = max(rightRevealedOffset, min(closedOffset, targetOffset))
    }

    private func handlePanEnded() {
        guard let pan = pan else { return }

        if pan.lastDelta > 0 {
            contentOffset = closedOffset
        } else {
            contentOffset = rightRevealedOffset
        }

        layoutIfNeeded(animated: true)
        self.pan = nil
    }

}

extension SwipeToRevealView: UIGestureRecognizerDelegate {

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldRecognizeSimultaneouslyWith
                                  otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

    override public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let pgr = gestureRecognizer as? UIPanGestureRecognizer else { fatalError() }
        let velocity = pgr.velocity(in: self)
        return fabs(velocity.x) > fabs(velocity.y)
    }

}
