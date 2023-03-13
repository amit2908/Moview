//
//  EventView.swift
//  Moview
//
//  Created by Shubham Ojha on 18/06/22.
//  Copyright © 2022 Shubham. All rights reserved.
//

import SwiftUI

struct EventView: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .center, spacing: 10.0) {
            HStack(alignment: .center) {
                Text(event.title)
                Spacer()
                Text(event.time)
            }.padding()
        }
        
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event(title: "Event 1", time: "11:00 PM", movieId: "Dil to pagal hai"))
    }
}
