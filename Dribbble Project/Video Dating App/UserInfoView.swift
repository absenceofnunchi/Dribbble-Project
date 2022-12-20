//
//  UserInfoView.swift
//  Dribbble Project
//
//  Created by Jeff Choi on 2022-12-17.
//

import UIKit

final class UserInfoView: UIImageViewX {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    static func loadViewFromNib() -> Self {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "UserInfoView", bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).first {
            ($0 as? UIView)?.restorationIdentifier == "1"
        }! as! Self
    }
}

class UserInfoWrapperView: UIView {
    var contentView: UserInfoView
    
    required init?(coder aDecoder: NSCoder) {
        contentView = UserInfoView.loadViewFromNib()
        super.init(coder: aDecoder)
        contentView.frame = bounds
        addSubview(contentView)
    }
}
