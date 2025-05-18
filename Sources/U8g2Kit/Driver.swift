import CU8g2

@_silgen_name("u8g2_cb_r0")
public var u8g2_cb_r0: u8g2_cb_t

@_silgen_name("u8g2_cb_r1")
public var u8g2_cb_r1: u8g2_cb_t

@_silgen_name("u8g2_cb_r2")
public var u8g2_cb_r2: u8g2_cb_t

@_silgen_name("u8g2_cb_r3")
public var u8g2_cb_r3: u8g2_cb_t


func u8g2_driver_byte_cb(_ u8x8: UnsafeMutablePointer<u8x8_t>?, _ msg: UInt8, _ arg_int: UInt8, _ arg_ptr: UnsafeMutableRawPointer?) -> UInt8 {
    guard let u8x8 = u8x8 else { return 0 }
    let userPtr = u8x8.pointee.user_ptr
    let that = Unmanaged<Driver>.fromOpaque(userPtr!).takeUnretainedValue()
    return that.onByte(msg: msg, arg_int: arg_int, arg_ptr: arg_ptr)
}

func u8g2_driver_gpio_and_delay_cb(_ u8x8: UnsafeMutablePointer<u8x8_t>?, _ msg: UInt8, _ arg_int: UInt8, _ arg_ptr: UnsafeMutableRawPointer?) -> UInt8 {
    guard let u8x8 = u8x8 else { return 0 }
    let userPtr = u8x8.pointee.user_ptr
    let that = Unmanaged<Driver>.fromOpaque(userPtr!).takeUnretainedValue()
    return that.onGpioAndDelay(msg: msg, arg_int: arg_int, arg_ptr: arg_ptr)
}

open class Driver {
    public private(set) var u8g2: u8g2_t

    public typealias SetupDisplayHandler = (UnsafeMutablePointer<u8g2_t>, UnsafePointer<u8g2_cb_t>, u8x8_msg_cb, u8x8_msg_cb) -> Void
    public typealias SetupDisplayAllDefinedU8x8Handler = ((UnsafeMutablePointer<u8x8_t>) -> Void)
    public typealias SetupDisplayCanSetRotationHandler = ((UnsafeMutablePointer<u8g2_t>, UnsafePointer<u8g2_cb_t>) -> Void)

    public typealias TileBufferHandler = ((UnsafeMutablePointer<UInt8>?) ->  UnsafeMutablePointer<UInt8>?)

    public init(_ setup: SetupDisplayHandler, _ rotation: UnsafePointer<u8g2_cb_t>) {
        u8g2 = u8g2_t()
        let unmanagedSelf = Unmanaged.passUnretained(self).toOpaque()
        u8g2.u8x8.user_ptr = UnsafeMutableRawPointer(unmanagedSelf)

        setup(&u8g2, rotation, u8g2_driver_byte_cb, u8g2_driver_gpio_and_delay_cb)
    }

    public init(_ setup: SetupDisplayAllDefinedU8x8Handler) {
        u8g2 = u8g2_t()
        let unmanagedSelf = Unmanaged.passUnretained(self).toOpaque()
        u8g2.u8x8.user_ptr = UnsafeMutableRawPointer(unmanagedSelf)

        setup(&u8g2.u8x8)
    }

    public init(_ setup: SetupDisplayCanSetRotationHandler, _ rotation: UnsafePointer<u8g2_cb_t>) {
        u8g2 = u8g2_t()
        let unmanagedSelf = Unmanaged.passUnretained(self).toOpaque()
        u8g2.u8x8.user_ptr = UnsafeMutableRawPointer(unmanagedSelf)

        setup(&u8g2, rotation)
    }

    public func withUnsafeU8g2(_ body: (UnsafeMutablePointer<u8g2_t>) -> Void) {
        body(&u8g2)
    }

    public func withUnsafeU8x8(_ body: (UnsafeMutablePointer<u8x8_t>) -> Void) {
        body(&u8g2.u8x8)
    }

    open func onByte(msg: UInt8, arg_int: UInt8, arg_ptr: UnsafeMutableRawPointer?) -> UInt8 {
        return 0
    }

    open func onGpioAndDelay(msg: UInt8, arg_int: UInt8, arg_ptr: UnsafeMutableRawPointer?) -> UInt8 {
        return 0
    }
}

