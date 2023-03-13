//
//  ScheduledEventsView.swift
//  Moview
//
//  Created by Shubham Ojha on 18/06/22.
//  Copyright © 2022 Shubham. All rights reserved.
//

import SwiftUI

struct ScheduledEventsView: View {
    @State var events: [Event]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(events){ event in
                        EventView(event: event)
                }
                .onDelete(perform: delete)
            }
            .toolbar(content: {
                EditButton()
            })
            .navigationTitle("Events")
        }
    }
    
    func delete(at offsets: IndexSet){
        self.events.remove(atOffsets: offsets)
    }
}

struct ScheduledEventsView_Previews: PreviewProvider {
    static var previews: some View {
        let events = [Event(title: "Pathaan", time: "04:50 pm", movieId: ""),
                      Event(title: "Pathaan", time: "04:50 pm", movieId: ""),
                      Event(title: "Pathaan", time: "04:50 pm", movieId: "")]
        ScheduledEventsView(events: events)
    }
}

struct TextButton: View
{
    @Binding var count: Int
    
    var body: some View {
        Button("\(count) Text Button") {
            count += 1
        }
    }
}


struct CountButton: View
{
    @Binding var count: Int
    
    var body: some View {
        Button("\(count) times") {
            count += 1
        }
    }
}

//Next, we’re creating a CounterView:

struct CounterView: View
{
    @State private var swiftCount: Int = 0
    
    var body: some View {
        HStack {
            Text("Times spotted a purple-and-gold-striped swift: \(swiftCount)")
            CountButton(count: $swiftCount)
        }
    }
}

