//
//  Toast.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 5/5/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import Foundation
import UIKit

/*
 *  Infix overload method
 */
func /(lhs: CGFloat, rhs: Int) -> CGFloat {
    return lhs / CGFloat(rhs)
}

/*
 *  Toast Config
 */
let HRToastDefaultDuration  =   2.0
let HRToastFadeDuration     =   0.2
let HRToastHorizontalMargin : CGFloat  =   10.0
let HRToastVerticalMargin   : CGFloat  =   10.0

let HRToastPositionDefault  =   "bottom"
let HRToastPositionTop      =   "top"
let HRToastPositionCenter   =   "center"

// activity
let HRToastActivityWidth  :  CGFloat  = 100.0
let HRToastActivityHeight :  CGFloat  = 100.0
let HRToastActivityPositionDefault    = "center"

// image size
let HRToastImageViewWidth :  CGFloat  = 80.0
let HRToastImageViewHeight:  CGFloat  = 80.0

// label setting
let HRToastMaxWidth       :  CGFloat  = 0.8;      // 80% of parent view width
let HRToastMaxHeight      :  CGFloat  = 0.8;
let HRToastFontSize       :  CGFloat  = 16.0
let HRToastMaxTitleLines              = 0
let HRToastMaxMessageLines            = 0

// shadow appearance
let HRToastShadowOpacity  : CGFloat   = 0.8
let HRToastShadowRadius   : CGFloat   = 6.0
let HRToastShadowOffset   : CGSize    = CGSize(CGFloat(4.0), CGFloat(4.0))

let HRToastOpacity        : CGFloat   = 0.8
let HRToastCornerRadius   : CGFloat   = 10.0

var HRToastActivityView: UnsafePointer<UIView>?    =   nil
var HRToastTimer: UnsafePointer<Timer>?          =   nil
var HRToastView: UnsafePointer<UIView>?            =   nil

/*
 *  Custom Config
 */
let HRToastHidesOnTap       =   true
let HRToastDisplayShadow    =   true

//HRToast (UIView + Toast using Swift)

extension UIView {

    /*
     *  public methods
     */
    func makeToast(message msg: String) {
        self.makeToast(message: msg, duration: HRToastDefaultDuration, position: HRToastPositionDefault as AnyObject)
    }

    func makeToast(message msg: String, duration: Double, position: AnyObject) {
        let toast = self.viewForMessage(msg: msg, title: nil, image: nil)
        self.showToast(toast: toast!, duration: duration, position: position)
    }

    func makeToast(message msg: String, duration: Double, position: AnyObject, title: String) {
        let toast = self.viewForMessage(msg: msg, title: title, image: nil)
        self.showToast(toast: toast!, duration: duration, position: position)
    }

    func makeToast(message msg: String, duration: Double, position: AnyObject, image: UIImage) {
        let toast = self.viewForMessage(msg: msg, title: nil, image: image)
        self.showToast(toast: toast!, duration: duration, position: position)
    }

    func makeToast(message msg: String, duration: Double, position: AnyObject, title: String, image: UIImage) {
        let toast = self.viewForMessage(msg: msg, title: title, image: image)
        self.showToast(toast: toast!, duration: duration, position: position)
    }

    func showToast(toast: UIView) {
        self.showToast(toast: toast, duration: HRToastDefaultDuration, position: HRToastPositionDefault as AnyObject)
    }

    func showToast(toast: UIView, duration: Double, position: AnyObject) {
        let existToast = objc_getAssociatedObject(self, &HRToastView) as! UIView?
        if existToast != nil {
            if let timer: Timer = objc_getAssociatedObject(existToast ?? "Loading..", &HRToastTimer) as? Timer {
                timer.invalidate();
            }
            self.hideToast(toast: existToast!, force: false);
        }

        toast.center = self.centerPointForPosition(position: position, toast: toast)
        toast.alpha = 0.0

        if HRToastHidesOnTap {
            let tapRecognizer = UITapGestureRecognizer(target: toast, action: Selector(("handleToastTapped:")))
            toast.addGestureRecognizer(tapRecognizer)
            toast.isUserInteractionEnabled = true;
            toast.isExclusiveTouch = true;
        }

        self.addSubview(toast)
        objc_setAssociatedObject(self, &HRToastView, toast, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)

        UIView.animate(withDuration: HRToastFadeDuration,
                       delay: 0.0, options: ([.curveEaseOut, .allowUserInteraction]),
                                   animations: {
                                    toast.alpha = 1.0
        },
                                   completion: { (finished: Bool) in
                                    let timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: Selector(("toastTimerDidFinish:")), userInfo: toast, repeats: false)
                                    objc_setAssociatedObject(toast, &HRToastTimer, timer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        })
    }

    func makeToastActivity() {
        self.makeToastActivity(position: HRToastActivityPositionDefault as AnyObject)
    }

    func makeToastActivityWithMessage(message msg: String){
        self.makeToastActivity(position: HRToastActivityPositionDefault as AnyObject, message: msg)
    }

    func makeToastActivity(position pos: AnyObject, message msg: String = "") {
        let existingActivityView: UIView? = objc_getAssociatedObject(self, &HRToastActivityView) as? UIView
        if existingActivityView != nil { return }

        let activityView = UIView(frame: CGRect(0, 0, HRToastActivityWidth, HRToastActivityHeight))
        activityView.center = self.centerPointForPosition(position: pos, toast: activityView)
        activityView.backgroundColor = UIColor.black.withAlphaComponent(HRToastOpacity)
        activityView.alpha = 0.0
        activityView.autoresizingMask = ([.flexibleLeftMargin, .flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin])
        activityView.layer.cornerRadius = HRToastCornerRadius

        if HRToastDisplayShadow {
            activityView.layer.shadowColor = UIColor.black.cgColor
            activityView.layer.shadowOpacity = Float(HRToastShadowOpacity)
            activityView.layer.shadowRadius = HRToastShadowRadius
            activityView.layer.shadowOffset = HRToastShadowOffset
        }

        let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.center = CGPoint(activityView.bounds.size.width / 2, activityView.bounds.size.height / 2)
        activityView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()

        if (!msg.isEmpty){
            activityIndicatorView.frame.origin.y -= 10
            let activityMessageLabel = UILabel(frame: CGRect(activityView.bounds.origin.x, (activityIndicatorView.frame.origin.y + activityIndicatorView.frame.size.height + 10), activityView.bounds.size.width, 20))
            activityMessageLabel.textColor = UIColor.white
            activityMessageLabel.font = (msg.count<=10) ? UIFont(name:activityMessageLabel.font.fontName, size: 16) : UIFont(name:activityMessageLabel.font.fontName, size: 13)
            activityMessageLabel.textAlignment = .center
            activityMessageLabel.text = msg
            activityView.addSubview(activityMessageLabel)
        }

        self.addSubview(activityView)

        // associate activity view with self
        objc_setAssociatedObject(self, &HRToastActivityView, activityView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        UIView.animate(withDuration: HRToastFadeDuration,
                                   delay: 0.0,
                                   options: UIView.AnimationOptions.curveEaseOut,
                                   animations: {
                                    activityView.alpha = 1.0
        },
                                   completion: nil)
    }

    func hideToastActivity() {
        let existingActivityView = objc_getAssociatedObject(self, &HRToastActivityView) as! UIView?
        if existingActivityView == nil { return }
        UIView.animate(withDuration: HRToastFadeDuration,
                                   delay: 0.0,
                                   options: UIView.AnimationOptions.curveEaseOut,
                                   animations: {
                                    existingActivityView!.alpha = 0.0
        },
                                   completion: { (finished: Bool) in
                                    existingActivityView!.removeFromSuperview()
                                    objc_setAssociatedObject(self, &HRToastActivityView, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        })
    }

    /*
     *  private methods (helper)
     */
    func hideToast(toast: UIView) {
        self.hideToast(toast: toast, force: false);
    }

    func hideToast(toast: UIView, force: Bool) {
        let completeClosure = { (finish: Bool) -> () in
            toast.removeFromSuperview()
            objc_setAssociatedObject(self, &HRToastTimer, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        if force {
            completeClosure(true)
        } else {
            UIView.animate(withDuration: HRToastFadeDuration,
                                       delay: 0.0,
                                       options: ([.curveEaseIn, .beginFromCurrentState]),
                                       animations: {
                                        toast.alpha = 0.0
            },
                                       completion:completeClosure)
        }
    }

    func toastTimerDidFinish(timer: Timer) {
        self.hideToast(toast: timer.userInfo as! UIView)
    }

    func handleToastTapped(recognizer: UITapGestureRecognizer) {
        let timer = objc_getAssociatedObject(self, &HRToastTimer) as! Timer
        timer.invalidate()

        self.hideToast(toast: recognizer.view!)
    }

    func centerPointForPosition(position: AnyObject, toast: UIView) -> CGPoint {
        if position is String {
            let toastSize = toast.bounds.size
            let viewSize  = self.bounds.size
            if position.lowercased == HRToastPositionTop {
                return CGPoint(viewSize.width/2, toastSize.height/2 + HRToastVerticalMargin)
            } else if position.lowercased == HRToastPositionDefault {
                return CGPoint(viewSize.width/2, viewSize.height - toastSize.height/2 - HRToastVerticalMargin)
            } else if position.lowercased == HRToastPositionCenter {
                return CGPoint(viewSize.width/2, viewSize.height/2)
            }
        } else if position is NSValue {
            return position.cgPointValue
        }

        print("Warning: Invalid position for toast.")
        return self.centerPointForPosition(position: HRToastPositionDefault as AnyObject, toast: toast)
    }

    func viewForMessage(msg: String?, title: String?, image: UIImage?) -> UIView? {
        if msg == nil && title == nil && image == nil { return nil }

        var msgLabel: UILabel?
        var titleLabel: UILabel?
        var imageView: UIImageView?

        let wrapperView = UIView()
        wrapperView.autoresizingMask = ([.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin])
        wrapperView.layer.cornerRadius = HRToastCornerRadius
        wrapperView.backgroundColor = UIColor.black.withAlphaComponent(HRToastOpacity)

        if HRToastDisplayShadow {
            wrapperView.layer.shadowColor = UIColor.black.cgColor
            wrapperView.layer.shadowOpacity = Float(HRToastShadowOpacity)
            wrapperView.layer.shadowRadius = HRToastShadowRadius
            wrapperView.layer.shadowOffset = HRToastShadowOffset
        }

        if image != nil {
            imageView = UIImageView(image: image)
            imageView!.contentMode = .scaleAspectFit
            imageView!.frame = CGRect(HRToastHorizontalMargin, HRToastVerticalMargin, CGFloat(HRToastImageViewWidth), CGFloat(HRToastImageViewHeight))
        }

        var imageWidth: CGFloat, imageHeight: CGFloat, imageLeft: CGFloat
        if imageView != nil {
            imageWidth = imageView!.bounds.size.width
            imageHeight = imageView!.bounds.size.height
            imageLeft = HRToastHorizontalMargin
        } else {
            imageWidth  = 0.0; imageHeight = 0.0; imageLeft   = 0.0
        }

        if title != nil {
            titleLabel = UILabel()
            titleLabel!.numberOfLines = HRToastMaxTitleLines
            titleLabel!.font = UIFont.boldSystemFont(ofSize: HRToastFontSize)
            titleLabel!.textAlignment = .center
            titleLabel!.lineBreakMode = .byWordWrapping
            titleLabel!.textColor = UIColor.white
            titleLabel!.backgroundColor = UIColor.clear
            titleLabel!.alpha = 1.0
            titleLabel!.text = title

            // size the title label according to the length of the text
            let maxSizeTitle = CGSize((self.bounds.size.width * HRToastMaxWidth) - imageWidth, self.bounds.size.height * HRToastMaxHeight);
            let expectedHeight = title!.stringHeightWithFontSize(fontSize: HRToastFontSize, width: maxSizeTitle.width)
            titleLabel!.frame = CGRect(0.0, 0.0, maxSizeTitle.width, expectedHeight)
        }

        if msg != nil {
            msgLabel = UILabel();
            msgLabel!.numberOfLines = HRToastMaxMessageLines
            msgLabel!.font = UIFont.systemFont(ofSize: HRToastFontSize)
            msgLabel!.lineBreakMode = .byWordWrapping
            msgLabel!.textAlignment = .center
            msgLabel!.textColor = UIColor.white
            msgLabel!.backgroundColor = UIColor.clear
            msgLabel!.alpha = 1.0
            msgLabel!.text = msg

            let maxSizeMessage = CGSize((self.bounds.size.width * HRToastMaxWidth) - imageWidth, self.bounds.size.height * HRToastMaxHeight)
            let expectedHeight = msg!.stringHeightWithFontSize(fontSize: HRToastFontSize, width: maxSizeMessage.width)
            msgLabel!.frame = CGRect(0.0, 0.0, maxSizeMessage.width, expectedHeight)
        }

        var titleWidth: CGFloat, titleHeight: CGFloat, titleTop: CGFloat, titleLeft: CGFloat
        if titleLabel != nil {
            titleWidth = titleLabel!.bounds.size.width
            titleHeight = titleLabel!.bounds.size.height
            titleTop = HRToastVerticalMargin
            titleLeft = imageLeft + imageWidth + HRToastHorizontalMargin
        } else {
            titleWidth = 0.0; titleHeight = 0.0; titleTop = 0.0; titleLeft = 0.0
        }

        var msgWidth: CGFloat, msgHeight: CGFloat, msgTop: CGFloat, msgLeft: CGFloat
        if msgLabel != nil {
            msgWidth = msgLabel!.bounds.size.width
            msgHeight = msgLabel!.bounds.size.height
            msgTop = titleTop + titleHeight + HRToastVerticalMargin
            msgLeft = imageLeft + imageWidth + HRToastHorizontalMargin
        } else {
            msgWidth = 0.0; msgHeight = 0.0; msgTop = 0.0; msgLeft = 0.0
        }

        let largerWidth = max(titleWidth, msgWidth)
        let largerLeft  = max(titleLeft, msgLeft)

        // set wrapper view's frame
        let wrapperWidth  = max(imageWidth + HRToastHorizontalMargin * 2, largerLeft + largerWidth + HRToastHorizontalMargin)
        let wrapperHeight = max(msgTop + msgHeight + HRToastVerticalMargin, imageHeight + HRToastVerticalMargin * 2)
        wrapperView.frame = CGRect(0.0, 0.0, wrapperWidth, wrapperHeight)

        // add subviews
        if titleLabel != nil {
            titleLabel!.frame = CGRect(titleLeft, titleTop, titleWidth, titleHeight)
            wrapperView.addSubview(titleLabel!)
        }
        if msgLabel != nil {
            msgLabel!.frame = CGRect(msgLeft, msgTop, msgWidth, msgHeight)
            wrapperView.addSubview(msgLabel!)
        }
        if imageView != nil {
            wrapperView.addSubview(imageView!)
        }

        return wrapperView
    }

}

extension String {

    func stringHeightWithFontSize(fontSize: CGFloat,width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let size = CGSize(width, CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping;
        let attributes = [NSAttributedString.Key.font:font,
                          NSAttributedString.Key.paragraphStyle:paragraphStyle.copy()]

        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }

}

extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }

}
extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width:width,height:height)
    }
}
extension CGPoint{
    init(_ x:CGFloat,_ y:CGFloat) {
        self.init(x:x,y:y)
    }
}

extension UIViewController{
    func showLoading(){
        self.view.makeToastActivityWithMessage(message: "Loading…")
        self.view.isUserInteractionEnabled = false
    }

    func clearLoading(){
        self.view.hideToastActivity()
        self.view.isUserInteractionEnabled = true
    }
}
