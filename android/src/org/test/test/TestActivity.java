package org.test.test;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.FileProvider;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.media.projection.MediaProjectionManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.StrictMode;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import com.hbisoft.hbrecorder.HBRecorder;
import com.hbisoft.hbrecorder.HBRecorderListener;

import java.io.File;
import java.lang.reflect.Method;

import org.qtproject.qt5.android.bindings.QtActivity;
import org.qtproject.qt5.android.bindings.QtApplication;

public class TestActivity extends QtActivity implements HBRecorderListener {
    private static TestActivity instance = null;
    private static HBRecorder screenRecorder;
    private static final int SCREEN_RECORD_REQUEST_CODE = 777;

    public TestActivity() {
        instance = this;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        screenRecorder = new HBRecorder(this, this);
        screenRecorder.isAudioEnabled(false);
        Log.i("HBRecorderInit", "init");
    }

    public static void shareFile(String filepath, String type) {
        Intent intent = new Intent(Intent.ACTION_SEND);
        File file = new File(filepath);
        Uri uri = FileProvider.getUriForFile(
                    instance,
                    "org.test.test.provider",
                    file);
        if(file.exists()) {
            intent.setType(type);
            intent.putExtra(Intent.EXTRA_STREAM, uri);
            intent.putExtra(Intent.EXTRA_SUBJECT, "Sharing File...");
            intent.putExtra(Intent.EXTRA_TEXT, "Sharing File...");
            instance.startActivity(Intent.createChooser(intent, "Share File"));
        }
    }

    public static void startScreenRecording(String filepath, String filename) {
        Log.i("HBRecorderInit", "start called");
        screenRecorder.setOutputPath(filepath);
        screenRecorder.setFileName(filename);
        MediaProjectionManager mediaProjectionManager = (MediaProjectionManager) instance.getSystemService(Context.MEDIA_PROJECTION_SERVICE);
        Intent permissionIntent = mediaProjectionManager != null ? mediaProjectionManager.createScreenCaptureIntent() : null;
        instance.startActivityForResult(permissionIntent, SCREEN_RECORD_REQUEST_CODE);
    }
    public static void stopScreenRecording() {
        screenRecorder.stopScreenRecording();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == SCREEN_RECORD_REQUEST_CODE) {
            Log.i("HBRecorderInit", "result" + resultCode);
            if (resultCode == RESULT_OK) {
                screenRecorder.startScreenRecording(data, resultCode);
            }
        }
    }

    @Override
    public void HBRecorderOnStart() {
        Log.i("HBRecorderOnStart", "started - " + screenRecorder.getFilePath());
    }

    @Override
    public void HBRecorderOnComplete() {
        Log.e("HBRecorderOnComplete", "completed");
    }
    @Override
    public void HBRecorderOnError(int errorCode, String reason) {
        Log.e("HBRecorderOnError", reason);
    }
}
