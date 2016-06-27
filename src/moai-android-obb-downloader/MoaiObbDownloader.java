package com.ziplinegames.moai;

import android.app.Activity;
import android.app.PendingIntent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.util.Log;
import android.content.Intent;
import android.os.Messenger;
import android.content.pm.PackageManager.NameNotFoundException;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.provider.Settings;

import java.io.InputStream;

import com.google.android.vending.expansion.downloader.*;

public class MoaiObbDownloader extends Activity implements IDownloaderClient {
    private ProgressBar mPB;

    private TextView mStatusText;
    private TextView mProgressFraction;
    private TextView mProgressPercent;
    private TextView mAverageSpeed;
    private TextView mTimeRemaining;

    private View mDashboard;
    private View mCellMessage;

    private Button mPauseButton;
    private Button mWiFiSettingsButton;

    private boolean mStatePaused;
    private int mState;

    private IDownloaderService mRemoteService;

    private IStub mDownloaderClientStub;
    private static final String LOG_TAG = "OBB";

    private static Activity sActivity = null;

    //----------------------------------------------------------------//
    public static void onCreate ( Activity activity ) {

		MoaiLog.i ( "MoaiObbDownloader onCreate: Initializing Obb Downloader" );
		sActivity = activity;

        init ();
	}

    //----------------------------------------------------------------//
    public static void init () {

        sActivity.runOnUiThread (new Runnable () {

  			public void run () {

                Intent i = new Intent ( sActivity, MoaiObbDownloader.class );
          		sActivity.startActivity ( i );
			}
		} );
    }

    //----------------------------------------------------------------//
    @Override
    public void onCreate ( Bundle savedInstanceState ) {

        super.onCreate ( savedInstanceState );

		requestWindowFeature ( Window.FEATURE_NO_TITLE );

		try {

			Intent launchIntent = getIntent();
			Intent intentToLaunchMainActivityFromNotification = new Intent(this, MoaiObbDownloader.class);
			intentToLaunchMainActivityFromNotification.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED);
			intentToLaunchMainActivityFromNotification.setAction("android.intent.action.MAIN");
			intentToLaunchMainActivityFromNotification.addCategory("android.intent.category.LAUNCHER");

			// Build PendingIntent used to open this activity from Notification
			PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, intentToLaunchMainActivityFromNotification, PendingIntent.FLAG_UPDATE_CURRENT);
			// Request to start the download
			int startResult = DownloaderClientMarshaller.startDownloadServiceIfRequired(this, pendingIntent, MoaiObbDownloaderService.class);

			if (startResult != DownloaderClientMarshaller.NO_DOWNLOAD_REQUIRED) {
				// The DownloaderService has started downloading the files, show progress
				initializeDownloadUI();
				return;
			} // otherwise, download not needed so we fall through to starting the movie
		} catch ( NameNotFoundException e ) {

            MoaiLog.i ( "MoaiObbDownloader: Cannot find own package! MAYDAY!" );
			e.printStackTrace ();
		}

        onFinishDownload ();
		finish ();
    }

    //----------------------------------------------------------------//
    @Override
    protected void onResume () {

        if ( null != mDownloaderClientStub ) {
            mDownloaderClientStub.connect ( this );
        }

        super.onResume ();
    }

    //----------------------------------------------------------------//
    @Override
    protected void onStop () {

        if ( null != mDownloaderClientStub ) {
            mDownloaderClientStub.disconnect ( this );
        }

        super.onStop();
    }

    //----------------------------------------------------------------//
    private void initializeDownloadUI() {
        mDownloaderClientStub = DownloaderClientMarshaller.CreateStub(this, MoaiObbDownloaderService.class);
        setContentView(Helpers.getLayoutResource(this, "downloader"));

        mPB = (ProgressBar) findViewById(Helpers.getIdResource(this, "progressBar"));
        mStatusText = (TextView) findViewById(Helpers.getIdResource(this, "statusText"));
        mProgressFraction = (TextView) findViewById(Helpers.getIdResource(this, "progressAsFraction"));
        mProgressPercent = (TextView) findViewById(Helpers.getIdResource(this, "progressAsPercentage"));
        mAverageSpeed = (TextView) findViewById(Helpers.getIdResource(this, "progressAverageSpeed"));
        mTimeRemaining = (TextView) findViewById(Helpers.getIdResource(this, "progressTimeRemaining"));
        mDashboard = findViewById(Helpers.getIdResource(this, "downloaderDashboard"));
        mCellMessage = findViewById(Helpers.getIdResource(this, "approveCellular"));
        mPauseButton = (Button) findViewById(Helpers.getIdResource(this, "pauseButton"));
        mWiFiSettingsButton = (Button) findViewById(Helpers.getIdResource(this, "wifiSettingsButton"));

        mPauseButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (mStatePaused) {
                    mRemoteService.requestContinueDownload();
                } else {
                    mRemoteService.requestPauseDownload();
                }
                setButtonPausedState(!mStatePaused);
            }
        });

        mWiFiSettingsButton.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                startActivity(new Intent(Settings.ACTION_WIFI_SETTINGS));
            }
        });

        Button resumeOnCell = (Button) findViewById(Helpers.getIdResource(this, "resumeOverCellular"));
        resumeOnCell.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                mRemoteService.setDownloadFlags(IDownloaderService.FLAGS_DOWNLOAD_OVER_CELLULAR);
                mRemoteService.requestContinueDownload();
                mCellMessage.setVisibility(View.GONE);
            }
        });

    }

    //----------------------------------------------------------------//
    private void setState(int newState) {
        if (mState != newState) {
            mState = newState;
            mStatusText.setText(Helpers.getDownloaderStringResourceIDFromState(this, newState));
        }
    }

    //----------------------------------------------------------------//
    private void setButtonPausedState(boolean paused) {
        mStatePaused = paused;
        int stringResourceID = Helpers.getStringResource(this, paused ? "text_button_resume" : "text_button_pause");
        mPauseButton.setText(stringResourceID);
    }

    //----------------------------------------------------------------//
	@Override
	public void onServiceConnected(Messenger m) {
        mRemoteService = DownloaderServiceMarshaller.CreateProxy(m);
        mRemoteService.onClientUpdated(mDownloaderClientStub.getMessenger());
	}

    //----------------------------------------------------------------//
	@Override
	public void onDownloadStateChanged(int newState) {
        setState(newState);
        boolean showDashboard = true;
        boolean showCellMessage = false;
        boolean paused;
        boolean indeterminate;
        switch (newState) {
            case IDownloaderClient.STATE_IDLE:
                // STATE_IDLE means the service is listening, so it's
                // safe to start making calls via mRemoteService.
                paused = false;
                indeterminate = true;
                break;
            case IDownloaderClient.STATE_CONNECTING:
            case IDownloaderClient.STATE_FETCHING_URL:
                showDashboard = true;
                paused = false;
                indeterminate = true;
                break;
            case IDownloaderClient.STATE_DOWNLOADING:
                paused = false;
                showDashboard = true;
                indeterminate = false;
                break;

            case IDownloaderClient.STATE_FAILED_CANCELED:
            case IDownloaderClient.STATE_FAILED:
            case IDownloaderClient.STATE_FAILED_FETCHING_URL:
            case IDownloaderClient.STATE_FAILED_UNLICENSED:
                paused = true;
                showDashboard = false;
                indeterminate = false;
                break;
            case IDownloaderClient.STATE_PAUSED_NEED_CELLULAR_PERMISSION:
            case IDownloaderClient.STATE_PAUSED_WIFI_DISABLED_NEED_CELLULAR_PERMISSION:
                showDashboard = false;
                paused = true;
                indeterminate = false;
                showCellMessage = true;
                break;
            case IDownloaderClient.STATE_PAUSED_BY_REQUEST:
                paused = true;
                indeterminate = false;
                break;
            case IDownloaderClient.STATE_PAUSED_ROAMING:
            case IDownloaderClient.STATE_PAUSED_SDCARD_UNAVAILABLE:
                paused = true;
                indeterminate = false;
                break;
            case IDownloaderClient.STATE_COMPLETED:
                showDashboard = false;
                paused = false;
                indeterminate = false;
                onFinishDownload();
				finish();
                return;
            default:
                paused = true;
                indeterminate = true;
                showDashboard = true;
        }
        int newDashboardVisibility = showDashboard ? View.VISIBLE : View.GONE;
        if (mDashboard.getVisibility() != newDashboardVisibility) {
            mDashboard.setVisibility(newDashboardVisibility);
        }
        int cellMessageVisibility = showCellMessage ? View.VISIBLE : View.GONE;
        if (mCellMessage.getVisibility() != cellMessageVisibility) {
            mCellMessage.setVisibility(cellMessageVisibility);
        }
        mPB.setIndeterminate(indeterminate);
        setButtonPausedState(paused);
	}

    //----------------------------------------------------------------//
	@Override
	public void onDownloadProgress(DownloadProgressInfo progress) {
        mAverageSpeed.setText(getString(Helpers.getStringResource(this, "kilobytes_per_second"),
										Helpers.getSpeedString(progress.mCurrentSpeed)));
        mTimeRemaining.setText(getString(Helpers.getStringResource(this, "time_remaining"),
										 Helpers.getTimeRemaining(progress.mTimeRemaining)));

        progress.mOverallTotal = progress.mOverallTotal;
        mPB.setMax((int) (progress.mOverallTotal >> 8));
        mPB.setProgress((int) (progress.mOverallProgress >> 8));
        mProgressPercent.setText(Long.toString(progress.mOverallProgress
											   * 100 /
											   progress.mOverallTotal) + "%");
        mProgressFraction.setText(Helpers.getDownloadProgressString
								  (progress.mOverallProgress,
								   progress.mOverallTotal));
	}

    //----------------------------------------------------------------//
    public void onFinishDownload () {

        try {

            MoaiLog.i ( "MoaiObbDownloader: mounting OBB as virtual directory" );
            int versionCode = this.getPackageManager ().getPackageInfo( this.getPackageName (), 0 ).versionCode;
            String filePath = Helpers.getSaveFilePath ( this );
            String fileName = Helpers.getExpansionAPKFileName ( this, true, versionCode );

            Moai.mount ( "bundleobb", filePath + "/" + fileName );
            Moai.setWorkingDirectory ( "bundleobb/assets/lua" );
        } catch (NameNotFoundException e) {

            MoaiLog.e ( "MoaiObbDownloader on mount: Unable to locate the application bundle" );
        }
    }
}
