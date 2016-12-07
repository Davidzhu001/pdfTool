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
    var globalPDF = PDFDocument();
    var newPdf = PDFDocument();
    override func viewDidLoad() {
        super.viewDidLoad()

        let path =  Bundle.main.path(forResource: "myPDF", ofType: "pdf")!
        let url = NSURL(fileURLWithPath: path)
        let pdf = PDFDocument(url: url as URL)
        self.globalPDF = pdf!
        self.pdfViewer.autoScales = true;
        print(pdf?.pageCount)
        
        let pageTow = pdf?.page(at: 2)

        self.pdfViewer.document = pdf
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func confirmButton(_ sender: Any) {
        let inputInt = Int(self.inputValue.intValue)
        if inputInt < (self.pdfViewer.document?.pageCount)! {
            self.pdfViewer.go(to:  self.globalPDF.page(at: inputInt)! )
            newPdf.insert((self.pdfViewer.document?.page(at: inputInt))!, at: 0)
            print(newPdf.pageCount)
            
            do {
                try newPdf.write(to: getDocumentsDirectory())
            } catch {
                print(error)
            }
        } else
        {
            currentPageLabel.stringValue = "Out of page number"
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.appendingPathComponent("test.pdf")
    }
    
}
