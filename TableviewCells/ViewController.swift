import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var tableView: UITableView!
	let items = [
		DataItem(displayName:"Foo", value:"Bar")
	]
	
	override func viewDidLoad() {
		tableView.registerClass(TextfieldCell.self, forCellReuseIdentifier: "TextfieldCell")
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let item = items[indexPath.row]
		let cell = tableView.dequeueReusableCellWithIdentifier("TextfieldCell") as TextfieldCell
		cell.dataItem = item
		return cell
	}
}

