//
//  UserNotificationManager.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/23.
//

import Foundation
import UserNotifications

struct ThingNotificationManager {
    static func setThingNotification(_ thing: Thing) {
        let content = UNMutableNotificationContent()
        content.title = thing.title
        content.body = thing.detailDescription ?? String.empty
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: thing.date)
        dateComponents.hour = 9
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: false)
        let notificationID = String(thing.creationDate)
        let request = UNNotificationRequest(identifier: notificationID,
                    content: content, trigger: trigger)

        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request, withCompletionHandler: nil)
    }
    
    static func removeThingNotification(_ thing: Thing) {
        let notificationCenter = UNUserNotificationCenter.current()
        let notificationID = String(thing.creationDate)
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [notificationID])
    }
    
    static func updateThingNotification(_ thing: Thing) {
        removeThingNotification(thing)
        setThingNotification(thing)
    }
}
