import Foundation

let testFileName = "FixedSizeArrayTests.swift"
let errorFileName = "FixedArrayError.swift"
func fileName(size: Int) -> String {
    "Array\(size).swift"
}

enum Error: Swift.Error {
    case noSizeProvided
    case sizeInvalid
    
    case noFilesPathProvided
    case noTestFilePathProvided
    
    case dataConversionFailed
}

guard CommandLine.arguments.count > 1 else {
    throw Error.noSizeProvided
}
         
guard let maxSize = Int(CommandLine.arguments[1]) else {
    throw Error.sizeInvalid
}

guard CommandLine.arguments.count > 2 else {
    throw Error.noFilesPathProvided
}

let filesPath = CommandLine.arguments[2]

guard CommandLine.arguments.count > 3 else {
    throw Error.noTestFilePathProvided
}

let testFilePath = CommandLine.arguments[3]

var testFileGenerator = TestFileGenerator()

for size in 1...maxSize {
    let generator = FixedArrayGenerator(size: size)
    testFileGenerator.fixedArrayGenerators.append(generator)
    
    let fixedSizedArray = generator.make()
    try fixedSizedArray.makeFile(path: filesPath, fileName: fileName(size: size))
}

let testFile = testFileGenerator.make()
try testFile.makeFile(path: testFilePath, fileName: testFileName)

let errorFile = makeErrorFile()
try errorFile.makeFile(path: filesPath, fileName: errorFileName)

let currentDirectoryUrl = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
extension String {
    func makeFile(path: String, fileName: String) throws {
        let fullpath = (path as NSString).appendingPathComponent(fileName)
        let url = URL(fileURLWithPath: fullpath, relativeTo: currentDirectoryUrl)
        
        if !FileManager.default.fileExists(atPath: path) {
            try FileManager.default.createDirectory(
                at: URL(fileURLWithPath: path, relativeTo: currentDirectoryUrl),
                withIntermediateDirectories: true
            )
        }
        
        guard let data = data(using: .utf8) else {
            throw Error.dataConversionFailed
        }
        
        try data.write(to: url)
    }
}
