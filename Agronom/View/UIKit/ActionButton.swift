//
//  ActionButton.swift
//  Agronom
//
//  Created by Grigory Sapogov on 19.11.2023.
//

import UIKit

class ActionButton: UIButton {
    
    var action: (() -> Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    @objc
    func actionButton() {
        self.action?()
    }
    
    func setup() {
        self.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
    
}

class StartCheckListButton: ActionButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    override func setup() {
        super.setup()
        self.setTitle("Начать выполнение", for: .normal)
        self.backgroundColor = .systemGreen
        self.titleLabel?.textColor = .white
    }
    
}

class FinishCheckListButton: ActionButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    override func setup() {
        super.setup()
        self.setTitle("Завершить выполнение", for: .normal)
        self.backgroundColor = .systemRed
        self.titleLabel?.textColor = .white
    }
    
}
