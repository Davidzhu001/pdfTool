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

    @IBAction func openFile(_ sender: Any) {
       let file_url =  openFile()
        print(file_url)
    }
    
    @IBOutlet weak var inputValue: NSTextField!
    @IBOutlet weak var originPdfView: PDFView!
    @IBOutlet var previewPdfView: PDFView!

    
    struct PdfFiles {
        var originVersion = PDFDocument();
        var workingVersion = PDFDocument();
        var previewVersion =  PDFDocument();
    }
    
    
    var originPDF = PDFDocument();
    var newPDF = PDFDocument();
    @IBAction func confirmButton(_ sender: Any) {
        let inputInt = Int(self.inputValue.intValue)
        if inputInt < (self.originPdfView.document?.pageCount)! {
            self.originPdfView.go(to:  self.originPDF.page(at: inputInt)! )
            newPDF.insert((self.originPdfView.document?.page(at: inputInt))!, at: 0)
            print(newPDF.pageCount)
        } else
        {
            currentPageLabel.stringValue = "Out of page number"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path =  Bundle.main.path(forResource: "myPDF", ofType: "pdf")!
        let url = NSURL(fileURLWithPath: path)
        let pdf = PDFDocument(url: url as URL)
        self.originPDF = pdf!
        self.originPdfView.autoScales = true;
        
        self.originPdfView.document = self.originPDF
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func writeFile(filename :String, file :PDFDocument) {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let newFilePath =  documentsDirectory.appendingPathComponent(filename + ".pdf")
        file.write(to: newFilePath)

    }
    
    func openFile() -> String {
        
        let myFileDialog: NSOpenPanel = NSOpenPanel()
        myFileDialog.allowedFileTypes = ["pdf"]
        myFileDialog.runModal()
        
        // Get the path to the file chosen in the NSOpenPanel
        let path = myFileDialog.url?.path
        if path != nil {
            print(path!)
            let url = NSURL(fileURLWithPath: path!)
            self.originPDF = PDFDocument(url: url as URL)!
            self.newPDF = PDFDocument(url: url as URL)!
            self.previewPdfView.document = PDFDocument(url: url as URL)!
            self.originPdfView.document =  PDFDocument(url: url as URL)!
            return path!

        } else{
            return "nothing selected"

        }
        
    }
    
    
    
}
