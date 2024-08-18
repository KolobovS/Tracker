import UIKit

final class FilterTableViewCell: UITableViewCell {
    
    lazy var label: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 17, weight: .regular)
        element.textColor = .ypBlack
        return element
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        addConstraints()
    }
    
    func configureCell(text: String) {
        label.text = text
    }
    
    private func setupView() {
        backgroundColor = .ypBackground
        addSubview(label)
    }
    
    private func addConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(286)
        }
    }
}
