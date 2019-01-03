package ${ativityPackageName};

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import com.jess.arms.base.BaseActivity;
import com.jess.arms.di.component.AppComponent;
import com.jess.arms.utils.ArmsUtils;

import ${componentPackageName}.Dagger${pageName}Component;
import ${moudlePackageName}.${pageName}Module;
import ${contractPackageName}.${pageName}Contract;
import ${presenterPackageName}.${pageName}Presenter;

import ${packageName}.R;

import me.jessyan.armscomponent.commonres.utils.ToolbarUtils;

import me.jessyan.armscomponent.commonsdk.core.RouterHub;

import static com.jess.arms.utils.Preconditions.checkNotNull;



@Route(path = RouterHub.${activityToLayout(pageName)})
public class ${pageName}Activity extends BaseActivity<${pageName}Presenter> implements ${pageName}Contract.View <#if isScanActivity>, QRCodeView.Delegate</#if>{


    <#if isScanActivity>
        private static final int REQUEST_CODE_CHOOSE_QRCODE_FROM_GALLERY = 666;

        @BindView(R2.id.zxingview)
        ZXingView mZXingView;

    </#if>

    @Override
    public void setupActivityComponent(@NonNull AppComponent appComponent) {
        Dagger${pageName}Component //如找不到该类,请编译一下项目
        .builder()
        .appComponent(appComponent)
        .${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Module(new ${pageName}Module(this))
        .build()
        .inject(this);
    }

    @Override
    public int initView(@Nullable Bundle savedInstanceState) {
        return R.layout.${activityLayoutName}; //如果你不需要框架帮你设置 setContentView(id) 需要自行设置,请返回 0
    }

    @Override
    public void initData(@Nullable Bundle savedInstanceState) {

        ToolbarUtils.initToolbarTitleBack(this, getString(R.string.${activityToLayout(pageName)}));
        <#if isScanActivity>
            mZXingView.setDelegate(this);
        </#if>
    }
    <#if isScanActivity>
        @Override
        protected void onStart() {
        super.onStart();

        mZXingView.startCamera(); // 打开后置摄像头开始预览，但是并未开始识别
        //        mZXingView.startCamera(Camera.CameraInfo.CAMERA_FACING_FRONT); // 打开前置摄像头开始预览，但是并未开始识别

        mZXingView.startSpotAndShowRect(); // 显示扫描框，并且延迟0.5秒后开始识别
        }

        @Override
        protected void onStop() {
        mZXingView.stopCamera(); // 关闭摄像头预览，并且隐藏扫描框
        super.onStop();
        }

        @Override
        protected void onDestroy() {
        mZXingView.onDestroy(); // 销毁二维码扫描控件
        super.onDestroy();
        }

        private void vibrate() {
        Vibrator vibrator = (Vibrator) getSystemService(VIBRATOR_SERVICE);
        vibrator.vibrate(200);
        }

        @Override
        public void onScanQRCodeSuccess(String result) {
        Log.i(TAG, "result:" + result);
        //        setTitle("扫描结果为：" + result);
        if (!TextUtils.isEmpty(result)) {

        } else {
        ArmsUtils.snackbarText("二維碼錯誤");
        }
        vibrate();
        mZXingView.startSpot(); // 延迟0.5秒后开始识别
        }

        @Override
        public void onScanQRCodeOpenCameraError() {
        Log.e(TAG, "打开相机出错");
        }


        @Override
        protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        //        mZXingView.startSpotAndShowRect(); // 显示扫描框，并且延迟0.5秒后开始识别

        if (resultCode == Activity.RESULT_OK && requestCode == REQUEST_CODE_CHOOSE_QRCODE_FROM_GALLERY) {

        }
        }

    </#if>

    @Override
    public void showLoading() {

    }

    @Override
    public void hideLoading() {

    }

    @Override
    public void showMessage(@NonNull String message) {
        checkNotNull(message);
        ArmsUtils.snackbarText(message);
    }

    @Override
    public void launchActivity(@NonNull Intent intent) {
        checkNotNull(intent);
        ArmsUtils.startActivity(intent);
    }

    @Override
    public void killMyself() {
        finish();
    }
    }
