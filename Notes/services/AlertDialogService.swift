//
//  AlertDialogService.swift
//  Notes
//
//  Created by Boehmich on 11.01.22.
//  Copyright © 2022 boehmich. All rights reserved.
//

import Foundation
import UIKit

class AlertDialogService{
    
    
    func getAlertController(title: String, deleteAction: @escaping () -> Void  ) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: NSLocalizedString("delete_message", comment: ""), preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: NSLocalizedString("delete", comment: ""), style: .default) { (action) in
            deleteAction()
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .destructive, handler: nil)

        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
}
