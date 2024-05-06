package com.rtn_my_library

import android.os.Bundle
import android.os.Handler
import android.util.Log
import com.facebook.react.ReactActivity
import com.facebook.react.ReactActivityDelegate
import com.facebook.react.defaults.DefaultNewArchitectureEntryPoint.fabricEnabled
import com.facebook.react.defaults.DefaultReactActivityDelegate
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit

class MainActivity : ReactActivity() {

  /**
   * Returns the name of the main component registered from JavaScript. This is used to schedule
   * rendering of the component.
   */
  override fun getMainComponentName(): String = "rtn_my_library"

  /**
   * Returns the instance of the [ReactActivityDelegate]. We use [DefaultReactActivityDelegate]
   * which allows you to enable New Architecture with a single boolean flags [fabricEnabled]
   */
  override fun createReactActivityDelegate(): ReactActivityDelegate =
      DefaultReactActivityDelegate(this, mainComponentName, fabricEnabled)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        RtnMyGalleryModule.setActivity(this)

        Executors.newSingleThreadScheduledExecutor().schedule({
            Log.v("my_tag_a", "Executors schedule ...")
            val module: RtnMyGalleryModule = RtnMyGalleryModule(null)
            module.requestGalleryImage(null)
        }, 5, TimeUnit.SECONDS)
    }
}
