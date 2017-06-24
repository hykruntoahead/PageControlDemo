//
//  ViewController.swift
//  PageControlDemo
//
//  Created by 何育昆 on 2017/6/24.
//  Copyright © 2017年 Hyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pageCtl: UIPageControl!
    
    fileprivate var scrollView: UIScrollView!
    
    fileprivate let numOfPages = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = self.view.bounds
        
        scrollView = UIScrollView(frame: frame)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPoint.zero
        // 将 scrollView 的 contentSize 设为屏幕宽度的3倍(根据实际情况改变)
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(numOfPages), height: frame.size.height)
        
        
        for index in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: "guide_image\(index + 1)"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: frame.size.height)
            
            scrollView.addSubview(imageView)
        }
        scrollView.delegate = self
        self.view.insertSubview(scrollView, at: 0)
        startButton.alpha = 0.0
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // 随着滑动改变pageControl的状态
        pageCtl.currentPage = Int(offset.x / view.bounds.width)
        
        // 因为currentPage是从0开始，所以numOfPages减1
        if pageCtl.currentPage == numOfPages - 1 {
            UIView.animate(withDuration: 0.8, animations: {
                self.startButton.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.startButton.alpha = 0.0
            })
        }
    }
    
    
    
    @IBAction func pageChange(_ sender: UIPageControl) {
        let current = sender.currentPage;
        let xTranslate = CGFloat(current) * view.bounds.width;
        scrollView.setContentOffset(CGPoint(x: xTranslate, y: 0), animated: false)
    }
    
    // 隐藏状态栏
    override var prefersStatusBarHidden : Bool {
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

