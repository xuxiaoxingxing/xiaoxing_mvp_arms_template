<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@drawable/guide_img"
    android:orientation="vertical">

    <include layout="@layout/public_toolbar" />

    <RelativeLayout
        android:layout_width="match_parent"
        android:layout_height="match_parent">


        <TextView
            android:id="@+id/tv_count"
            android:layout_width="@dimen/dp_40"
            android:layout_height="@dimen/dp_40"
            android:layout_alignParentRight="true"
            android:text="2s"
            android:textColor="@color/public_white"
            android:textSize="@dimen/public_font_14sp" />

        <ImageView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_centerInParent="true"
            android:layout_marginTop="@dimen/dp_50"
            android:src="@drawable/icon_start" />
    </RelativeLayout>

</LinearLayout>


