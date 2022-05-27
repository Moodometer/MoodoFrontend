//
//  MoodoWidget.swift
//  MoodoWidget
//
//  Created by Tim . on 27.05.22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), widgetData: WidgetData(text: "😃"))
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), widgetData: WidgetData(text: "😃"))
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let sharedDefaults = UserDefaults.init(suiteName: "group.app.moodometer.widgetGroup")
        
        var widgetData: WidgetData? = nil
        
        if(sharedDefaults != nil){
            do{
                let shared = sharedDefaults?.string(forKey: "widgetData")
                if(shared != nil){
                    let decoder = JSONDecoder()
                    widgetData = try decoder.decode(WidgetData.self, from: shared!.data(using: .utf8)!)
                }
            }catch{
                print(error)
            }
        }
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
            let entryDate = Calendar.current.date(byAdding: .hour, value: 24, to: currentDate)!
        let entry = SimpleEntry(date: entryDate, widgetData: widgetData!)
            entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetData: Decodable, Hashable{
    let text: String
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let widgetData: WidgetData
}

struct MoodoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.widgetData.text)
    }
}

@main
struct MoodoWidget: Widget {
    let kind: String = "MoodoWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MoodoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct MoodoWidget_Previews: PreviewProvider {
    static var previews: some View {
        MoodoWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: WidgetData(text: "😃")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
