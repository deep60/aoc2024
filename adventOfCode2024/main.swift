
import Foundation

let filename = "data.txt"
let currentPath = FileManager.default.currentDirectoryPath
let filePath = "\(currentPath)/\(filename)"

do {
    let content = try String(contentsOfFile: filePath, encoding: .utf8)
    let lines = content.components(separatedBy: .newlines)
    let dataPoints = lines.filter { !$0.isEmpty }
    
    var left: [Int] = []
    var right: [Int] = []
    
    for line in dataPoints {
        let parts = line.split(separator: " ", omittingEmptySubsequences: true)
        if parts.count >= 2,
           let leftValue = Int(parts.first ?? ""),
           let rightValue = Int(parts.last ?? "") {
            left.append(leftValue)
            right.append(rightValue)
        } else {
            print("Skipping invalid line: \(line)")
        }
    }
    
    guard left.count == right.count else {
        print("Error: Mismatched left and right counts")
        exit(1)
    }
    
    left.sort()
    right.sort()
    
    var distances: [Int] = []
    
    for (index, num) in left.enumerated() {
        distances.append(abs(num - right[index]))
    }
    
    print(distances.reduce(0, +))
} catch {
    print("Error: \(error.localizedDescription)")
}

