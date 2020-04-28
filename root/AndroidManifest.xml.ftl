<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <application>
            <activity
            android:name="${ativityPackageName}.${activityClass}"
            android:configChanges="orientation|screenSize"
            android:screenOrientation="portrait" />

            <#if isGoogleDingWeiActivity>
               <meta-data
	            android:name="com.google.android.geo.API_KEY"
	            android:value="@string/google_maps_key" />

		        <service
		            android:name="${servicePackageName}.FetchAddressIntentService"
		            android:exported="false" />
            </#if>

            <#if isGaoDeDingWeiActivity>
                <meta-data
                android:name="com.amap.api.v2.apikey"
                android:value="ea7cda6c81e4e0fa49025ed6f2bc2e19" />
                <service android:name="com.amap.api.location.APSService" />
            </#if>

    </application>
</manifest>
