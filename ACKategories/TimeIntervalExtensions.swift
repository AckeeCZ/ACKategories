import Foundation

extension TimeInterval {
    /// One minute
    public static var minute: TimeInterval { return TimeInterval(60) }
    
    /// One hour
    public static var hour: TimeInterval { return minute * 60 }
    
    /// One day
    public static var day: TimeInterval { return hour * 24 }
}
