//
//  ViewController.swift
//  Contacts
//
//  Created by Fateme' Kazemi on 7/26/1397 AP.
//  Copyright © 1397 Fateme' Kazemi. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContacts()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func fetchContacts() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted,err) in
            if let err = err {
                print("Failed to request",err)
                return
            }
            if granted {
                print("Access to contacts")
                let keys = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    try store.enumerateContacts(with: request, usingBlock: {(contact,stopPointerIfYouWantToStopEnumerating) in
                        print(contact.givenName)
                        print(contact.familyName)
                        print(contact.phoneNumbers.first?.value.stringValue ?? "")
                    })
                } catch let err {
                    print("fail to enumerate contact",err)
                }
                
            }
            else {
                print("Access denied")
            }
        }
    }
    
}

