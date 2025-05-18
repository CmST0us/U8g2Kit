import SDL2
import CU8g2
import U8g2Kit

class SDL2Driver: Driver {
    init() {
        super.init(u8g2_SetupBuffer_SDL_256x128, &u8g2_cb_r0)
    }
}

class App {
    struct WindowConfig {
        static let Width = 256
        static let Height = 128
    }
    
    private var screen: UnsafeMutablePointer<SDL_Surface>!
    private var window: OpaquePointer!
    private var blackColor: UInt32!
    private var whiteColor: UInt32!
    private var driver: SDL2Driver!

    func setup() {
        driver = SDL2Driver()
        driver.withUnsafeU8g2 { u8g2 in
            u8g2_InitDisplay(u8g2)
        }
    }


    func run() {
        setup()
        
        driver.withUnsafeU8x8 { u8x8 in
            u8x8_ClearDisplay(u8x8)
            u8x8_SetFont(u8x8, u8x8_font_7x14_1x2_f )
            u8x8_Draw1x2String(u8x8, 0, 0, "Hello World!");
            u8x8_Draw2x2String(u8x8, 0, 4, "Hello World!");
        }

        while( u8g_sdl_get_key() < 0 )
        {
            // do nothing
        }

        driver.withUnsafeU8x8 { u8x8 in
            u8x8_ClearDisplay(u8x8)
            u8x8_SetFont(u8x8, u8x8_font_7x14_1x2_f )
            u8x8_Draw1x2String(u8x8, 0, 0, "Hello World!");
            u8x8_Draw2x2String(u8x8, 0, 4, "Hello World!");
        }

        while( u8g_sdl_get_key() < 0 )
        {
            // do nothing
        }

    }
}

@main
struct U8g2SDLSimulator {
    static func main() {
        let app = App()
        app.run()
    }
}
