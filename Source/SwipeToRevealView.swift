import UIKit
import SnapKit

class SwipeToRevealView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadSubviews()
        setupLayout()
        setupGestureRecognizing()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func close(animated: Bool) {
        horizontalOffset = closedOffset
        layoutIfNeeded(animated: animated)
    }

    // MARK: Subviews

    var contentView: UIView? {
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

    var rightView: UIView? {
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

    private func setupLayout() {
        centerContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.size.equalToSuperview()
            $0.left.equalTo(horizontalOffset)
        }
        rightContainer.snp.makeConstraints {
            $0.top.equalTo(centerContainer.snp.top)
            $0.left.equalTo(centerContainer.snp.right)
            $0.bottom.equalTo(centerContainer.snp.bottom)
        }
    }

    private var horizontalOffset = CGFloat(0) {
        didSet { centerContainer.snp.updateConstraints { $0.left.equalTo(horizontalOffset) } }
    }

    private func layoutIfNeeded(animated: Bool) {
        guard animated else {
            super.layoutIfNeeded()
            return
        }

        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: UIViewAnimationOptions.curveEaseOut,
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
    }

    private func handlePanBegan(point: CGFloat) {
        pan = Pan(point: point, offset: horizontalOffset)
    }

    private func handlePanChanged(point: CGFloat) {
        pan?.currentPoint = point
        guard let pan = pan else { return }
        let targetOffset = pan.startOffset + pan.delta
        horizontalOffset = max(rightRevealedOffset, min(closedOffset, targetOffset))
    }

    private func handlePanEnded() {
        guard let pan = pan else { return }

        if pan.lastDelta > 0 {
            horizontalOffset = closedOffset
        } else {
            horizontalOffset = rightRevealedOffset
        }

        layoutIfNeeded(animated: true)
        self.pan = nil
    }

    private let closedOffset = CGFloat(0)

    private var rightRevealedOffset: CGFloat {
        return -rightContainer.frame.width
    }

}

extension SwipeToRevealView: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
