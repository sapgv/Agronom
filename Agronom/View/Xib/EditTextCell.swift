//
//  EditTextCell.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import UIKit

class EditTextCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    weak var growingDelegate: GrowingTableViewCellProtocol?
    
    var editChaged: ((String?) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textView.delegate = self
        self.textView.layer.borderWidth = 1
        self.textView.layer.borderColor = UIColor.separator.cgColor
        self.textView.layer.cornerRadius = 8
        self.textView.clipsToBounds = true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.editChaged?(textView.text)
        if let deletate = growingDelegate {
            deletate.updateHeightOfRow(self, textView)
        }
    }
    
}
