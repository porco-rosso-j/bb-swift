// File automatically generated by swift-bridge.
import BBSwiftLib
// File automatically generated by swift-bridge.
import BBSwiftLib
public func pedersen_commit_swift(_ inputs: UnsafeBufferPointer<UInt8>) -> RustVec<UInt8> {
    RustVec(ptr: __swift_bridge__$pedersen_commit_swift(inputs.toFfiSlice()))
}
public func pedersen_hash_swift(_ inputs: UnsafeBufferPointer<UInt8>, _ index: UInt32) -> RustVec<UInt8> {
    RustVec(ptr: __swift_bridge__$pedersen_hash_swift(inputs.toFfiSlice(), index))
}
public func poseidon2_hash_swift(_ inputs: UnsafeBufferPointer<UInt8>) -> RustVec<UInt8> {
    RustVec(ptr: __swift_bridge__$poseidon2_hash_swift(inputs.toFfiSlice()))
}
public func ecdsa__compute_public_key_swift(_ private_key: UnsafeBufferPointer<UInt8>) -> RustVec<UInt8> {
    RustVec(ptr: __swift_bridge__$ecdsa__compute_public_key_swift(private_key.toFfiSlice()))
}
public func ecdsa__construct_signature_swift(_ message: UnsafeBufferPointer<UInt8>, _ msg_len: UInt, _ private_key: UnsafeBufferPointer<UInt8>) -> RustVec<UInt8> {
    RustVec(ptr: __swift_bridge__$ecdsa__construct_signature_swift(message.toFfiSlice(), msg_len, private_key.toFfiSlice()))
}
public func ecdsa__recover_public_key_from_signature_swift(_ message: UnsafeBufferPointer<UInt8>, _ msg_len: UInt, _ sig_r: UnsafeBufferPointer<UInt8>, _ sig_s: UnsafeBufferPointer<UInt8>, _ sig_v: UInt8) -> RustVec<UInt8> {
    RustVec(ptr: __swift_bridge__$ecdsa__recover_public_key_from_signature_swift(message.toFfiSlice(), msg_len, sig_r.toFfiSlice(), sig_s.toFfiSlice(), sig_v))
}
public func ecdsa__verify_signature_swift(_ message: UnsafeBufferPointer<UInt8>, _ msg_len: UInt, _ public_key: UnsafeBufferPointer<UInt8>, _ sig_r: UnsafeBufferPointer<UInt8>, _ sig_s: UnsafeBufferPointer<UInt8>, _ sig_v: UInt8) {
    __swift_bridge__$ecdsa__verify_signature_swift(message.toFfiSlice(), msg_len, public_key.toFfiSlice(), sig_r.toFfiSlice(), sig_s.toFfiSlice(), sig_v)
}
public func ecc_grumpkin__mul_swift(_ point_buf: UnsafeBufferPointer<UInt8>, _ scalar_buf: UnsafeBufferPointer<UInt8>) -> RustVec<UInt8> {
    RustVec(ptr: __swift_bridge__$ecc_grumpkin__mul_swift(point_buf.toFfiSlice(), scalar_buf.toFfiSlice()))
}
public func ecc_grumpkin__add_swift(_ point_a_buf: UnsafeBufferPointer<UInt8>, _ point_b_buf: UnsafeBufferPointer<UInt8>) -> RustVec<UInt8> {
    RustVec(ptr: __swift_bridge__$ecc_grumpkin__add_swift(point_a_buf.toFfiSlice(), point_b_buf.toFfiSlice()))
}

public class Point: PointRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$Point$_free(ptr)
        }
    }
}
public class PointRefMut: PointRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class PointRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension Point: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_Point$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_Point$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: Point) {
        __swift_bridge__$Vec_Point$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_Point$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (Point(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<PointRef> {
        let pointer = __swift_bridge__$Vec_Point$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return PointRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<PointRefMut> {
        let pointer = __swift_bridge__$Vec_Point$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return PointRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<PointRef> {
        UnsafePointer<PointRef>(OpaquePointer(__swift_bridge__$Vec_Point$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_Point$len(vecPtr)
    }
}


public class Fr: FrRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$Fr$_free(ptr)
        }
    }
}
public class FrRefMut: FrRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class FrRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension Fr: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_Fr$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_Fr$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: Fr) {
        __swift_bridge__$Vec_Fr$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_Fr$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (Fr(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FrRef> {
        let pointer = __swift_bridge__$Vec_Fr$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FrRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FrRefMut> {
        let pointer = __swift_bridge__$Vec_Fr$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FrRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<FrRef> {
        UnsafePointer<FrRef>(OpaquePointer(__swift_bridge__$Vec_Fr$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_Fr$len(vecPtr)
    }
}



