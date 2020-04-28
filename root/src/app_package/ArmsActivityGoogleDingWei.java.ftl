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
import android.os.Handler;
import android.location.Geocoder;
import android.location.Location;
import android.Manifest;
import android.os.ResultReceiver;
import android.text.TextUtils;

import ${packageName}.R;

import me.jessyan.armscomponent.commonres.utils.ToolbarUtils;
import me.jessyan.armscomponent.commonres.utils.CProgressDialogUtils;
import me.jessyan.armscomponent.commonsdk.core.RouterHub;

import static com.jess.arms.utils.Preconditions.checkNotNull;



@Route(path = RouterHub.${activityToLayout(pageName)})
public class ${pageName}Activity extends BaseActivity<${pageName}Presenter> implements ${pageName}Contract.View, GoogleApiClient.ConnectionCallbacks, GoogleApiClient.OnConnectionFailedListener, OnMapReadyCallback  {

    private GoogleMap mMap;
    private String mOrderId;
    private String mMobile;
    private GoogleApiClient mGoogleApiClient;
    private Location mLastLocation;
    private AddressResultReceiver mResultReceiver;
    private String mLng, mLat, mAddress;
    private boolean mAddressRequested;
    private LatLng lastLatLng, perthLatLng;
    private Disposable mDisposable;
    //    private MarkerOptions mMarkOption;
    private Location mLocation;
    private String mAddressOutput;

    <#if needHeadRightButton>
        @BindView(R.id.btnRight)
        TextView mBtnRight;
        private View.OnClickListener mRightListener = new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ToastUtils.showToast(${pageName}Activity.this, "保存成功");
                finish();

            }
        };

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
        ToolbarUtils.initToolbarTitleBackWithRightButton(this, getString(R.string.${activityToLayout(pageName)}), mRightListener);
        mBtnRight.setText(${activityRightButtonName});
    <#else>
        ToolbarUtils.initToolbarTitleBack(this, getString(R.string.${activityToLayout(pageName)}));
    </#if>
        //get${pageName}Data();
        // Obtain the SupportMapFragment and get notified when the map is ready to be used.
        SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);
        initGoogleMap();
    }

    @Override
    public void get${pageName}DataSuccess(${pageName} entityData) {


    }

    private void get${pageName}Data() {
        HashMap<String, String> map = new HashMap<>();

        mPresenter.get${pageName}Data(map);
    }



    @Override
    public void showLoading() {
        CProgressDialogUtils.showProgressDialog(this);
    }

    @Override
    public void hideLoading() {
        CProgressDialogUtils.cancelProgressDialog(this);
    }

    @Override
    public void showMessage(@NonNull String message) {
        checkNotNull(message);
        ArmsUtils.makeText(this, message);
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

 /**
     * Manipulates the map once available.
     * This callback is triggered when the map is ready to be used.
     * This is where we can add markers or lines, add listeners or move the camera. In this case,
     * we just add a marker near Sydney, Australia.
     * If Google Play services is not installed on the device, the user will be prompted to install
     * it inside the SupportMapFragment. This method will only be triggered once the user has
     * installed Google Play services and returned to the app.
     */
    @Override
    public void onMapReady(GoogleMap googleMap) {
        mMap = googleMap;

//        double lat = 36.1052149;
//        double lng = 120.38442818;
//        LatLng appointLoc = new LatLng(lat, lng);
//
//        // 移动地图到指定经度的位置
//        googleMap.moveCamera(CameraUpdateFactory.newLatLng(appointLoc));
//
//        //添加标记到指定经纬度
//        googleMap.addMarker(new MarkerOptions().position(new LatLng(lat, lng)).title("Marker")
//                .icon(BitmapDescriptorFactory.fromResource(R.mipmap.ic_launcher)));

    }

    protected void onStart() {

        mGoogleApiClient.connect();
        super.onStart();
    }

    protected void onStop() {

        mGoogleApiClient.disconnect();
        super.onStop();
    }

    @Override
    public void onConnected(@Nullable Bundle bundle) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            Log.e("DriverCurrentLocation", "--onConnected--");
            if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED &&
                    ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                Toast.makeText(getApplicationContext(), "Permission to access the location is missing.", Toast.LENGTH_LONG).show();
                requestPermissions(getPermissions(), 103);
                return;
            }
        }
        getLastLocation();

    }

    public String[] getPermissions() {        //设置该界面所需的全部权限
        return new String[]{Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION};
    }

    private void getLastLocation() {
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            // TODO: Consider calling
            //    ActivityCompat#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for ActivityCompat#requestPermissions for more details.
            return;
        }
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

    /**
     * 启动地址搜索Service
     */
    protected void startIntentService(LatLng latLng) {
        Intent intent = new Intent(this, FetchAddressIntentService.class);
        intent.putExtra(FetchAddressIntentService.RECEIVER, mResultReceiver);
        intent.putExtra(FetchAddressIntentService.LATLNG_DATA_EXTRA, latLng);
        startService(intent);
    }

    @Override
    public void onConnectionSuspended(int i) {


    }

    @Override
    public void onConnectionFailed(@NonNull ConnectionResult connectionResult) {

    }
      private void initGoogleMap() {

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
            Log.e("MapsActivity", "Latitude-->" + String.valueOf(mLastLocation.getLatitude()));
            Log.e("MapsActivity", "Longitude-->" + String.valueOf(mLastLocation.getLongitude()));
        }

        checkIsGooglePlayConn();
    }
   /**
     * 检查是否已经连接到 Google Play services
     */
    private void checkIsGooglePlayConn() {
        Log.e("MapsActivity", "checkIsGooglePlayConn-->" + mGoogleApiClient.isConnected());
        if (mGoogleApiClient.isConnected() && mLastLocation != null) {
            startIntentService(new LatLng(mLastLocation.getLatitude(), mLastLocation.getLongitude()));
        }
        mAddressRequested = true;
    }
 class AddressResultReceiver extends ResultReceiver {

        public AddressResultReceiver(Handler handler) {
            super(handler);
        }

        @Override
        protected void onReceiveResult(int resultCode, Bundle resultData) {

            mAddressOutput = resultData.getString(FetchAddressIntentService.RESULT_DATA_KEY);
            if (resultCode == FetchAddressIntentService.SUCCESS_RESULT) {
                Log.e("MapsActivity", "mAddressOutput-->" + mAddressOutput);
//                tvAddress.setText(mAddressOutput);
                mLat = String.valueOf(mLastLocation.getLatitude());
                mLng = String.valueOf(mLastLocation.getLongitude());


                MarkerOptions mMarkOption = new MarkerOptions().icon(BitmapDescriptorFactory.fromAsset("icon_ding_wei_1.png"));
                mMarkOption.draggable(true);
//            double dLat = mLocation.getLatitude();
//            double dLong = mLocation.getLongitude();
                double dLat = TextUtils.isEmpty(mLat) ? 0 : Double.parseDouble(mLat);
                double dLong = TextUtils.isEmpty(mLng) ? 0 : Double.parseDouble(mLng);
                LatLng latlng = new LatLng(dLat, dLong);
                mMarkOption.position(latlng);
//            mMarkOption.title("title");
//            mMarkOption.snippet("snippet");
                // Add a marker in Sydney and move the camera
//                LatLng sydney = new LatLng(-34, 151);
//                mMap.addMarker(new MarkerOptions().position(sydney).title("Marker in Sydney"));

                mMap.moveCamera(CameraUpdateFactory.newLatLng(latlng));
                // 设置缩放级别
                CameraUpdate zoom = CameraUpdateFactory.zoomTo(10);
                mMap.animateCamera(zoom);
//                mMap.getUiSettings().setZoomGesturesEnabled(true);
                mMap.getUiSettings().setAllGesturesEnabled(true);
                mMap.getUiSettings().setZoomControlsEnabled(true);
                Marker mMarker = mMap.addMarker(mMarkOption);


                //getDriverCurrentLocationData();

            } else {
            }

        }
    }
}
