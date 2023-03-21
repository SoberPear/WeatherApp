//
//  CustomCell.swift
//  weather app
//
//  Created by Алексей Волобуев on 16.03.2023.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    var cityLabel = UILabel()
    var tempLabel = UILabel()
    var conditionLabel = UILabel()
    var icon = UIImageView()
    
    public func configureCell() {
        self.addSubview(cityLabel)
        self.addSubview(tempLabel)
        self.addSubview(conditionLabel)
        self.addSubview(icon)
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        cityLabel.font = .boldSystemFont(ofSize: 20)
        tempLabel.font = .boldSystemFont(ofSize: 20)
        conditionLabel.font = .systemFont(ofSize: 10)
        cityLabel.textColor = .black
        tempLabel.textColor = .black
        conditionLabel.textColor = .gray
        
        cityLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cityLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        cityLabel.rightAnchor.constraint(equalTo: conditionLabel.leftAnchor, constant: 50).isActive = true
        cityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        conditionLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        conditionLabel.rightAnchor.constraint(equalTo: icon.leftAnchor, constant: 50).isActive = true
        conditionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        icon.rightAnchor.constraint(equalTo: tempLabel.leftAnchor, constant: 5).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.contentMode = .scaleAspectFit
        icon.clipsToBounds = true
        
        tempLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 5).isActive = true
        tempLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
