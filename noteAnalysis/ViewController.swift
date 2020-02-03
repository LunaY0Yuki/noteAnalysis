//
//  ViewController.swift
//  noteAnalysis
//
//  Created by Yuki Wang on 2/2/20.
//  Copyright © 2020 Yuki Wang. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var importButton: NSButton!
    @IBOutlet weak var fileName: NSTextField!
    @IBOutlet weak var filePath: NSTextField!
    @IBOutlet weak var exportButton: NSButton!
    
    let fileMng = FileManager.init()
    var fileDirec : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func importButtonPressed(_ sender: Any) {
        let filePicker = NSOpenPanel()
        
        // Configure the Open Panel Object
        filePicker.title = "Choose a .txt file";
        filePicker.showsResizeIndicator = true;
        filePicker.showsHiddenFiles = false;
        filePicker.canChooseFiles = true;
        filePicker.canCreateDirectories = true;
        filePicker.allowsMultipleSelection = false;
        filePicker.allowedFileTypes = ["txt"];
        
        /*
         .runModal()
            runs a modal even loop
            does not respond to anything else except the modal
         */
        if (filePicker.runModal() == NSApplication.ModalResponse.OK) {
            // Pathname of the picked file
            let result = filePicker.url
            fileDirec =  filePicker.url!.deletingLastPathComponent()

            if (result != nil) {
                let path = result!.path
                filePath.stringValue = path
                
                // Show the name of selected file
                let name: String?
                name = fileMng.displayName(atPath: path)
                if (name != nil) {
                    fileName.stringValue = name!
                }
            }
        } else {
            // User clicked on cancel
            return
        }
    }
    
    @IBAction func exportButtonPressed(_ sender: Any) {
        let writeContent = "Hello World"
        let writePath = fileDirec!.appendingPathComponent("Tests1.txt")
        
        /*
         write
            to: takes URL
            atomically: takes a bool
                if true, the content is written to an auxiliary file
            encoding:
                encoding used for output
         */
        do {
            try writeContent.write(to: writePath, atomically: false, encoding: .utf8)
        } catch {
            // Catch the error if write has any
            print("Unexpected error: \(error).")
        }
    }
}

