public protocol NetworkProtocol {
    /** Notification to parent app that network activity has started, so it can track the number of current network calls and display the network activity indicator as desired. */
    func startedActivity()
    /** Notification to parent app that network activity has ended, so it can track the number of current network calls and display the network activity indicator as desired. */
    func endedActivity()
}

internal protocol NetworkDelegate: class {
    func startedActivity()
    func endedActivity()
}

internal class Network: NetworkProtocol {
    weak var networkDelegate: NetworkDelegate?

    func startedActivity() { networkDelegate?.startedActivity() }
    
    func endedActivity() { networkDelegate?.endedActivity() }
}
