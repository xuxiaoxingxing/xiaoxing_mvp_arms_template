<?xml version="1.0" encoding="utf-8"?>


<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
              xmlns:app="http://schemas.android.com/apk/res-auto"
              xmlns:tools="http://schemas.android.com/tools"
              android:layout_width="match_parent"
              android:layout_height="match_parent"
              android:orientation="vertical"
              tools:ignore="ResourceName">

    <include layout="@layout/public_toolbar"/>

    <cn.bingoogolapple.qrcode.zxing.ZXingView
            android:id="@+id/zxingview"
            style="@style/MatchMatch"
            app:qrcv_animTime="1000"
            app:qrcv_barCodeTipText="将条码放入框内，即可自动扫描"
            app:qrcv_barcodeRectHeight="120dp"
            app:qrcv_borderColor="@android:color/white"
            app:qrcv_borderSize="1dp"
            app:qrcv_cornerColor="@color/colorPrimaryDark"
            app:qrcv_cornerDisplayType="center"
            app:qrcv_cornerLength="20dp"
            app:qrcv_cornerSize="3dp"
            app:qrcv_customScanLineDrawable="@drawable/scan_icon_scanline"
            app:qrcv_isBarcode="false"
            app:qrcv_isOnlyDecodeScanBoxArea="false"
            app:qrcv_isScanLineReverse="true"
            app:qrcv_isShowDefaultGridScanLineDrawable="false"
            app:qrcv_isShowDefaultScanLineDrawable="true"
            app:qrcv_isShowLocationPoint="false"
            app:qrcv_isShowTipBackground="true"
            app:qrcv_isShowTipTextAsSingleLine="false"
            app:qrcv_isTipTextBelowRect="false"
            app:qrcv_maskColor="#33FFFFFF"
            app:qrcv_qrCodeTipText="将二维码/条码放入框内，即可自动扫描"
            app:qrcv_rectWidth="200dp"
            app:qrcv_scanLineColor="@color/colorPrimaryDark"
            app:qrcv_scanLineMargin="0dp"
            app:qrcv_scanLineSize="0.5dp"
            app:qrcv_tipTextColor="@android:color/white"
            app:qrcv_tipTextSize="12sp"
            app:qrcv_toolbarHeight="56dp"
            app:qrcv_topOffset="80dp"
            app:qrcv_verticalBias="-1"/>

</LinearLayout>
