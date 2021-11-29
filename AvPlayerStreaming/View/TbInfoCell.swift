//
//  TbInfoCell.swift
//  AvPlayerStreaming
//
//  Created by SAIF ULLAH on 28/11/2021.
//

import UIKit

class TbInfoCell: UITableViewCell {

    @IBOutlet weak var lbl : UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override func layoutSubviews() {
        self.backgroundColor = .black
        self.selectionStyle = .none
    }
    func update(text : String? , isSelected : Bool) {
        lbl?.text = text
        lbl?.textColor = isSelected == true ? #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) : .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
