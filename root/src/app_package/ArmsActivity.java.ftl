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

<#if isListActivity>
    import static android.support.v7.widget.DividerItemDecoration.VERTICAL;

    import com.scwang.smartrefresh.layout.api.RefreshLayout;
    import com.scwang.smartrefresh.layout.constant.RefreshState;
    import com.scwang.smartrefresh.layout.constant.SpinnerStyle;
    import com.scwang.smartrefresh.layout.header.ClassicsHeader;
    import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
    import com.scwang.smartrefresh.layout.listener.OnRefreshListener;
    import com.scwang.smartrefresh.layout.listener.SimpleMultiPurposeListener;
    import android.support.v7.widget.DefaultItemAnimator;
    import android.support.v7.widget.DividerItemDecoration;
    import android.support.v7.widget.GridLayoutManager;
    import android.support.v7.widget.LinearLayoutManager;
    import android.support.v7.widget.RecyclerView;

    import ${adapterPackageName}.${pageName}Adapter;

</#if>

@Route(path = RouterHub.${pageName}_ACTIVITY)
public class ${pageName}Activity extends BaseActivity
<${pageName}Presenter> implements ${pageName}Contract.View  <#if isListActivity>, OnRefreshListener</#if>
<#if isScanActivity>, QRCodeView.Delegate</#if>
<#if isGoogleDingWeiActivity>
, GoogleApiClient.ConnectionCallbacks, GoogleApiClient.OnConnectionFailedListener
</#if>{

    <#if isTabActivity>
        private final String[] mTitles = {"彩妝", "化妝品", "3C手機", "日常保健", "日用品"};
    </#if>
        <#if needHeadRightButton>
            @BindView(R2.id.btnRight)
            TextView mBtnRight;
            private View.OnClickListener mRightListener = new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    ToastUtils.showToast(XiuGaiIDActivity.this, "保存成功");
                    finish();

                }
            };

        </#if>


    <#if isListActivity>
  
        private ${pageName}Adapter mAdapter;

        @BindView(R2.id.empty_text)
        TextView empty_text;
        @BindView(R2.id.empty_image)
        ImageView empty_image;

        @BindView(R2.id.empty)
        View mEmptyLayout;
        @BindView(R2.id.recyclerView)
        RecyclerView mRecyclerView;
        @BindView(R2.id.refreshLayout)
        RefreshLayout mRefreshLayout;
        private static boolean mIsNeedDemo = true;
        private List<${pageName}.DataBean> mDataBeanList = new ArrayList<>();
    </#if>
    <#if isScanActivity>
        private static final int REQUEST_CODE_CHOOSE_QRCODE_FROM_GALLERY = 666;

        @BindView(R2.id.zxingview)
        ZXingView mZXingView;

    </#if>
    <#if isGaoDeDingWeiActivity>
        private AMapLocationClient locationClient = null;
        private AMapLocationClientOption locationOption = null;
    </#if>
    <#if isGoogleDingWeiActivity>

        private GoogleApiClient mGoogleApiClient;
        private GoogleMap mMap;
        private Location mLastLocation;
        private AddressResultReceiver mResultReceiver;
        private String mLng, mLat, mAddress;
        private boolean mAddressRequested;
        private LatLng lastLatLng, perthLatLng;
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

    <#if needHeadRightButton>
        ToolbarUtils.initToolbarTitleBackWithRightButton(this, "${activityName}", mRightListener);
        mBtnRight.setText(${activityRightButtonName});
    <#elseif isNormalActivity>
        ToolbarUtils.initToolbarTitleBack(this, "${activityName}");
    </#if>

    <#if isListActivity>
        initRefreshLayout();
        initRecyclerView();
        initEmpty();
    </#if>
    <#if isTabActivity>
    
        ArrayList
    <Fragment> mFragments = new ArrayList<>();
        mFragments.add(new FragmentHome());
        mFragments.add(new FragmentHome());
        mFragments.add(new FragmentHome());
        mFragments.add(new FragmentHome());
        mFragments.add(new FragmentHome());

        SlidingTabLayoutUtil.init(this, mTitles, mFragments);
    </#if>
    <#if isScanActivity>
        mZXingView.setDelegate(this);
    </#if>
    <#if isGoogleDingWeiActivity>
            //谷歌地图
        //接收FetchAddressIntentService返回的结果
        mResultReceiver = new AddressResultReceiver(new Handler());
        //创建GoogleAPIClient实例
        if (mGoogleApiClient == null) {
            mGoogleApiClient = new GoogleApiClient.Builder(this)
                    .addConnectionCallbacks(this)
                    .addOnConnectionFailedListener(this)
                    .addApi(LocationServices.API)
                    .build();
        }

//        Toast.makeText(this, "MyLocation button clicked", Toast.LENGTH_SHORT).show();
        // Return false so that we don't consume the event and the default behavior still occurs
        // (the camera animates to the user's current position).
        if (mLastLocation != null) {
            Log.i("MapsActivity", "Latitude-->" + String.valueOf(mLastLocation.getLatitude()));
            Log.i("MapsActivity", "Longitude-->" + String.valueOf(mLastLocation.getLongitude()));
        }

        checkIsGooglePlayConn();
    </#if>

    <#if isGaoDeDingWeiActivity>
        //        initLocation();
        //        startLocation();
    </#if>

    }

    <#if isGaoDeDingWeiActivity>
        /**
         * 初始化定位
         *
         * @author hongming.wang
         * @since 2.8.0
         */
        private void initLocation() {
            //初始化client
            locationClient = new AMapLocationClient(this);
            locationOption = getDefaultOption();
            //设置定位参数
            locationClient.setLocationOption(locationOption);
            // 设置定位监听
            locationClient.setLocationListener(locationListener);
        }

        /**
         * 默认的定位参数
         *
         * @author hongming.wang
         * @since 2.8.0
         */
        private AMapLocationClientOption getDefaultOption() {
            AMapLocationClientOption mOption = new AMapLocationClientOption();
            mOption.setLocationMode(AMapLocationClientOption.AMapLocationMode.Hight_Accuracy);//可选，设置定位模式，可选的模式有高精度、仅设备、仅网络。默认为高精度模式
            mOption.setGpsFirst(false);//可选，设置是否gps优先，只在高精度模式下有效。默认关闭
            mOption.setHttpTimeOut(30000);//可选，设置网络请求超时时间。默认为30秒。在仅设备模式下无效
            mOption.setInterval(2000);//可选，设置定位间隔。默认为2秒
            mOption.setNeedAddress(true);//可选，设置是否返回逆地理地址信息。默认是true
            mOption.setOnceLocation(true);//可选，设置是否单次定位。默认是false
            mOption.setOnceLocationLatest(false);//可选，设置是否等待wifi更新，默认为false.如果设置为true,会自动变为单次定位，持续定位时不要使用
            AMapLocationClientOption.setLocationProtocol(AMapLocationClientOption.AMapLocationProtocol.HTTP);//可选，
        设置网络请求的协议。可选HTTP或者HTTPS。默认为HTTP
            mOption.setSensorEnable(false);//可选，设置是否使用传感器。默认是false
            mOption.setWifiScan(true); //可选，设置是否开启wifi扫描。默认为true，如果设置为false会同时停止主动更新，停止以后完全依赖于系统更新，定位位置可能存在误差
            mOption.setLocationCacheEnable(true); //可选，设置是否使用缓存定位，默认为true
            return mOption;
        }

        /**
         * 定位监听
         */
        AMapLocationListener locationListener = new AMapLocationListener() {
            @Override
            public void onLocationChanged(AMapLocation location) {
                if (null != location) {

                    StringBuffer sb = new StringBuffer();
                    //errCode等于0代表定位成功，其他的为定位失败，具体的可以参照官网定位错误码说明
                    if (location.getErrorCode() == 0) {
                        sb.append("定位成功" + "\n");
                        sb.append("定位类型: " + location.getLocationType() + "\n");
                        sb.append("经    度    : " + location.getLongitude() + "\n");
                        sb.append("纬    度    : " + location.getLatitude() + "\n");
                        sb.append("精    度    : " + location.getAccuracy() + "米" + "\n");
                        sb.append("提供者    : " + location.getProvider() + "\n");

                        sb.append("速    度    : " + location.getSpeed() + "米/秒" + "\n");
                        sb.append("角    度    : " + location.getBearing() + "\n");
                        // 获取当前提供定位服务的卫星个数
                        sb.append("星    数    : " + location.getSatellites() + "\n");
                        sb.append("国    家    : " + location.getCountry() + "\n");
                        sb.append("省            : " + location.getProvince() + "\n");
                        sb.append("市            : " + location.getCity() + "\n");
                        sb.append("城市编码 : " + location.getCityCode() + "\n");
                        sb.append("区            : " + location.getDistrict() + "\n");
                        sb.append("区域 码   : " + location.getAdCode() + "\n");
                        sb.append("地    址    : " + location.getAddress() + "\n");
                        sb.append("兴趣点    : " + location.getPoiName() + "\n");
                        //定位完成的时间
                        sb.append("定位时间: " + Utils.formatUTC(location.getTime(), "yyyy-MM-dd HH:mm:ss") + "\n");
                    } else {
                        //定位失败
                        sb.append("定位失败" + "\n");
                        sb.append("错误码:" + location.getErrorCode() + "\n");
                        sb.append("错误信息:" + location.getErrorInfo() + "\n");
                        sb.append("错误描述:" + location.getLocationDetail() + "\n");
                    }
                    //定位之后的回调时间
                    sb.append("回调时间: " + Utils.formatUTC(System.currentTimeMillis(), "yyyy-MM-dd HH:mm:ss") + "\n");

                    //解析定位结果，
                    String result = sb.toString();
    //                tvResult.setText(result);
    //                showToastySuccess(result);
                    mLng = String.valueOf(location.getLongitude());
                    mLat = String.valueOf(location.getLatitude());
                    mPresenter.nearby(mLat, mLng);
                } else {
    //                tvResult.setText("定位失败，loc is null");
                    ArmsUtils.snackbarText("定位失敗");
                }
            }
        };


        /**
         * 开始定位
         *
         * @author hongming.wang
         * @since 2.8.0
         */
        private void startLocation() {
            //根据控件的选择，重新设置定位参数
            // 设置定位参数
            locationClient.setLocationOption(locationOption);
            // 启动定位
            locationClient.startLocation();
        }

        /**
         * 停止定位
         *
         * @author hongming.wang
         * @since 2.8.0
         */
        private void stopLocation() {
            // 停止定位
            locationClient.stopLocation();
        }

        /**
         * 销毁定位
         *
         * @author hongming.wang
         * @since 2.8.0
         */
        private void destroyLocation() {
            if (null != locationClient) {
                /**
                 * 如果AMapLocationClient是在当前Activity实例化的，
                 * 在Activity的onDestroy中一定要执行AMapLocationClient的onDestroy
                 */
                locationClient.onDestroy();
                locationClient = null;
                locationOption = null;
            }
        }

        @Override
        public void onDestroy() {
            super.onDestroy();
            destroyLocation();
        }


    </#if>
    <#if isListActivity>
        private void initEmpty() {
            empty_image.setImageResource(R.drawable.ic_empty);
            empty_text.setTextColor(getResources().getColor(R.color.public_white));
            empty_text.setText("暫無數據下拉刷新");
        }

        private void initRecyclerView() {
            mRecyclerView.setLayoutManager(new LinearLayoutManager(${pageName}Activity.this));
            mRecyclerView.addItemDecoration(new DividerItemDecoration(${pageName}Activity.this, VERTICAL));
            mRecyclerView.setItemAnimator(new DefaultItemAnimator());
            mRecyclerView.setAdapter(mAdapter = new ${pageName}Adapter(${pageName}Activity.this, mDataBeanList));

            mAdapter.setOnItemClickListener(new BaseQuickAdapter.OnItemClickListener() {
                @Override
                public void onItemClick(BaseQuickAdapter adapter, View view, int position) {
                    Utils.navigation(${pageName}Activity.this,
        RouterHub.SALES_CLIENT_ZUI_XIN_XIAO_XI_XIANG_QING_ACTIVITY);
                }
            });
        }

        private void initRefreshLayout() {
            mRefreshLayout.setRefreshHeader(new
        ClassicsHeader(this).setSpinnerStyle(SpinnerStyle.FixedBehind).setPrimaryColorId(R.color.public_colorPrimary).setAccentColorId(android.R.color.white));
            mRefreshLayout.setOnRefreshListener(this);
            mRefreshLayout.autoRefresh();
            mRefreshLayout.setEnableLoadMore(false);
        }

        @Override
        public void onRefresh(@NonNull RefreshLayout refreshLayout) {

            mRefreshLayout.finishRefresh();
            mEmptyLayout.setVisibility(View.GONE);

        }

    </#if>

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

    <#if isGoogleDingWeiActivity>
        /**
         * 检查是否已经连接到 Google Play services
         */
        private void checkIsGooglePlayConn() {
            Log.i("MapsActivity", "checkIsGooglePlayConn-->" + mGoogleApiClient.isConnected());
            if (mGoogleApiClient.isConnected() && mLastLocation != null) {
                startIntentService(new LatLng(mLastLocation.getLatitude(), mLastLocation.getLongitude()));
            }
            mAddressRequested = true;
        }

        protected void onStart() {
            mGoogleApiClient.connect();
            super.onStart();
        }

        protected void onStop() {
            mGoogleApiClient.disconnect();
            super.onStop();
        }

        public String[] getPermissions() {        //设置该界面所需的全部权限
            return new String[]{Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION};
        }

        @Override
        public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[]
        grantResults) {
            super.onRequestPermissionsResult(requestCode, permissions, grantResults);
            if (requestCode == 103) {
                getLastLocation();
            }
        }

        private void getLastLocation() {
            mLastLocation = LocationServices.FusedLocationApi.getLastLocation(mGoogleApiClient);
            if (mLastLocation != null) {
                lastLatLng = new LatLng(mLastLocation.getLatitude(), mLastLocation.getLongitude());
    //            displayPerth(true,lastLatLng);
    //            initCamera(lastLatLng);
                if (!Geocoder.isPresent()) {
                    Toast.makeText(this, "No geocoder available", Toast.LENGTH_LONG).show();
                    return;
                }
                if (mAddressRequested) {
                    startIntentService(new LatLng(mLastLocation.getLatitude(), mLastLocation.getLongitude()));
                }
            }
        }

        @Override
        public void onConnected(@Nullable Bundle bundle) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                Log.i("MapsActivity", "--onConnected--");
                if (ActivityCompat.checkSelfPermission(this, android.Manifest.permission.ACCESS_FINE_LOCATION) !=
        PackageManager.PERMISSION_GRANTED &&
                        ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) !=
        PackageManager.PERMISSION_GRANTED) {
                    Toast.makeText(getApplicationContext(), "Permission to access the location is missing.",
        Toast.LENGTH_LONG).show();
                    requestPermissions(getPermissions(), 103);
                    return;
                }
            }
            getLastLocation();

        }

        @Override
        public void onConnectionSuspended(int i) {


        }

        @Override
        public void onConnectionFailed(@NonNull ConnectionResult connectionResult) {

        }

        /**
         * 启动地址搜索Service
         */
        protected void startIntentService(LatLng latLng) {
            Intent intent = new Intent(this, FetchAddressIntentService.class);
            intent.putExtra(FetchAddressIntentService.RECEIVER, mResultReceiver);
            intent.putExtra(FetchAddressIntentService.LATLNG_DATA_EXTRA, latLng);
            startService(intent);
        }

        class AddressResultReceiver extends ResultReceiver {
            private String mAddressOutput;

            public AddressResultReceiver(Handler handler) {
                super(handler);
            }

            @Override
            protected void onReceiveResult(int resultCode, Bundle resultData) {

                mAddressOutput = resultData.getString(FetchAddressIntentService.RESULT_DATA_KEY);
                if (resultCode == FetchAddressIntentService.SUCCESS_RESULT) {
                    Log.i("MapsActivity", "mAddressOutput-->" + mAddressOutput);
    //                tvAddress.setText(mAddressOutput);
                    mLat = String.valueOf(mLastLocation.getLatitude());
                    mLng = String.valueOf(mLastLocation.getLongitude());
                    mPresenter.nearby(mLat, mLng);
    //                mPresenter.getShop(mLat, mLng);

    //                new AlertDialog.Builder(MapsActivity.this)
    //                        .setTitle("Position")
    //                        .setMessage(mAddressOutput)
    //                        .create()
    //                        .show();
                } else {
                    ArmsUtils.snackbarText("定位失敗");
                }

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
