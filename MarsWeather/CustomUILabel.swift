//
//  TitleUILabel.swift
//  MarsWeather
//
//  Created by Enzo Antonino on 16/09/2017.
//  Copyright © 2017 Enzo Antonino. All rights reserved.
//

import UIKit

class TitleDetailUILabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: 16)
    }

}

class DetailUILabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textColor = UIColor.white
        self.font = UIFont.boldSystemFont(ofSize: 18)
        self.text = "--"
        
//        let bottomBorder = CALayer()
//        bottomBorder.borderColor = UIColor.white.cgColor
//        bottomBorder.borderWidth = 1
//        bottomBorder.frame = CGRect(x: -1,y: -1, width: self.frame.size.width*2, height: self.frame.height+2)
//        self.clipsToBounds = true
//        self.layer.addSublayer(bottomBorder)

    }
    
}

class ArchiveDetailUILabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textColor = UIColor.white
        self.font = UIFont.boldSystemFont(ofSize: 18)
        self.text = "--"
        
    }

    
}

class TitleUILabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textColor = UIColor.white
        self.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
}

class SubtitleUILabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: 18)
        self.text = "--"
    }
    
}
