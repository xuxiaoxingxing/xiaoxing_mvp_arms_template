<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
              xmlns:tools="http://schemas.android.com/tools"
              android:layout_width="match_parent"
              android:layout_height="@dimen/dp_100"
              android:orientation="vertical">


    <RelativeLayout
            android:layout_width="match_parent"
            android:layout_height="@dimen/dp_100"
            android:orientation="vertical"
            android:padding="@dimen/dp_5">

        <ImageView
                android:id="@+id/img_head"
                android:layout_width="@dimen/dp_80"
                android:layout_height="@dimen/dp_80"
                android:adjustViewBounds="true"
                android:src="@mipmap/arms_log"/>

        <TextView
                android:id="@+id/img_green"
                android:layout_width="@dimen/dp_20"
                android:layout_height="@dimen/dp_20"
                android:layout_below="@+id/tv_time"
                android:layout_alignParentRight="true"
                android:layout_marginTop="@dimen/dp_10"
                android:layout_marginRight="@dimen/dp_10"
                android:adjustViewBounds="true"
                android:background="@mipmap/arms_log"
                android:gravity="center"
                android:text="1"
                android:textColor="@color/public_white"/>

        <TextView
                android:id="@+id/tv_title"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginLeft="@dimen/dp_10"
                android:layout_marginTop="@dimen/dp_10"
                android:layout_marginRight="@dimen/dp_10"
                android:layout_toRightOf="@+id/img_head"
                android:lines="1"
                android:text="Xiao"
                android:textColor="@color/public_black"
                android:textSize="@dimen/public_font_16sp"/>

        <TextView
                android:id="@+id/tv_content"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_below="@+id/tv_title"
                android:layout_marginLeft="@dimen/dp_10"
                android:layout_marginTop="@dimen/dp_10"
                android:layout_toRightOf="@+id/img_head"
                android:text="照片已傳送"
                android:textColor="#CECECE"
                android:textSize="@dimen/public_font_14sp"/>

        <TextView
                android:id="@+id/tv_time"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_alignParentRight="true"
                android:layout_marginLeft="@dimen/dp_10"
                android:layout_marginTop="@dimen/dp_10"
                android:layout_marginRight="@dimen/dp_10"
                android:lines="1"
                android:text="下午10:22"
                android:textColor="#A0A0A0"
                android:textSize="@dimen/public_font_14sp"/>


    </RelativeLayout>

</LinearLayout>