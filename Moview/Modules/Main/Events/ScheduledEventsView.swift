//
//  ScheduledEventsView.swift
//  Moview
//
//  Created by Shubham Ojha on 18/06/22.
//  Copyright © 2022 Shubham. All rights reserved.
//

import SwiftUI

struct ScheduledEventsView: View {
    let events: [Event]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(events){ event in
                    Text(event.title)
                }
            }.navigationTitle("Events")
        }
    }
}

struct ScheduledEventsView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduledEventsView(events: [Event(title: "Finish 1st", time: "11:00 PM", movieId: "xyz"),
                                     Event(title: "Finish 2nd", time: "11:00 PM", movieId: "xyz")])
    }
}
