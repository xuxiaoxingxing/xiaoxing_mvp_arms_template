<?xml version="1.0" encoding="utf-8"?>


<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
              xmlns:tools="http://schemas.android.com/tools"
              android:orientation="vertical"
              android:layout_width="match_parent"
              android:layout_height="match_parent">

    <#if needHeadRightButton>
        <include layout="@layout/public_toolbar_right_button"/>
    <#else >
        <include layout="@layout/public_toolbar"/>
    </#if>


    <#if isListFragment>
        <include layout="@layout/include_smart_refresh_layout"/>
    </#if>

</LinearLayout>
