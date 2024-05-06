package com.rtn_my_library

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.provider.MediaStore
import android.util.Log
import com.facebook.react.bridge.ActivityEventListener
import com.facebook.react.bridge.BaseActivityEventListener
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import java.io.File


class RtnMyGalleryModule(reactContext: ReactApplicationContext?) : NativeRtnMyGallerySpec(reactContext) {
    private val mActivityEventListener: ActivityEventListener = object : BaseActivityEventListener() {
        override fun onActivityResult(
            activity: Activity,
            requestCode: Int,
            resultCode: Int,
            intent: Intent?
        ) {
            Log.v("my_tag_a", "requestCode : $requestCode")
            if (requestCode == 3000) {
                val imageUri = intent?.data
                val imagePath = uri2path(reactApplicationContext, imageUri)
                Log.v("my_tag_a", imagePath)
                globalPromise?.resolve(imagePath)
            }
        }
    }

    private var globalPromise: Promise? = null;

    init {
        reactContext?.addActivityEventListener(mActivityEventListener)
    }

//    constructor(reactContext: ReactApplicationContext?) {
//        reactContext.addActivityEventListener(mActivityEventListener)
//    }
//    private val galleryLauncher = this.reactApplicationContext.currentActivity.registerForActivityResult(
//        ActivityResultContracts.StartActivityForResult()
//    ) {
//        result ->
//        if (result.resultCode == RESULT_OK) {
//            val imageUri = result.data?.data
//            val imagePath = uri2path(reactApplicationContext, imageUri)
//            Log.v("my_tag_a", imagePath)
////            promise?.resolve(imagePath)
//        }
//    }
    override fun getName() = NAME

    override fun requestGalleryImage(promise: Promise?) {
        globalPromise = promise
        Log.v("my_tag_a", "requestGalleryImage called!!!")
        val intent = Intent(Intent.ACTION_PICK)
        intent.setDataAndType(
            MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
            "image/*"
        )

        Log.v("my_tag_a", "currentActivity Checking!!!")
        if (this.reactApplicationContext?.currentActivity != null) {
            Log.v("my_tag_a", "currentActivity Exist!!!")
        } else {
            Log.v("my_tag_a", "currentActivity Not Exist!!!")
        }

        this.reactApplicationContext.currentActivity?.startActivityForResult(intent, 3000)
//        val activity = this.reactApplicationContext.currentActivity
//        Log.v("my_tag_a", "registerForActivityResult set ...")
//        if (Activity != null) {
//            Log.v("my_tag_a", "Activity Exist! ...")
//        }
//
//        launcher = Activity!!.registerForActivityResult(
//            ActivityResultContracts.StartActivityForResult()
//        ) {
//            result ->
//            Log.v("my_tag_a", "??? ??? ???")
//            if (result.resultCode == RESULT_OK) {
//                val imageUri = result.data?.data
//                val imagePath = uri2path(reactApplicationContext, imageUri)
//                Log.v("my_tag_a", imagePath)
////            promise?.resolve(imagePath)
//            }
//        }
//
//        Log.v("my_tag_a", "intent set ...")
//        val intent = Intent(Intent.ACTION_PICK)
//        intent.setDataAndType(
//            MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
//            "image/*"
//        )
//        Log.v("my_tag_a", "galleryLauncher.launch(intent)")
//        launcher.launch(intent)
    }

    companion object {
        const val NAME = "RTNMyGallery"
//        private var Activity: AppCompatActivity? = null
//        fun setActivity(v: AppCompatActivity) {
//            Activity = v
//        }
    }

    @SuppressLint("Range")
    fun uri2path(context: Context, contentUri: Uri?): String {
        val proj = arrayOf(MediaStore.Images.Media.DATA)
        val cursor = context.contentResolver.query(contentUri!!, proj, null, null, null)
        cursor!!.moveToNext()
        val path = cursor!!.getString(cursor!!.getColumnIndex(MediaStore.MediaColumns.DATA))
        val uri = Uri.fromFile(File(path))
        cursor!!.close()
        return path
    }
}