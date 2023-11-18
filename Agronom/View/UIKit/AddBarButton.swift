//
//  addBarButton.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import UIKit

final class AddBarButton: UIBarButtonItem {
    
    var completion: (() -> Void)? = nil
    
    init(title: String? = nil, image: UIImage? = nil) {
        super.init()
        self.title = title
        self.image = image
        self.target = self
        self.action = #selector(self.addAction)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func addAction() {
        self.completion?()
    }
    
}
