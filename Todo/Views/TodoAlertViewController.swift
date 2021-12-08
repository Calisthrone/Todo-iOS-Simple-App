//
//  TodoAlertVC.swift
//  Todo
//
//  Created by Mohamed Esaa on 08/12/2021.
//

import UIKit
import CleanyModal

/*
 This class represents the styke of delete alert shwon when the
 user is being warned when a todo task is about to be deleted
 */
class TodoAlertViewController: CleanyAlertViewController {
    init(title: String?, message: String?, imageName: String? = nil, preferredStyle: CleanyAlertViewController.Style = .actionSheet) {
        let styleSettings = CleanyAlertConfig.getDefaultStyleSettings()
        styleSettings[.tintColor] = .yellow
        styleSettings[.destructiveColor] = .systemPink
        styleSettings[.defaultActionColor] = .systemTeal
        super.init(title: title, message: message, imageName: imageName, preferredStyle: preferredStyle, styleSettings: styleSettings)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
