

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    var colors: [ColorBox] = []
    var customerDetail : [CustomerDetails] = []
    
    
    static let sharedClient = SharedAPIClient()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 125
        tableView.rowHeight = UITableViewAutomaticDimension

          SharedAPIClient.sharedClient.getColors { [weak self](colors) in
            self?.colors = colors
            DispatchQueue.main.async(execute: {
                self?.tableView.reloadData()

                if colors.count > 0 {
                    self?.selected(colors.first!.color)
                }
            })
        }
     // Call webservice method
    self.testGetServiceCall()
        
    }
    
    func testGetServiceCall() {
        
        SharedAPIClient.sharedClient.getCustomrdetails({ [weak self] (customerDetail) in
            self?.customerDetail = customerDetail
           // let accessVar = customerDetail[2]
              // accessVar.MobileNumber
        })
    }
    
    func selected(_ color: UIColor) {
        headerView.backgroundColor = color
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath) as! ColorBoxTableViewCell

        let color = colors[indexPath.row]
        cell.configure(color)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let color = colors[indexPath.row]

        selected(color.color)
    }

    // I've removed this method of cell heights in favor of automatic cell heights!
    // see viewDidLoad for the other settings needed for this to work correctly
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let topSpace: CGFloat = 16
        let topLabelHeight: CGFloat = 25
        let topLabelSpacing: CGFloat = 7

        let color = colors[indexPath.row]
        let font = UIFont(name: "Helvetica", size: 17.0)!
        let textRect = (color.desc as NSString).boundingRect(with: CGSize(width: 240, height: 9999), options: [.usesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: NSStringDrawingContext())

        let textHeight: CGFloat = textRect.height

        return topSpace + topLabelHeight + topLabelSpacing + textHeight + topSpace
    }
}

