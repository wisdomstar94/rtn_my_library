package com.rtn_my_library

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import android.os.Build;
import android.provider.MediaStore
import android.util.Log
import com.facebook.react.bridge.ActivityEventListener
import com.facebook.react.bridge.BaseActivityEventListener
import java.io.File

class RtnMyLibraryModule(reactContext: ReactApplicationContext?) : NativeRtnMyLibrarySpec(reactContext) {
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

    override fun getName() = NAME

    override fun getDeviceModel(promise: Promise?) {
        val manufacturer: String = Build.MANUFACTURER
        val model: String = Build.MODEL
        val result = "$manufacturer $model"
        Log.v("RtnMyLibraryModule", "result is $result")
        promise?.resolve(result)
    }

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
    }

    companion object {
        const val NAME = "RTNMyLibrary"
    }

    init {
        reactContext?.addActivityEventListener(mActivityEventListener)
    }

    @SuppressLint("Range")
    fun uri2path(context: Context, contentUri: Uri?): String {
        val proj = arrayOf(MediaStore.Images.Media.DATA)
        val cursor = context.contentResolver.query(contentUri!!, proj, null, null, null)
        cursor!!.moveToNext()
        val path = cursor!!.getString(cursor!!.getColumnIndex(MediaStore.MediaColumns.DATA))
//        val uri = Uri.fromFile(File(path))
        cursor!!.close()
        return path
    }
}