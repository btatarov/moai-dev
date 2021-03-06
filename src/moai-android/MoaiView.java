//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package @PACKAGE@;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import android.content.Context;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.opengl.GLSurfaceView;
import android.os.Handler;
import android.os.Looper;
import android.view.MotionEvent;
import android.util.DisplayMetrics;

// Moai
import com.ziplinegames.moai.*;

//================================================================//
// MoaiView
//================================================================//
public class MoaiView extends GLSurfaceView {

		private static final long	AKU_UPDATE_FREQUENCY = 1000 / 60; // 60 Hz, in milliseconds

		private Context		mAppContext;
		private int 		mWidth;
		private int 		mHeight;

    //----------------------------------------------------------------//
		public MoaiView ( Context context, int moaiContext, int width, int height, int glesVersion ) {

				super ( context );

				mAppContext = context.getApplicationContext();

				setScreenDimensions ( width, height );
				Moai.setScreenSize ( mWidth, mHeight );

				DisplayMetrics metrics = getResources().getDisplayMetrics ();
				Moai.setScreenDpi ( metrics.densityDpi );

				// NOTE: Must be set before the renderer is set.
				setEGLContextClientVersion ( 2 );

				// Create the frame update ticker
				Moai.sTicker = new Handler ( Looper.getMainLooper () );
				Moai.sTick = new Runnable () {
						public void run () {
								Moai.update ();
						}
				};

				setEGLConfigChooser(8 , 8, 8, 8, 16, 0);
		    	setRenderer ( new MoaiRenderer ( moaiContext ));
				onPause (); // Pause rendering until restarted by the activity lifecycle.
		}

		//================================================================//
		// Public methods
		//================================================================//

		//----------------------------------------------------------------//
		@Override
		public void onSizeChanged ( int newWidth, int newHeight, int oldWidth, int oldHeight ) {

				setScreenDimensions ( newWidth, newHeight );
				Moai.setViewSize ( mWidth, mHeight );
		}

		//----------------------------------------------------------------//
		public void pause ( boolean paused ) {

			if ( paused ) {

					Moai.pause ( true );
					setRenderMode ( GLSurfaceView.RENDERMODE_WHEN_DIRTY );
					onPause ();
			}
			else {

					setRenderMode ( GLSurfaceView.RENDERMODE_CONTINUOUSLY );
					Moai.pause ( false );
					onResume ();
			}
		}

		//================================================================//
		// MotionEvent methods
		//================================================================//

    //----------------------------------------------------------------//
		@Override
		public boolean onTouchEvent ( MotionEvent event ) {

			boolean isDown = true;

			switch( event.getActionMasked() )
			{
				case MotionEvent.ACTION_CANCEL:
					/*Moai.enqueueTouchEventCancel(
						Moai.InputDevice.INPUT_DEVICE.ordinal (),
						Moai.InputSensor.SENSOR_TOUCH.ordinal ()
					);*/
					break;
				case MotionEvent.ACTION_UP:
				case MotionEvent.ACTION_POINTER_UP:
					isDown = false;
				case MotionEvent.ACTION_DOWN:
				case MotionEvent.ACTION_POINTER_DOWN:
				{
					final int pointerIndex = event.getActionIndex();
					int pointerId = event.getPointerId ( pointerIndex );
					Moai.enqueueTouchEvent (
						Moai.InputDevice.INPUT_DEVICE.ordinal (),
						Moai.InputSensor.SENSOR_TOUCH.ordinal (),
						pointerId,
						isDown,
						Math.round ( event.getX ( pointerIndex )),
						Math.round ( event.getY ( pointerIndex )),
						1
					);
					break;
				}
				case MotionEvent.ACTION_MOVE:
				default:
				{
					final int pointerCount = event.getPointerCount ();
					for ( int pointerIndex = 0; pointerIndex < pointerCount; ++pointerIndex ) {

						int pointerId = event.getPointerId ( pointerIndex );
						Moai.enqueueTouchEvent (
							Moai.InputDevice.INPUT_DEVICE.ordinal (),
							Moai.InputSensor.SENSOR_TOUCH.ordinal (),
							pointerId,
							isDown,
							Math.round ( event.getX ( pointerIndex )),
							Math.round ( event.getY ( pointerIndex )),
							1
						);
					}
					break;
				}
			}

			return true;
		}

		//================================================================//
		// Private methods
		//================================================================//

		//----------------------------------------------------------------//
		public void setScreenDimensions ( int width, int height ) {

				Resources resources = mAppContext.getResources();
				Configuration config = resources.getConfiguration();

				if ( config.orientation == Configuration.ORIENTATION_PORTRAIT ) {
						mWidth = Math.min ( width, height );
						mHeight = Math.max ( width, height );
				}
				else if ( config.orientation == Configuration.ORIENTATION_LANDSCAPE ) {
						mWidth = Math.max ( width, height );
						mHeight = Math.min ( width, height );
				}
				else {
						mWidth = width;
						mHeight = height;
				}
		}

		//================================================================//
		// MoaiRenderer
		//================================================================//
		private class MoaiRenderer implements GLSurfaceView.Renderer {

				private int     mMoaiContext;

				//----------------------------------------------------------------//
		    public MoaiRenderer ( int moaiContext ) {

		        super ();
		        mMoaiContext = moaiContext;
		    }

			  //----------------------------------------------------------------//
				@Override
				public void onDrawFrame ( GL10 gl ) {

						Moai.sTicker.post ( Moai.sTick );
						Moai.render ();
				}

			  //----------------------------------------------------------------//
				@Override
				public void onSurfaceChanged ( GL10 gl, int width, int height ) {

						MoaiLog.i ( "MoaiRenderer onSurfaceChanged: surface CHANGED" );

						setScreenDimensions ( width, height );
						Moai.setViewSize ( mWidth, mHeight );
						Moai.detectFramebuffer ();
				}

			  //----------------------------------------------------------------//
				@Override
				public void onSurfaceCreated ( GL10 gl, EGLConfig config ) {

						MoaiLog.i ( "MoaiRenderer onSurfaceCreated: surface CREATED" );

						Moai.setContext ( mMoaiContext );
						Moai.detectGraphicsContext ();
				}
		}
}
