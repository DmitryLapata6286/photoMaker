//
//  TestTableViewCell.swift
//  PhotoMaker
//
//  Created by Dmitry Lapata on 25.08.22.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var iv: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 10
        backView.backgroundColor = .darkGray
        selectionStyle = .none
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        testLabel.text = nil
        iv.image = nil

    }
    func configure(model: CellViewModelProtocol) {
        testLabel.text = model.nameString
        iv.image = model.realImage
    }
    
}
