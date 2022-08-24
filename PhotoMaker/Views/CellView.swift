//
//  CellView.swift
//  PhotoMaker
//
//  Created by Dmitry Lapata on 23.08.22.
//

import Foundation
import UIKit

class CellView: UITableViewCell{
    static let identifier = "CellView"
    
    // MARK: - GUI Elements
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 10,
                                        y: 5,
                                        width: self.frame.width - 10,
                                        height: 95))
        view.backgroundColor = UIColor(red: 247 / 255,
                                       green: 235 / 255,
                                       blue: 216 / 255,
                                       alpha: 1)
        return view
    }()
    
    lazy var customImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 5,
                                                  y: 5,
                                                  width: 85,
                                                  height: 85))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 95,
                                          y: 5,
                                          width: backView.frame.width - 95,
                                          height: 30))
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    
    override func prepareForReuse() {
        super.prepareForReuse()
        customImageView.image = nil
        nameLabel.text = nil
        
        //TODO: - reuse logic
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        backView.addSubview(customImageView)
        backView.addSubview(nameLabel)
    }
    
    //func configure(with: ){}
}

