
import UIKit

class ColorBoxTableViewCell: UITableViewCell {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    func configure(_ color: ColorBox) {
        titleLabel.text = color.name
        descLabel.text = color.desc

        colorView.backgroundColor = color.color
    }
}
