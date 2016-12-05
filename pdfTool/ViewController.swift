//
//  ViewController.swift
//  pdfTool
//
//  Created by Weicheng Zhu on 12/4/16.
//  Copyright © 2016 Weicheng Zhu. All rights reserved.
//

import Cocoa

import Quartz

class ViewController: NSViewController {
    @IBOutlet weak var currentPageLabel: NSTextField!

    @IBOutlet weak var inputValue: NSTextField!
    @IBOutlet weak var pdfViewer: PDFView!
    var pdfview = PDFDocument()
    var globalUrl = PDFDocument();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path =  Bundle.main.path(forResource: "myPDF", ofType: "pdf")!
        let url = NSURL(fileURLWithPath: path)
        let pdf = PDFDocument(url: url as URL)
        self.globalUrl = pdf!
        print(pdf?.pageCount)
        let pageTow = pdf?.page(at: 5)

        self.pdfViewer.document = pdf
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func confirmButton(_ sender: Any) {
        var inputVaule = self.inputValue.intValue
        self.pdfViewer.go(to:  self.globalUrl.page(at: Int(inputVaule))! )
    }
    
}
