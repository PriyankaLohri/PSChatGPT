//
//  ViewController.swift
//  PSChatGPT
//
//  Created by Priyanka on 01/05/23.
//

import UIKit

class ViewController: UIViewController {

    let chatGPTClient = ChatGPTClient()
       
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
       }
    
    

    @IBAction func caseStudy(_ sender: Any) {
        chatGPTClient.caseStudy(userEnteredText: "Microservice vs Monolithic")
    }
    
    @IBAction func actionQuestion(_ sender: Any) {
        chatGPTClient.completeText(userEnteredText:"Mango is?")
    }
    
    @IBAction func actionSpellingCorrection(_ sender: Any) {
        chatGPTClient.editText(userEnteredText:"Hi how are yuo?")
    }
}

