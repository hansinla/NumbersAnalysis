//
//  main.swift
//  NumbersAnalysis
//
//  Created by Hans van Riet on 11/10/14.
//  Copyright (c) 2014 Hans van Riet. All rights reserved.
//

// Total number of draws since October 19, 2013: 110

import Foundation

let file = "NumberFrequency.txt"

// New Style numbers between 1 and 75 inclusive, mega number between 1 and 15 inclusive
var lotteryNumbers = Array(count: 75, repeatedValue: 0)
var megaNumbers = Array(count: 15, repeatedValue: 0)
var drawingCounter = 0


// Old Style numbers between 1 and 56 inclusive, mega number between 1 and 46 inclusive
var oldLotteryNumbers = Array(count: 56, repeatedValue: 0)
var oldMegaNumbers = Array(count: 46, repeatedValue: 0)
var oldDrawingCounter = 0

print("Analyzing number frequency in lottery drawings since June 24, 2005.")


if let dirs = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DesktopDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [NSString] {
    let path = dirs[0].stringByAppendingPathComponent(file);
    
    //reading
    var error: NSError?
    
    do {
        let allNumbers = try NSString(contentsOfFile:path, encoding:NSUTF8StringEncoding)

        var list = allNumbers.componentsSeparatedByString("\n") as [NSString]
        for line in list{
            var lineItems = line.componentsSeparatedByString(",") as [String]
            if (lineItems[0].toInt()! >= 868) {
                // These are the new style drawings since October 19, 2013
                for index in 3...7 {
                    // Tally up the winning lottery numbers
                    var lotteryNumberIndex = (lineItems[index].toInt())! - 1
                    lotteryNumbers[lotteryNumberIndex] += 1
                }
                // Tally up the winning Mega numbers
                let lastNum = lineItems[8] as NSString
                let megaNumberIndex = lastNum.intValue
                megaNumbers[megaNumberIndex - 1] += 1
                
                drawingCounter += 1
            } else {
                // These are old style drawings prior to October 19, 2013
                for index in 3...7 {
                    // Tally up the winning lottery numbers
                    var lotteryNumberIndex = (lineItems[index].toInt())! - 1
                    oldLotteryNumbers[lotteryNumberIndex] += 1
                }
                // Tally up the winning Mega numbers
                let lastNum = lineItems[8] as NSString
                let megaNumberIndex = lastNum.intValue
                oldMegaNumbers[megaNumberIndex - 1] += 1
                
                oldDrawingCounter += 1
            }
        }
    } catch var error1 as NSError {
        error = error1
    }
    
    if let theError = error {
        print("\(theError.localizedDescription)", terminator: "")
    }
    
    print("")
    print("Frequency in new style drawings:")
    
    var counter = 1
    
    for frequency in lotteryNumbers {
        print("Winning number: \(counter) frequency: \(frequency)")
        counter += 1
    }
    
    counter = 1
    for frequency in megaNumbers {
        print("Mega number: \(counter) frequency: \(frequency)")
        counter += 1
    }
    
    print("")
    print("Frequency in old style drawings:")
    
    counter = 1
    
    for frequency in oldLotteryNumbers {
        print("Winning number: \(counter) frequency: \(frequency)")
        counter += 1
    }
    
    counter = 1
    for frequency in oldMegaNumbers {
        print("Mega number: \(counter) frequency: \(frequency)")
        counter += 1
    }

    
}