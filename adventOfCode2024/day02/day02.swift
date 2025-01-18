import Foundation

struct UnsafeRepo {
    var report: [Int]
    var i: Int
}

func day02() {
    let fileName = "day02.txt"
    let curPath = FileManager.default.currentDirectoryPath
    let filePath = "\(curPath)/\(fileName)"
    
    do {
        let content = try String(contentsOfFile: filePath, encoding: .utf8)
        let lines = content.components(separatedBy: .newlines).filter { !$0.isEmpty }
        
        let data = lines.map { $0.split(separator: "") }
        
        var safeCount = 0
        var unsafeReports: [UnsafeRepo] = []
        
        for report in data {
            let formatted = report.map { Int($0)! }
            var prev = -1
            var forward = true
            
            for (index, num) in formatted.enumerated() {
                if prev != -1 {
                    let diff = abs(num - prev)
                    
                    if diff < 1 || diff > 3 {
                        unsafeReports.append(UnsafeRepo(report: formatted, i: index))
                        break
                    }
                    
                    if diff == 0 {
                        unsafeReports.append(UnsafeRepo(report: formatted, i: index))
                        break
                    }
                    
                    if index == formatted.count - 1 {
                        prev = -1
                        safeCount += 1
                    } else {
                        if forward {
                            if num > formatted[index + 1] {
                                unsafeReports.append(UnsafeRepo(report: formatted, i: index))
                                break
                            }
                        } else {
                            if num < formatted[index + 1] {
                                unsafeReports.append(UnsafeRepo(report: formatted, i: index))
                                break
                            }
                        }
                    }
                } else {
                    if num < formatted[index + 1] {
                        forward = true
                    } else {
                        forward = false
                    }
                }
                
                prev = num
            }
        }
        
        print("first safe count: \(safeCount)")
        
        for report in unsafeReports {
            var safe = 0
            
            for (index, _) in report.report.enumerated() {
                var formatted = report.report
                formatted.remove(at: index)
                
                var prev = -1
                var forward = true
                
                for (index, num) in formatted.enumerated() {
                    if prev != -1 {
                        let diff = abs(num - prev)
                        
                        if diff < 1 || diff > 3 {
                            break
                        }
                        
                        if diff == 0 {
                            break
                        }
                        
                        if index == formatted.count - 1 {
                            prev = -1
                            safe += 1
                        } else {
                            if forward {
                                if num > formatted[index + 1] {
                                    break
                                }
                            } else {
                                if num < formatted[index + 1] {
                                    break
                                }
                            }
                        }
                    } else {
                        if num < formatted[index + 1] {
                            forward = true
                        } else {
                            forward = false
                        }
                    }
                    
                    prev = num
                }
            }
            
            if safe > 0 {
                safeCount += 1
            }
        }
    } catch {
        print("error: \(error.localizedDescription)")
    }
}
