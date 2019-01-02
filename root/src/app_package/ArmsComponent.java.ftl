package ${componentPackageName};

import dagger.Component;
import com.jess.arms.di.component.AppComponent;

import ${moudlePackageName}.${pageName}Module;

<#if isNormalActivity && needFragment>
import com.jess.arms.di.scope.ActivityScope;
import ${ativityPackageName}.${pageName}Activity;
import ${fragmentPackageName}.${pageName}Fragment;
<#elseif isNormalActivity>
import com.jess.arms.di.scope.ActivityScope;
import ${ativityPackageName}.${pageName}Activity;
<#elseif needFragment>
import com.jess.arms.di.scope.FragmentScope;
import ${fragmentPackageName}.${pageName}Fragment;
</#if>

<#if isNormalActivity && needFragment>
@ActivityScope
<#elseif isNormalActivity>
@ActivityScope
<#elseif needFragment>
@FragmentScope
</#if>
@Component(modules = ${pageName}Module.class,dependencies = AppComponent.class)
public interface ${pageName}Component {
<#if isNormalActivity && needFragment>
	void inject(${pageName}Activity activity);
	void inject(${pageName}Fragment fragment);
<#elseif isNormalActivity || needFragment>
    void inject(<#if needFragment>${pageName}Fragment fragment<#else>${pageName}Activity activity</#if>);
</#if>
}