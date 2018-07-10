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
import TextToSpeechV1
import AVFoundation



//adding class DataSource and Delegate for our TableView
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //the Web API URL
    let URL_GET_DATA = "https://simplifiedcoding.net/demos/marvel/"
    
    //our table view
    @IBOutlet weak var tableViewHeroes: UITableView!
    
    


    
    //the method returning size of the list
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return MenuItems.menu.count
    }
    
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        //getting the hero for the specified position
        let menu: Menu
        menu =  MenuItems.menu[indexPath.row]
        
        //displaying values
        cell.labelName.text = menu.name
        cell.labelTeam.text = menu.team
        
       // cell.heroImage.image = AppDelegate.image
        //displaying image
      
        URLCache.shared.removeAllCachedResponses()
        Alamofire.request("https://dl.dropboxusercontent.com/s/mru9qumcme99ucs/test.jpg").responseImage { response in
            debugPrint(response)
            
            if let image = response.result.value {
                cell.heroImage.image = image
            }
        }

        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerBMSPush()
        
//        //fetching data from web api
//        Alamofire.request(URL_GET_DATA).responseJSON { response in
//
//            //getting json
//            if let json = response.result.value {
//
//                //converting json to NSArray
//                let heroesArray : NSArray  = json as! NSArray
//                
//                //traversing through all elements of the array
//                for i in 0..<heroesArray.count{
//
//                    //adding hero values to the hero list
//                    AppDelegate.heroes.append(Hero(
//                        name: (heroesArray[i] as AnyObject).value(forKey: "name") as? String,
//                        team: (heroesArray[i] as AnyObject).value(forKey: "team") as? String,
//                        imageUrl: (heroesArray[i] as AnyObject).value(forKey: "imageurl") as? String
//                    ))
//
//                }
//
//                //displaying data in tableview
//                self.tableViewHeroes.reloadData()
//            }
//
//        }
//
//
//        self.tableViewHeroes.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playAudio() {
        // Text to Speech service object
        var textToSpeech = TextToSpeech(
            username: "asdfsa",
            password: "ASDfas")
        
        // Audio player for playing synthesized text
        var audioPlayer = AVAudioPlayer()
        let text = "your-text-here"
        let accept = "audio/wav"
        let voice = "en-US_LisaVoice"
        let failure = { (error: Error) in print(error) }
        textToSpeech.synthesize(text: text, accept: accept, voice: voice, failure: failure) { data in
            audioPlayer = try! AVAudioPlayer(data: data)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
    }
    
    
}
