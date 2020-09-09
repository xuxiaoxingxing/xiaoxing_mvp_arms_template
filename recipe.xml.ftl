<?xml version="1.0"?>
<recipe>
    <!-- <#if needActivity>
    <merge from="root/AndroidManifest.xml.ftl"
           to="${escapeXmlAttribute(manifestOut)}/AndroidManifest.xml" />
</#if> -->
<#if needActivity>
    <merge from="root/AndroidManifest.xml.ftl"
           to="app/src/main/AndroidManifest.xml"></merge>
</#if>

<#--<#if needActivity && generateActivityLayout>-->
    <#--<instantiate from="root/res/layout/simple.xml.ftl"-->
                 <#--to="${escapeXmlAttribute(resOut)}/layout/${activityLayoutName}.xml"></instantiate>-->
<#--</#if>-->

<#if needFragment && generateFragmentLayout>
    <instantiate from="root/res/layout/fragment.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${fragmentLayoutName}.xml"></instantiate>
</#if>


<#--<#if needActivity>-->
    <#--<instantiate from="root/src/app_package/ArmsActivity.java.ftl"-->
                 <#--to="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></instantiate>-->
    <#--<open file="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></open>-->
<#--</#if>-->

<#if needFragment>
    <instantiate from="root/src/app_package/ArmsFragment.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(fragmentPackageName)}/${pageName}Fragment.java"></instantiate>
    <instantiate from="root/src/app_package/ArmsAdapterEntity.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(adapterEntityName)}/${pageName}.java"></instantiate>
    <open file="${projectOut}/src/main/java/${slashedPackageName(fragmentPackageName)}/${pageName}Fragment.java"></open>
    <open file="${projectOut}/src/main/java/${slashedPackageName(modelPackageName)}/${pageName}Model.java"></open>

</#if>
<#if isListFragment>
    <instantiate from="root/src/app_package/ArmsAdapter.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(adapterPackageName)}/${pageName}Adapter.java"></instantiate>
    <instantiate from="root/src/app_package/ArmsAdapterEntity.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(adapterEntityName)}/${pageName}.java"></instantiate>
    <instantiate from="root/res/layout/adapter_item.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${adapterLayoutName}.xml"></instantiate>

</#if>

<#if needContract>
    <instantiate from="root/src/app_package/ArmsContract.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(contractPackageName)}/${pageName}Contract.java"></instantiate>
</#if>

<#if needPresenter>
    <instantiate from="root/src/app_package/ArmsPresenter.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(presenterPackageName)}/${pageName}Presenter.java"></instantiate>
    <#--<open file="${projectOut}/src/main/java/${slashedPackageName(presenterPackageName)}/${pageName}Presenter.java"></open>-->
</#if>

<#if needModel>
    <instantiate from="root/src/app_package/ArmsModel.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(modelPackageName)}/${pageName}Model.java"></instantiate>
</#if>

<#if needDagger>
    <instantiate from="root/src/app_package/ArmsComponent.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(componentPackageName)}/${pageName}Component.java"></instantiate>
    <instantiate from="root/src/app_package/ArmsModule.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(moudlePackageName)}/${pageName}Module.java"></instantiate>

</#if>

<#if needActivity&&isListActivity>
    <instantiate from="root/src/app_package/ArmsActivityList.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></instantiate>
    <instantiate from="root/res/layout/activity_list.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${activityLayoutName}.xml"></instantiate>
    <merge from="root/res/values/strings.xml.ftl" to="${projectOut}/src/main/res/values/strings.xml"></merge>
    <merge from="root/AndroidManifest.xml.ftl" to="app/src/main/AndroidManifest.xml"></merge>

    <open file="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></open>
    <open file="${projectOut}/src/main/java/${slashedPackageName(modelPackageName)}/${pageName}Model.java"></open>


</#if>
<#if isListActivity>
    <instantiate from="root/src/app_package/ArmsAdapter.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(adapterPackageName)}/${pageName}Adapter.java"></instantiate>
    <instantiate from="root/src/app_package/ArmsAdapterEntity.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(adapterEntityName)}/${pageName}.java"></instantiate>
    <instantiate from="root/res/layout/adapter_item.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${adapterLayoutName}.xml"></instantiate>

</#if>

<#if isNormalActivity>
    <instantiate from="root/src/app_package/ArmsActivityNormal.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></instantiate>
    <instantiate from="root/res/layout/activity_normal.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${activityLayoutName}.xml"></instantiate>
    <instantiate from="root/src/app_package/ArmsAdapterEntity.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(adapterEntityName)}/${pageName}.java"></instantiate>

    <merge from="root/res/values/strings.xml.ftl" to="${projectOut}/src/main/res/values/strings.xml"></merge>
    <merge from="root/AndroidManifest.xml.ftl" to="app/src/main/AndroidManifest.xml"></merge>

    <open file="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></open>
    <open file="${projectOut}/src/main/java/${slashedPackageName(modelPackageName)}/${pageName}Model.java"></open>

</#if>
<#if isDrawerLayoutActivity>
    <instantiate from="root/src/app_package/ArmsActivityDrawerLayout.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></instantiate>
    <instantiate from="root/src/app_package/ArmsAdapterEntity.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(adapterEntityName)}/${pageName}.java"></instantiate>
    <instantiate from="root/res/layout/drawer_layout_activity_main.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${activityLayoutName}.xml"></instantiate>
    <instantiate from="root/res/layout/drawer_layout_app_bar_main.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/drawer_layout_app_bar_main.xml"></instantiate>
    <instantiate from="root/res/layout/drawer_layout_content_main.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/drawer_layout_content_main.xml"></instantiate>
    <instantiate from="root/res/layout/drawer_layout_nav_header_main.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/drawer_layout_nav_header_main.xml"></instantiate>
    <instantiate from="root/res/menu/drawer_layout_activity_main_drawer.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/menu/drawer_layout_activity_main_drawer.xml"></instantiate>
    <instantiate from="root/res/values/drawer_layout_drawables.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/values/drawer_layout_drawables.xml"></instantiate>


    <merge from="root/res/values/strings.xml.ftl" to="${projectOut}/src/main/res/values/strings.xml"></merge>
    <merge from="root/AndroidManifest.xml.ftl" to="app/src/main/AndroidManifest.xml"></merge>

    <open file="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></open>
    <open file="${projectOut}/src/main/java/${slashedPackageName(modelPackageName)}/${pageName}Model.java"></open>

</#if>
<#if isMainActivity>
    <instantiate from="root/src/app_package/ArmsActivityMain.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></instantiate>
    <instantiate from="root/res/layout/activity_main.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${activityLayoutName}.xml"></instantiate>
    <instantiate from="root/src/app_package/MyViewPagerAdapter.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(packageName)}/mvp/ui/adapter/MyViewPagerAdapter.java"></instantiate>
    <instantiate from="root/src/app_package/NoTouchViewPager.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(packageName)}/mvp/ui/viewpager/NoTouchViewPager.java"></instantiate>
    <instantiate from="root/src/app_package/ArmsFragmentTab1.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(packageName)}/mvp/ui/fragment/Tab1Fragment.java"></instantiate>
    <instantiate from="root/src/app_package/ArmsFragmentTab2.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(packageName)}/mvp/ui/fragment/Tab2Fragment.java"></instantiate>
    <instantiate from="root/src/app_package/ArmsFragmentTab3.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(packageName)}/mvp/ui/fragment/Tab3Fragment.java"></instantiate>
    <instantiate from="root/src/app_package/ArmsFragmentTab4.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(packageName)}/mvp/ui/fragment/Tab4Fragment.java"></instantiate>
    <instantiate from="root/src/app_package/ArmsFragmentTab5.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(packageName)}/mvp/ui/fragment/Tab5Fragment.java"></instantiate>

    <instantiate from="root/res/layout/fragment_tab.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/fragment_tab1.xml"></instantiate>
    <instantiate from="root/res/layout/fragment_tab.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/fragment_tab2.xml"></instantiate>
    <instantiate from="root/res/layout/fragment_tab.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/fragment_tab3.xml"></instantiate>
    <instantiate from="root/res/layout/fragment_tab.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/fragment_tab4.xml"></instantiate>
    <instantiate from="root/res/layout/fragment_tab.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/fragment_tab5.xml"></instantiate>

    <merge from="root/AndroidManifest.xml.ftl" to="app/src/main/AndroidManifest.xml"></merge>

    <open file="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></open>

</#if>

<#if isScanActivity>

    <instantiate from="root/src/app_package/ArmsActivityScan.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></instantiate>
    <instantiate from="root/res/layout/activity_scan.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${activityLayoutName}.xml"></instantiate>

    <merge from="root/res/values/strings.xml.ftl" to="${projectOut}/src/main/res/values/strings.xml"></merge>
    <merge from="root/AndroidManifest.xml.ftl" to="app/src/main/AndroidManifest.xml"></merge>

    <open file="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></open>

    <merge from="root/res/values/styles.xml.ftl" to="${projectOut}/src/main/res/values/styles.xml"></merge>
    <copy from="root/res/drawable-xxhdpi/scan_icon_scanline.png"
          to="${projectOut}/src/main/res/drawable-xxhdpi/scan_icon_scanline.png"></copy>
</#if>
<#if isTabActivity>

    <instantiate from="root/src/app_package/ArmsActivityTopTab.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></instantiate>
    <instantiate from="root/res/layout/activity_top_tab.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${activityLayoutName}.xml"></instantiate>

    <merge from="root/res/values/strings.xml.ftl" to="${projectOut}/src/main/res/values/strings.xml"></merge>
    <merge from="root/AndroidManifest.xml.ftl" to="app/src/main/AndroidManifest.xml"></merge>

    <open file="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></open>

</#if>

<#if isGoogleDingWeiActivity>

    <instantiate from="root/src/app_package/ArmsActivityGoogleDingWei.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></instantiate>
    <instantiate from="root/src/app_package/FetchAddressIntentService.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(servicePackageName)}/service/FetchAddressIntentService.java"></instantiate>
    <instantiate from="root/res/layout/activity_google_ding_wei.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${activityLayoutName}.xml"></instantiate>
    <instantiate from="root/src/app_package/ArmsLocationEntity.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(adapterEntityName)}/${pageName}Entity.java"></instantiate>

    <merge from="root/res/values/strings.xml.ftl" to="${projectOut}/src/main/res/values/strings.xml"></merge>
    <merge from="root/AndroidManifest.xml.ftl" to="app/src/main/AndroidManifest.xml"></merge>

    <copy from="root/res/xml/google_maps_api.xml" to="${projectOut}/src/debug/res/values/google_maps_api.xml"></copy>
    <copy from="root/res/xml/google_maps_api.xml" to="${projectOut}/src/release/res/values/google_maps_api.xml"></copy>

    <open file="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></open>
    <open file="${projectOut}/src/main/java/${slashedPackageName(modelPackageName)}/${pageName}Model.java"></open>


</#if>

<#if isStartActivity>

    <instantiate from="root/src/app_package/ArmsActivityStart.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></instantiate>
    <instantiate from="root/res/layout/activity_start.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${activityLayoutName}.xml"></instantiate>
   <instantiate from="root/src/app_package/ArmsAdapterEntity.java.ftl"
                 to="${projectOut}/src/main/java/${slashedPackageName(adapterEntityName)}/${pageName}.java"></instantiate>

    <merge from="root/res/values/strings.xml.ftl" to="${projectOut}/src/main/res/values/strings.xml"></merge>
    <merge from="root/AndroidManifest.xml.ftl" to="app/src/main/AndroidManifest.xml"></merge>

  
    <merge from="root/res/values/styles.xml.ftl" to="${projectOut}/src/main/res/values/styles.xml"></merge>
    <copy from="root/res/drawable-xxhdpi/guide_img.png" to="${projectOut}/src/main/res/drawable-xxhdpi/guide_img.png"></copy>

    <open file="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.java"></open>
    <open file="${projectOut}/src/main/java/${slashedPackageName(modelPackageName)}/${pageName}Model.java"></open>
</#if>

</recipe>
