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
        SimpleEntry(date: Date(), widgetData: [WidgetData(text: "😃")])
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), widgetData: [WidgetData(text: "😃")])
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let sharedDefaults = UserDefaults.init(suiteName: "group.app.moodometer.widgetGroup")
        
        var widgetData: [WidgetData]? = nil
        
        if(sharedDefaults != nil){
            do{
                let shared = sharedDefaults?.string(forKey: "widgetData")
                if(shared != nil){
                    let decoder = JSONDecoder()
                    widgetData = try decoder.decode([WidgetData].self, from: shared!.data(using: .utf8)!)
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
    let widgetData: [WidgetData]
}

struct MoodoWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    func getItemsCount() -> Int{
        switch widgetFamily{
        case .systemSmall:
            return 1;
        case .systemMedium:
            return 3;
        case .systemLarge:
            return 6;
        case .systemExtraLarge:
            return 0;
        @unknown default:
            return 0;
        }
    }
    
    func getUiColorForMood(mood: String) -> UIColor{
        switch mood{
        case "😭":
            return UIColor.cyan;
        case "😢":
            return UIColor.blue;
        case "😐":
            return UIColor.black;
        case "😊":
            return UIColor(red: 0.62, green: 0.62, blue: 0.00, alpha: 1.00);
        case "😄":
            return UIColor(red: 0.69, green: 0.69, blue: 0.00, alpha: 1.00);
        case "😁":
            return UIColor(red: 0.77, green: 0.77, blue: 0.00, alpha: 1.00);
        case "😀":
            return UIColor(red: 0.85, green: 0.85, blue: 0.00, alpha: 1.00);
        case "😃":
            return UIColor(red: 0.92, green: 0.92, blue: 0.00, alpha: 1.00);
        case "😆":
            return UIColor(red: 1.00, green: 1.00, blue: 0.00, alpha: 1.00);
        case "😡":
            return UIColor.red;
        default:
            return UIColor.systemBlue;
        }
    }
    
    func calculateArrayLength(items: Int) -> Int{
        if(items > 1){
            return 2;
        }else{
            return 0;
        }
    }
    
    var body: some View {
        var items: Int = entry.widgetData.count;
        if(items > getItemsCount()){
            let _ = items = getItemsCount();
        }
        
        let columns = (0...calculateArrayLength(items: items)).map{_ in GridItem()}
        LazyVGrid(columns: columns){
            ForEach(0...items-1, id: \.self){ i in
                VStack{
                    Text(entry.widgetData[i].text)
                        .font(.system(size: 50))
                        .padding(1)
                        .background(Color.init(getUiColorForMood(mood: entry.widgetData[i].text).withAlphaComponent(0.2)))
                        .clipShape(Circle())
                    
                    Spacer().frame(height: 10)
                    
                    Text(String("Maximilian-Fritz")).foregroundColor(Color.white).multilineTextAlignment(.center)
                }.frame(maxWidth: .infinity)
            }
            if(items < getItemsCount()){
                let widthHeight = "😀".size(font: UIFont.systemFont(ofSize: 50), width: 50);
                Link(destination: URL(string: "moodo:///widget")!, label: {
                    Text("+")
                        .font(.system(size: 30))
                        .padding(1)
                        .frame(width: widthHeight.width, height: widthHeight.height)
                        .background(Color.gray)
                        .clipShape(Circle())
                        .foregroundColor(Color.white)
                })
            }
        }
    }
}

@main
struct MoodoWidget: Widget {
    let kind: String = "MoodoWidget"
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MoodoWidgetEntryView(entry: entry).frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [
                    Color(red: 0.80, green: 0.55, blue: 0.38),
                    Color(red: 0.28, green: 0.36, blue: 0.42)
                ]), startPoint: .top, endPoint: .bottom))
            
        }
        .configurationDisplayName(kind)
        .description("This widget lets you display your and you'r friends mood.")
    }
}

struct MoodoWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MoodoWidgetEntryView(entry: SimpleEntry(date: Date(), widgetData: [WidgetData(text: "😃")]))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
        }
    }
}
extension String {
  func size(font: UIFont, width: CGFloat) -> CGSize {
      let attrString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.font: font])
        let bounds = attrString.boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        let size = CGSize(width: bounds.width, height: bounds.height)
        return size
    }
}
