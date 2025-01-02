import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    let groupId = "group.study.home_widget_silent_notification"
    let widgetExtensionname = "HomeWidgetSilentNotification"
    let userDefaultsKey = "lastTimeStamp"

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "placeholder")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let userDefaults = UserDefaults(suiteName: groupId)
        let storedValue = userDefaults?.string(forKey: userDefaultsKey)
        print(storedValue ?? "No stored value")

        let now = Date()
        let entryText = "set by swift " + now.toIso8601()
        userDefaults?.set(entryText, forKey: userDefaultsKey)
        let entry = SimpleEntry(date: now, emoji: entryText)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let userDefaults = UserDefaults(suiteName: groupId)
        let storedValue = userDefaults?.string(forKey: userDefaultsKey)
        print(storedValue ?? "No stored value")

        let now = Date()
        let entryText = "set by swift " + now.toIso8601()
        userDefaults?.set(entryText, forKey: userDefaultsKey)
        let entry = SimpleEntry(date: now, emoji: entryText)

        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let data: String
}

struct HomeWidgetSilentNotificationEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Emoji:")
            Text(entry.data)
        }
    }
}

struct HomeWidgetSilentNotification: Widget {
    let kind: String = "HomeWidgetSilentNotification"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                HomeWidgetSilentNotificationEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                HomeWidgetSilentNotificationEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
