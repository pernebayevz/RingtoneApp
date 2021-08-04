//
//  HomeTabBaseTableViewCell.swift
//  HomeTabBaseTableViewCell
//
//  Created by Zhangali Pernebayev on 25.07.2021.
//

import UIKit

class HomeTabBaseTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    let rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow_right")
        return imageView
    }()
    lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, rightArrowImageView])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 8, right: 16)
        return stackView
    }()
    lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [hStackView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    var collectionView: HomeBaseCollectionView! {
        didSet {
            vStackView.addArrangedSubview(collectionView)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        selectionStyle = .none
        contentView.addSubview(vStackView)
        vStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        vStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
