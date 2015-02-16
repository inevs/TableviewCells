import Foundation

struct DataItem {
	var displayName: String
	var value: AnyObject?
	
	mutating func setValue(newValue: AnyObject?) {
		value = newValue
	}
}