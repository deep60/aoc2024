//
//  day03.swift
//  adventOfCode2024
//
//  Created by P Deepanshu on 19/01/25.
//

import Foundation

func day03() {
    let filename = "data03.txt"
    let currentPath = FileManager.default.currentDirectoryPath
    let filePath = "\(currentPath)/\(filename)"
    
    do {
        let content = try String(contentsOfFile: filePath, encoding: .utf8)
        let lines = content.components(separatedBy: .newlines).filter { !$0.isEmpty }
        let input = lines.first!
        var total = 0
        var isEnabled = true
        let regex = #"mul\([\d]{1,3}, [\d]{1,3}\)|do\(\)|don't\(\)"#
        let instr = matches(for: regex, in: input)
        
        for instrc in instr {
            if instrc == "do()" {
                isEnabled = true
            } else if instrc == "don't()" {
                isEnabled = false
            } else if instrc.starts(with: "mul("), isEnabled {
                total += getNum(from: instrc)
            }
        }
        
        print(total)
    } catch {
        print("error: \(error.localizedDescription)")
    }
}
    
    func getNum(from: String) -> Int {
        let parts = from.split(separator: ",")
        
        var lastvalue = String(parts[1])
        lastvalue.removeLast()
        
        return Int(String(parts[0]))! * Int(lastvalue)!
    }
    
    extension String {
        func deletingPrefix(_ prefix: String) -> String {
            guard self.hasPrefix(prefix) else { return self }
            return String(self.dropFirst(prefix.count))
        }
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range(at: 0), in: text)!])
            }
        } catch {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

