
import Foundation

    struct Str {
        var year: String
        var month: String
        var day: String
        var arm: String
        var belly: String
        var spine: String
        var squat: String
        var plank: String
        
        init(year: String, month: String, day: String, arm: String, belly: String, spine: String, squat: String, plank: String) {
            
            self.year = year
            self.month = month
            self.day = day
            self.arm = arm
            self.belly = belly
            self.spine = spine
            self.squat = squat
            self.plank = plank
        }
        
    }
 
extension Str:Codable {}

