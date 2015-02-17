import UIKit

class TextfieldCell: UITableViewCell, UITextFieldDelegate {

	let textField: UITextField
	let displayLabel: UILabel
	let valueLabel: UILabel
	var textfieldWidthConstraint: NSLayoutConstraint?
	
	var dataItem: DataItem? {
		didSet {
			if let item = dataItem {
				displayLabel.text = item.displayName
				if let value = item.value as? String {
					valueLabel.text = value
				}
			}
		}
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		textField = UITextField()
		displayLabel = UILabel()
		valueLabel = UILabel()
		super.init(style: .Default, reuseIdentifier: reuseIdentifier)
		postInit()
	}

	required init(coder aDecoder: NSCoder) {
		textField = UITextField()
		displayLabel = UILabel()
		valueLabel = UILabel()
		super.init(coder: aDecoder)
		postInit()
	}
	
	func postInit() {
		self.selectionStyle = .None
		textField.setTranslatesAutoresizingMaskIntoConstraints(false)
		textField.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
		textField.delegate = self
		self.contentView.addSubview(textField)
		textfieldWidthConstraint = NSLayoutConstraint(item: textField, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 0)
		textField.addConstraint(textfieldWidthConstraint!)
		self.contentView.addConstraints([
			NSLayoutConstraint(item: textField, attribute: .Trailing, relatedBy: .Equal, toItem: self.contentView, attribute: .TrailingMargin, multiplier: 1.0, constant: -8.0),
			NSLayoutConstraint(item: textField, attribute: .Top, relatedBy: .Equal, toItem: self.contentView, attribute: .Top, multiplier: 1.0, constant: 0),
			NSLayoutConstraint(item: textField, attribute: .Bottom, relatedBy: .Equal, toItem: self.contentView, attribute: .Bottom, multiplier: 1.0, constant: 0)
			])
		displayLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
		self.contentView.addSubview(displayLabel)
		valueLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
		valueLabel.textAlignment = .Right
		self.contentView.addSubview(valueLabel)
		self.contentView.addConstraints([
			NSLayoutConstraint(item: displayLabel, attribute: .Leading, relatedBy: .Equal, toItem: self.contentView, attribute: .LeadingMargin, multiplier: 1.0, constant: 8.0),
			NSLayoutConstraint(item: displayLabel, attribute: .Top, relatedBy: .Equal, toItem: self.contentView, attribute: .TopMargin, multiplier: 1.0, constant: 0),
			NSLayoutConstraint(item: displayLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self.contentView, attribute: .BottomMargin, multiplier: 1.0, constant: 0)
			])
		self.contentView.addConstraints([
			NSLayoutConstraint(item: valueLabel, attribute: .Trailing, relatedBy: .Equal, toItem: self.contentView, attribute: .TrailingMargin, multiplier: 1.0, constant: -8.0),
			NSLayoutConstraint(item: valueLabel, attribute: .Top, relatedBy: .Equal, toItem: self.contentView, attribute: .TopMargin, multiplier: 1.0, constant: 0),
			NSLayoutConstraint(item: valueLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self.contentView, attribute: .BottomMargin, multiplier: 1.0, constant: 0)
			])
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		if selected {
			showTextfield(true)
		}
	}
	
	func showTextfield(show: Bool) {
		textfieldWidthConstraint?.constant = show ? self.contentView.frame.size.width - 30 :  0
		textField.placeholder = displayLabel.text
		displayLabel.hidden = show
		valueLabel.hidden = show
		UIView.animateWithDuration(0.25) {
			self.layoutIfNeeded()
		}
		if valueLabel.text != nil && valueLabel.text != "" {
			textField.text = show ? valueLabel.text : ""
		}
		if show {
			textField.becomeFirstResponder()
		}
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		dataItem?.setValue(textField.text)
		showTextfield(false)
		return true
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		dataItem?.setValue(textField.text)
		showTextfield(false)
	}
	
	
}
