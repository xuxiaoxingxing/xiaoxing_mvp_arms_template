<?xml version="1.0" encoding="utf-8"?>


<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
              xmlns:tools="http://schemas.android.com/tools"
              android:orientation="vertical"
              android:background="@color/bg_color"
              android:layout_width="match_parent"
              android:layout_height="match_parent">

	<#if needHeadRightButton>
		<include layout="@layout/public_toolbar_right_button"/>
    <#elseif isNormalActivity>
		<include layout="@layout/public_toolbar"/>
    </#if>

</LinearLayout>
