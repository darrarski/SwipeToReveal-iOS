import UIKit
import SnapKit

class Cell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadSubviews()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Subviews

    let label = Factory.label
    let swipeToReveal = SwipeToRevealView(frame: .zero)
    let swipeButtonA = Factory.button(title: "Button A", color: .red)
    let swipeButtonB = Factory.button(title: "Button B", color: .blue)

    private func loadSubviews() {
        contentView.addSubview(swipeToReveal)
        swipeToReveal.contentView = swipeContentView
        swipeContentView.addSubview(label)
        swipeToReveal.rightView = swipeRightView
        swipeRightView.addSubview(swipeButtonA)
        swipeRightView.addSubview(swipeButtonB)
    }

    private let swipeContentView = Factory.view(layoutMargins: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    private let swipeRightView = Factory.view()

    // MARK: Layout

    private func setupLayout() {
        swipeToReveal.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        label.snp.makeConstraints {
            guard let superview = label.superview else { fatalError() }
            $0.centerYWithinMargins.equalToSuperview()
            $0.top.greaterThanOrEqualTo(superview.snp.topMargin)
            $0.left.equalTo(superview.snp.leftMargin)
            $0.right.lessThanOrEqualTo(superview.snp.rightMargin)
            $0.bottom.lessThanOrEqualTo(superview.snp.bottomMargin)
        }
        swipeButtonA.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
        }
        swipeButtonB.snp.makeConstraints {
            $0.left.equalTo(swipeButtonA.snp.right)
            $0.top.right.bottom.equalToSuperview()
        }
    }

}

private extension Cell {
    struct Factory {

        static var label: UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
            label.textColor = .darkText
            return label
        }

        static func button(title: String, color: UIColor) -> UIButton {
            let button = UIButton(frame: .zero)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = color
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            return button
        }

        static func view(layoutMargins: UIEdgeInsets = .zero) -> UIView {
            let view = UIView(frame: .zero)
            view.layoutMargins = layoutMargins
            return view
        }

    }
}
