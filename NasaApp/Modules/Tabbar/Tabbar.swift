//
//  Tabbar.swift
//  NasaApp
//
//  Created by Juan Camilo on 14/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import UIKit

class Tabbar: UIView {
    
    @IBOutlet weak var rootTabbarView: UIView!
    @IBOutlet weak var iconMenu: UIImageView!
    @IBOutlet weak var iconSearch: UIImageView!
    @IBOutlet weak var iconUser: UIImageView!
    @IBOutlet var rootContentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
        setupView()
    }
    
    func loadViewFromNib() {
        let bundle = Bundle.init(for: Tabbar.self)
        
        if let viewsForAdd = bundle.loadNibNamed("Tabbar", owner: self, options: nil), let contentView = viewsForAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    func setupView() {
        rootTabbarView.backgroundColor = ApplicationColor.purpleDark
        iconMenu.tintColor = ApplicationColor.pink
        iconUser.tintColor = ApplicationColor.desabledPurple
        iconSearch.tintColor = ApplicationColor.desabledPurple
    }
}
