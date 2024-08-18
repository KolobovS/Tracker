import UIKit

final class StatisticCellView: UIView {
    
    private lazy var countLabel: UILabel = {
        let element = UILabel()
        element.textColor = .ypBlack
        element.font = .boldSystemFont(ofSize: 34)
        return element
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 12, weight: .medium)
        element.textColor = .ypBlack
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .ypWhite
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCountLabel(value: String) {
        countLabel.text = value
    }
    
    func setdescriptionLabel(text: String) {
        descriptionLabel.text = text
    }
    
    private func setupViews() {
        addSubview(countLabel)
        addSubview(descriptionLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        countLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(12)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(7)
            make.leading.bottom.trailing.equalToSuperview().inset(12)
        }
    }
}
