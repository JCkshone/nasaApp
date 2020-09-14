//
//  SwipeCard.swift
//  NasaApp
//
//  Created by Juan Camilo on 14/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SwipeCard: UIView {
    @IBOutlet weak var planetImg: UIImageView!
    @IBOutlet weak var rootSwipeCard: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var rootContent: UIView! {
        didSet {
            rootContent.roundCorners(corners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner], radius: 30)
        }
    }
    @IBOutlet weak var btnShowMore: UIButton! {
        didSet {
            btnShowMore.setTitleColor(ApplicationColor.pink, for: .normal)
        }
    }
    private var icon: String = "planet\(Int.random(in: 1...9))"
    private let disposebag = DisposeBag()
    
    var coordinator: MainCoordinator?
    
    var data: ApodItem? = nil {
        didSet {
            guard let data = data else { return }
            nameLabel.text = data.title
            planetImg.image = UIImage(named: icon) ?? UIImage()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        setupEvents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
        setupEvents()
    }
    
    override func awakeFromNib() {
        planetImg.image = UIImage()
        nameLabel.text = ""
    }
    
    func loadViewFromNib() {
        let bundle = Bundle.init(for: SwipeCard.self)
        
        if let viewsForAdd = bundle.loadNibNamed("SwipeCard", owner: self, options: nil), let contentView = viewsForAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    func setupEvents() {
        btnShowMore.rx.tap.bind { _ in
            guard let data = self.data else { return }
            self.coordinator?.showApodDetail(item: data, image: self.icon)
        }.disposed(by: disposebag)
    }
}
