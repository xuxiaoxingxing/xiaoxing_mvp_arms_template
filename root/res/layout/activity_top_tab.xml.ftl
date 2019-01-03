<?xml version="1.0" encoding="utf-8"?>


<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
              xmlns:tl="http://schemas.android.com/apk/res-auto"
              android:layout_width="match_parent"
              android:layout_height="match_parent"
              android:background="@color/public_white"
              android:orientation="vertical">

    <#if needHeadRightButton>
        <include layout="@layout/public_toolbar_right_button"/>
    <#else>
        <include layout="@layout/public_toolbar"/>
    </#if>

    <com.flyco.tablayout.SlidingTabLayout
            android:id="@+id/tl_2"
            android:layout_width="0dp"
            android:layout_height="48dp"
            android:layout_weight="1"
            android:background="@color/public_white"
            tl:tl_divider_color="#1A000000"
            tl:tl_divider_padding="13dp"
            tl:tl_divider_width="1dp"
            tl:tl_indicator_color="#000000"
            tl:tl_indicator_height="1.5dp"
            tl:tl_indicator_width_equal_title="true"
            tl:tl_tab_padding="0dp"
            tl:tl_tab_space_equal="true"
            tl:tl_textSelectColor="#661F26"
            tl:tl_textUnselectColor="#111111"
            tl:tl_underline_color="#1A000000"
            tl:tl_underline_height="1dp"/>


    <android.support.v4.view.ViewPager
            android:id="@+id/vp"
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:layout_below="@+id/ll_tab"/>

</LinearLayout>


