//
//  PublishArticleController.swift
//  SwiftMVVM
//
//  Created by Dylan.Lee on 2017/12/15.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

class PublishArticleController: UIViewController {
    @IBOutlet weak var contentText: UITextView!
    @IBOutlet weak var microView: MicrophoneView!
    @IBOutlet weak var microView01: MicrophoneView!
    @IBOutlet weak var clippyView: UIImageView!
    
    
    var items = [UIView]()
    var count: Int = 3000
    var paths: [String: UIBezierPath] = [:]
    var panOffset: CGPoint!
    var heightDiff = 0
    var conHeight = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentText.textStorage.replaceCharacters(in: NSMakeRange(0, 0),
                                                  with:  try! String(contentsOf: Bundle.main.url(forResource: "lorem",
                                                                                                 withExtension: "txt")!,
                                                                     encoding: .utf8))
        contentText.delegate = self
        clippyView.isHidden = true
        contentText.layoutManager.hyphenationFactor = 1.0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    /// 更新路径
    func updateExclusionPaths(views: [UIView]) {
        setupPaths(views: views)
        var pathes: [UIBezierPath] = []
        for bezier in paths.values {
            pathes.append(bezier)
        }
        contentText.textContainer.exclusionPaths = pathes
        updateClippy()
    }
    

    /// 设置需要排除的路径
    func setupPaths(views: [UIView]) {
        
        for v in views {
            var ovalFrame = contentText.convert(v.bounds, from: v)
            ovalFrame.origin.x -= contentText.textContainerInset.left
            ovalFrame.origin.y -= contentText.textContainerInset.top
            let ovalPath = UIBezierPath(rect: ovalFrame)
            paths.updateValue(ovalPath, forKey: "microphon\(v.tag)")
        }
    }
    
    /// 更新选中签位置
    func updateClippy() {
        let selectedRange = contentText.selectedRange
        if selectedRange.length == 0 {
            clippyView.isHidden = true
            return
        }
        
        let glyphRange = contentText.layoutManager.glyphRange(forCharacterRange: selectedRange, actualCharacterRange: nil)
        var lastRect: CGRect?
        contentText.layoutManager.enumerateEnclosingRects(forGlyphRange: glyphRange, withinSelectedGlyphRange: glyphRange, in: contentText.textContainer) { (rect, stop) in
            lastRect = rect
        }
        
        var clippyCenter: CGPoint = CGPoint(x: lastRect!.maxX + contentText.textContainerInset.left, y: lastRect!.maxY + contentText.textContainerInset.right)
        clippyCenter = contentText.convert(clippyCenter, to: view)
        clippyCenter.x += clippyView.bounds.size.width/2
        clippyCenter.y += clippyView.bounds.size.height/2
        clippyView.isHidden = false
        clippyView.center = clippyCenter
    }
    
    /// 选择相册图片
    @IBAction func showImgPicker(_ sender: Any) {
        let imgPickerView = UIImagePickerController()
        imgPickerView.delegate = self
        present(imgPickerView, animated: true, completion: nil)
    }
    
    /// 打开相机
    @IBAction func openCamera(_ sender: Any) {
    }
    
    /// 开始录音
    @IBAction func startRecord(_ sender: Any) {
    }
    
    /// 拖动处理
    @objc func circlePan(gr: UIPanGestureRecognizer) {
        let panedView = gr.view
        if gr.state == .began {
            panOffset = gr.location(in: panedView)
        }
        
        let location = gr.location(in: contentText)
        
        print("location = x: \(location.x)  y: \(location.y)")
        print("offset   = x: \(panOffset.x)  y: \(panOffset.y)")
        print("locationY = \(location.y - panOffset.y + panedView!.height/2)")
        
        let centerX = min(max(location.x - panOffset.x + panedView!.width/2, panedView!.width/2), max(contentText.width, contentText.contentSize.width) - panedView!.width/2)
        let centerY = min(max(location.y - panOffset.y + panedView!.height/2, panedView!.height/2), max(contentText.height, contentText.contentSize.height) - panedView!.height/2)
        
        panedView?.snp.remakeConstraints({ (make) in
            make.centerX.equalTo(centerX)
            make.centerY.equalTo(centerY)
        })
        updateExclusionPaths(views: [panedView!])
    }
    
    /// 添加图片
    func addImgToContent(img: UIImage) {
        let imgView = Illustration()
        imgView.isUserInteractionEnabled = true
        imgView.image = img
        imgView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: img.size)
        addViewToContent(view: imgView)
    }
    
    /// 向UITextView添加View
    func addViewToContent(view: UIView) {
        let range = contentText.selectedTextRange
        let rect = contentText.caretRect(for: range!.start)
        view.origin = CGPoint(x: rect.maxX, y: rect.minY)
        contentText.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.width.equalTo(view.width)
            make.height.equalTo(view.height)
            make.left.equalTo(view.origin.x)
            make.top.equalTo(view.origin.y)
        }
        view.tag = count
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self,
                                                            action: #selector(circlePan(gr:))))
        count += 1
        items.append(view)
        updateExclusionPaths(views: items)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PublishArticleController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        updateClippy()
    }
}

extension PublishArticleController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var img: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        img = img.scaleTo(width: contentText.width/2)!
        addImgToContent(img: img)
        picker.dismiss(animated: true, completion: nil)
    }
}
