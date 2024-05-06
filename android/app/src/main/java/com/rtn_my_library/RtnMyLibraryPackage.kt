package com.rtn_my_library

import com.facebook.react.TurboReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.model.ReactModuleInfo
import com.facebook.react.module.model.ReactModuleInfoProvider

class RtnMyLibraryPackage : TurboReactPackage() {
    // override fun getModule(name: String?, reactContext: ReactApplicationContext): NativeModule? = null
    override fun getModule(name: String, reactContext: ReactApplicationContext): NativeModule? =
        if (name == RtnMyLibraryModule.NAME) {
            RtnMyLibraryModule(reactContext)
        } else {
            null
        }

    // override fun getReactModuleInfoProvider(): ReactModuleInfoProvider? = null
    override fun getReactModuleInfoProvider() = ReactModuleInfoProvider {
        mapOf(
            RtnMyLibraryModule.NAME to ReactModuleInfo(
                RtnMyLibraryModule.NAME,
                RtnMyLibraryModule.NAME,
                true, // canOverrideExistingModule
                false, // needsEagerInit
                false, // isCxxModule
                true, // isTurboModule
            )
        )
    }
}