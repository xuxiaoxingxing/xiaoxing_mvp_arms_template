<?xml version="1.0" encoding="utf-8"?>
<!--     implementation 'com.google.android.gms:play-services:9.8.0'
    implementation 'com.google.android.gms:play-services-location:9.8.0'
 -->
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/bg_color"
    android:orientation="vertical">

    <include layout="@layout/public_toolbar" />

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical">


        <fragment xmlns:tools="http://schemas.android.com/tools"
            android:id="@+id/map"
            android:name="com.google.android.gms.maps.SupportMapFragment"
            android:layout_width="match_parent"
            android:layout_height="0dp"
            android:layout_weight="1"
            tools:context="com.xiaoxing.maji.mvp.ui.activity.MapsActivity" />

       
    </LinearLayout>

</LinearLayout>
