package ${componentPackageName};

import dagger.Component;
import com.jess.arms.di.component.AppComponent;

import ${moudlePackageName}.${pageName}Module;

<#if needActivity && needFragment>
import com.jess.arms.di.scope.ActivityScope;
import ${ativityPackageName}.${pageName}Activity;
import ${fragmentPackageName}.${pageName}Fragment;
<#elseif needActivity || isListActivity>
import com.jess.arms.di.scope.ActivityScope;
import ${ativityPackageName}.${pageName}Activity;
<#elseif needFragment>
import com.jess.arms.di.scope.FragmentScope;
import ${fragmentPackageName}.${pageName}Fragment;
</#if>

<#if needActivity && needFragment>
@ActivityScope
<#elseif needActivity || isListActivity>
@ActivityScope
<#elseif needFragment>
@FragmentScope
</#if>
@Component(modules = ${pageName}Module.class,dependencies = AppComponent.class)
public interface ${pageName}Component {
<#if needActivity && needFragment>
	void inject(${pageName}Activity activity);
	void inject(${pageName}Fragment fragment);
<#elseif needActivity>
	void inject(${pageName}Activity activity);
<#elseif needFragment>
    void inject(<#if needFragment>${pageName}Fragment fragment<#else>${pageName}Activity activity</#if>);
</#if>
}