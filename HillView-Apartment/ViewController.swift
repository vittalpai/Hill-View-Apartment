//
//  ViewController.swift
//  Hill View Apartment
//
//  Created by Vittal Pai on 7/10/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AVFoundation
import TextToSpeechV1
import PopupDialog



//adding class DataSource and Delegate for our TableView
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //the Web API URL
    let URL_GET_DATA = "https://simplifiedcoding.net/demos/marvel/"
    var audioPlayer = AVAudioPlayer()
    
    //our table view
    @IBOutlet weak var tableViewHeroes: UITableView!
    
    


    
    //the method returning size of the list
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return MenuItems.menu.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(MenuItems.menu[indexPath.row].name == "Live Feeds") {
            performSegue(withIdentifier: "navigateLiveFeed", sender: self)
        } else {
            showAlert("This feature is yet to be implemented")
        }
    }
    
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        let menu: Menu
        menu =  MenuItems.menu[indexPath.row]
        
        //displaying values
        cell.labelName.text = menu.name
        cell.labelTeam.text = menu.team
        cell.heroImage.image = UIImage(named: menu.image!)
        return cell
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerBMSPush()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  

    
    func playAudio(message: String) {
        // Text to Speech service object
        var textToSpeech = TextToSpeech(
            username: "3703dad4-2b57-4e67-920f-cfa7dda88f21",
            password: "NFynwMO0zfdq")
        
        let text = message
        let accept = "audio/wav"
        let voice = "en-US_LisaVoice"
        let failure = { (error: Error) in
            print(error)
            
        }
        let path = Bundle.main.path(forResource: "alaram.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        textToSpeech.synthesize(text: text, accept: accept, voice: voice, failure: failure) { data in
            self.audioPlayer = try! AVAudioPlayer(contentsOf: url)
            self.showAlert(message: text)
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                self.audioPlayer = try! AVAudioPlayer(data: data)
                self.audioPlayer.prepareToPlay()
                self.audioPlayer.play()
            })
        }
    }
    
    
    
    
    func showAlert(message: String) {
        // Prepare the popup assets
        let title = "Warning"
        let message = message
        let image = UIImage(named: "flood-alert.jpeg")
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)
        
        // Create buttons
        let buttonOne = CancelButton(title: "CANCEL") {
            print("You canceled the car dialog.")
        }
        
        // This button will not the dismiss the dialog
        let buttonTwo = DefaultButton(title: "Show Live Feed", dismissOnTap: true) {
            self.navigateToLiveFeed()
        }
        
        popup.addButtons([buttonTwo, buttonOne])
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
        
        
        
    }
    
    func navigateToLiveFeed() {
        self.performSegue(withIdentifier: "navigateLiveFeed", sender: self)
    }
    
    
}

extension UIApplication {
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}
