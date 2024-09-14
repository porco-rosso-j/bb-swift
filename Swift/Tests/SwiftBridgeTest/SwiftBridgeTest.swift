import XCTest
import BBSwift

extension RustVec where T == UInt8 {
  func toArray() -> [UInt8] {
    var array = [UInt8]()
    for index in 0..<self.len() { // Use self.len() instead of self.len
      if let element = self.get(index: UInt(index)) {
        array.append(element)
      }
    }
    return array
  }
}

final class SwiftBridgeTests: XCTestCase {

    func testPedersenHash() {
        let input: [UInt8] = [
      6, 196, 4, 126, 220, 48, 240, 65, 72, 173, 40, 101, 187, 150, 245, 115,
      253, 193, 91, 5, 45, 148, 91, 74, 184, 111, 200, 144, 36, 203, 76, 229
    ];


      let result = input.withUnsafeBufferPointer { bufferPointer in
            pedersen_hash_swift(bufferPointer)
        }

        // let resultArray = Array(result)
        // print("Result array: \(resultArray)")
        print("Result array: \(result.toArray())")

        print("Result array: \(result.len())")
        
        XCTAssertNotNil(result)

        // Add more assertions based on your expected result
    }

    // Define additional tests for other functions
}
