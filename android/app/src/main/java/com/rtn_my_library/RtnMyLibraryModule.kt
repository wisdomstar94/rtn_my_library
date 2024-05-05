package com.rtn_my_library

import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import android.os.Build;
import android.util.Log

class RtnMyLibraryModule(reactContext: ReactApplicationContext?) : NativeRtnMyLibrarySpec(reactContext) {
    override fun getName() = NAME

    override fun getDeviceModel(promise: Promise?) {
        val manufacturer: String = Build.MANUFACTURER
        val model: String = Build.MODEL
        val result = "$manufacturer $model"
        Log.v("RtnMyLibraryModule", "result is $result")
        promise?.resolve(result)
    }

    companion object {
        const val NAME = "RTNMyLibrary"
    }
}