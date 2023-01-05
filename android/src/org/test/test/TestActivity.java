package org.test.test;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.media.projection.MediaProjectionManager;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import com.hbisoft.hbrecorder.HBRecorder;
import com.hbisoft.hbrecorder.HBRecorderListener;

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
