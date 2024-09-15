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

      func testPedersenHash2() {
        let input: [[UInt8]] = [
          [
          6, 196, 4, 126, 220, 48, 240, 65, 72, 173, 40, 101, 187, 150, 245, 115,
          253, 193, 91, 5, 45, 148, 91, 74, 184, 111, 200, 144, 36, 203, 76, 229
          ],
          [
            6, 196, 4, 126, 220, 48, 240, 65, 72, 173, 40, 101, 187, 150, 245, 115,
            253, 193, 91, 5, 45, 148, 91, 74, 184, 111, 200, 144, 36, 203, 76, 229
          ]
        ];

        let index = UInt32(0);
               // Convert the input to an array of UnsafeBufferPointers and pass to the Rust method
        let pointerArray = input.map { $0.withUnsafeBufferPointer { $0.baseAddress! } }

        // Call the Rust function via SwiftBridge
        let result = pointerArray.withUnsafeBufferPointer { bufferPointer in
            pedersen_hash_swift(bufferPointer, index)
        }

        // Ensure result is not nil
        XCTAssertNotNil(result)

        // Convert result to array for assertion and debugging
        let resultArray = result.toArray()

        // Assert that the result array has content and meets expected size
        XCTAssertTrue(resultArray.count > 0, "Result array should not be empty")

        // Example expected length check (modify based on your expected result)
        XCTAssertEqual(resultArray.count, 32, "Result array should be 32 bytes")

        // Print result array for debugging
        print("Result array: \(resultArray)")
    }

    // Define additional tests for other functions
}
