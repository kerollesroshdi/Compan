 //
//  CompanyCell.swift
//  Compan
//
//  Created by Kerolles Roshdi on 2/23/19.
//  Copyright © 2019 Kerolles Roshdi. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    var company: Company? {
        didSet {
            
            if let name = company?.name, let founded = company?.founded {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy"
                let foundedDate = dateFormatter.string(from: founded)
                nameFoundedDate.text = "\(name) - Founded: \(foundedDate)"
            } else {
                nameFoundedDate.text = company?.name
            }
            
            if let imageData = company?.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    let companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // making image circular
        imageView.layer.cornerRadius = 25
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameFoundedDate: UILabel = {
        let label = UILabel()
        label.text = "Company Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .teal
        
        addSubview(companyImageView)
        companyImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        companyImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(nameFoundedDate)
        nameFoundedDate.leftAnchor.constraint(equalTo: companyImageView.rightAnchor, constant: 8).isActive = true
        nameFoundedDate.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameFoundedDate.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        nameFoundedDate.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
