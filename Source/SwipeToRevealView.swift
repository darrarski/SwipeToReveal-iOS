import UIKit
import SnapKit

class SwipeToRevealView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadSubviews()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            horizontalOffsetConstraint = $0.left.equalToSuperview().constraint
        }
        rightContainer.snp.makeConstraints {
            $0.top.equalTo(centerContainer.snp.top)
            $0.left.equalTo(centerContainer.snp.right)
            $0.bottom.equalTo(centerContainer.snp.bottom)
        }
    }

    private var horizontalOffsetConstraint: Constraint?

}
