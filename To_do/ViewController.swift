//
//  ViewController.swift
//  To_do
//
//  Created by Catarau, Bianca on 04.04.2023.
//

import UIKit
import UserNotifications
import AVFoundation


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkForPermission()
        setupBackgroundMusic()
        backgroundMusicPlayer?.play()
    }
    var backgroundMusicPlayer: AVAudioPlayer?

    func setupBackgroundMusic() {
        guard let backgroundMusicURL = Bundle.main.url(forResource: "background_music", withExtension: "mp3") else {
            return
        }
        
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: backgroundMusicURL)
            backgroundMusicPlayer?.numberOfLoops = -1 // To loop the music indefinitely
            backgroundMusicPlayer?.prepareToPlay()
        } catch {
            print("Error loading background music: \(error.localizedDescription)")
        }
    }


    func checkForPermission() {
           let notificationCenter = UNUserNotificationCenter.current()
           notificationCenter.getNotificationSettings { settings in
               switch settings.authorizationStatus{
               case .authorized:
                   self.dispatchNotification()
               case .denied:
                   return
               case .notDetermined:
                   notificationCenter.requestAuthorization( options: [.alert, .sound]) { didAllow, error in
                       if didAllow {
                           self.dispatchNotification()
                       }
                   }
               default:
                   return
               }
           }
       }
       
       
       func dispatchNotification() {
           let identifier = "my-morning-notification"
           let title = "Time to add a new task"
           let body = "Don't forget to update the old ones too!"
           let hour = 15
           let minute = 02
           let isDaily = true
           
           let notificationCenter = UNUserNotificationCenter.current()
           
           let content = UNMutableNotificationContent()
           content.title = title
           content.body = body
           content.sound = .default
           
           let calendar = Calendar.current
           var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
           dateComponents.hour = hour
           dateComponents.minute = minute
           
           let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
           let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
           
           notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
           notificationCenter.add(request)
       }

}

