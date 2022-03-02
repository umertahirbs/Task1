//



import Foundation
import UIKit

public class LoadingOverlay{
    
    var overlayView : UIView!
    var activityIndicator : UIActivityIndicatorView!
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    init(){
        self.overlayView = UIView()
        self.activityIndicator = UIActivityIndicatorView()
        
        overlayView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        overlayView.layer.zPosition = 1
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = UIColor.white
        overlayView.addSubview(activityIndicator)
        
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        let cpoint = CGPoint(x: activityIndicator.frame.origin.x + activityIndicator.frame.size.width / 2, y: activityIndicator.frame.origin.y + 50)
        lbl.center = cpoint
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.text = "Loading..."
        lbl.tag = 1234
        overlayView.addSubview(lbl)
        
        
    }
    
    public func showOverlay(view: UIView) {
        overlayView.center = view.center
        view.isUserInteractionEnabled = false
        view.addSubview(overlayView)
        activityIndicator.startAnimating()
        
    }
    
    public func hideOverlayView(view: UIView) {
        view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
