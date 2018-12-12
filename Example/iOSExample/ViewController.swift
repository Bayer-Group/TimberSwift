import UIKit
import TimberSwift

class ViewController: UIViewController {
    let example = ExampleClass(log: AppSession.shared.timber.log, analytics: AppSession.shared.timber.analytics)
    
    override func viewDidLoad() {
        AppSession.shared.timber.analytics.setScreen(title: "Main")
    }
    
    @IBAction func pressMeButtonTapped(_ sender: Any) {
        let traceIndentifier = UUID()
        
        AppSession.shared.timber.performance.startTrace(key: "Hello", identifier: traceIndentifier, properties: ["Hello": "Again"])
        
        AppSession.shared.timber.analytics.recordEvent(title: "Press Me Button Tapped", properties: ["1": "2"])
        
        AppSession.shared.timber.performance.incrementTraceCounter(key: "Hello", identifier: traceIndentifier, named: "There", by: 1)
        
        AppSession.shared.timber.userMessage.toast("Example toast message!", displayTime: 3, type: .success)
        
        example.actionTaken()
        
        AppSession.shared.timber.performance.stopTrace(key: "Hello", identifier: traceIndentifier)
        
        AppSession.shared.timber.network.startedActivity()

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            AppSession.shared.timber.network.endedActivity()
        }
    }
}
