//　通知許可
if #available(iOS 10.0, *) {
    // iOS 10
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
        if error != nil {
            return
        }

        if granted {
            print("通知許可")

            let center = UNUserNotificationCenter.current()
            center.delegate = self

        } else {
            print("通知拒否")
        }
    })

} else {
    // iOS 9以下
    let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
    UIApplication.shared.registerUserNotificationSettings(settings)
}

func applicationDifEnterBackground(_ application: UIApplication) {
/*　トリガー設定
　　 設定に必要なクラスをインスタンス化　*/
var notificationTime = DateComponents()
let trigger: UNNotificationTrigger

// 12時に通知する場合
notificationTime.hour = 12
notificationTime.minute = 0
trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true) //trueで毎回通知、falseで1度だけ通知

/* 通知内容の設定
　　　UNMutableNotificationContentクラスをインスタンス化 */
let content = UNMutableNotificationContent()
var lim:Int = 30
var todayslim:Int = 1

//　switch文でlim変数の残に応じて通知の変更
switch lim{
case 0:
// 通知のメッセージセット
content.title = "チケット切れ挙動"
content.body = "30日間経ちました。新たに購入してみましょう。"
content.sound = UNNotificationSound.default()

case 1:
content.title = "ラスト1日挙動"
content.body = "残り1日食べられます、ぜひ使いましょう。"
content.sound = UNNotificationSound.default()

case 2..<31: 
content.title = "通常制御挙動"
content.body = "今日の分を付与しました。ぜひ食べに行きましょう。"
content.sound = UNNotificationSound.default()

default:
// nothing
}

/*　通知登録
　　　通知スタイルを指定 */
let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)

// 通知をセット
UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

}

// https://qiita.com/yamataku29/items/f45e77de3026d4c50016#%E3%81%A7%E3%81%8D%E3%81%9F%E3%82%82%E3%81%AE //