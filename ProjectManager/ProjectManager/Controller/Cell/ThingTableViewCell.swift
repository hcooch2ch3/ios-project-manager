//
//  ThingTableViewCell.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/10.
//

import UIKit

class ThingTableViewCell: UITableViewCell {
    
    // MARK: - Property
    
    static var identifier: String {
        return "\(self)"
    }
    var isDone: Bool = false
    
    // MARK: - Outlet
    
    private let titleLabel: UILabel = makeLabel(textSize: .title3)
    private let bodyLabel: UILabel = makeLabel(textColor: .gray)
    private let dateLabel: UILabel = makeLabel(textSize: .caption1)
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configuerConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configuerConstraints()
    }
    
    // MARK: - UI
    
    static private func makeLabel(textColor: UIColor = .black, textSize: UIFont.TextStyle = .body) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = .preferredFont(forTextStyle: textSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func configuerConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            bodyLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    func configureCell(_ thing: Thing) {
        titleLabel.text = thing.title
        bodyLabel.text = thing.body
        bodyLabel.numberOfLines = 3
        dateLabel.text = thing.dateString
        changeDateColor(date: thing.date)
    }
    
    private func changeDateColor(date: Date) {
        if isDone == false, date < Date() {
            dateLabel.textColor = .red
        }
    }
}