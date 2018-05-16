public struct Source {
    public let title: String
    public let version: String
    public let emoji: Character
    
    /**
     - parameter title: Intended to store space seperated capitalized words. No camel case, dashes, or underscores if you want someone other than a developer to read it.
     - parameter version: The version of the source framework or application.
     - parameter emoji: An emoji character used when building a message for console logging.
     */
    public init(title: String, version: String, emoji: Character) {
        self.title = title
        self.version = version
        self.emoji = emoji
    }
}
