package ${contractPackageName};

import com.jess.arms.mvp.IView;
import com.jess.arms.mvp.IModel;
import java.util.Map;

<#if isListActivity>
	import ${packageName}.mvp.ui.entity.${pageName};
	import io.reactivex.Observable;
</#if>
<#if isNormalActivity>
	import ${packageName}.mvp.ui.entity.${pageName};
	import io.reactivex.Observable;
</#if>
<#if isStartActivity>
	import ${packageName}.mvp.ui.entity.${pageName};
	import io.reactivex.Observable;
</#if>
<#if needFragment>
	import ${packageName}.mvp.ui.entity.${pageName};
	import io.reactivex.Observable;
</#if>
public interface ${pageName}Contract {
    //对于经常使用的关于UI的方法可以定义到IView中,如显示隐藏进度条,和显示文字消息
    interface View extends IView {
		<#if isListActivity>
			void get${pageName}DataSuccess(${pageName} entityList);
		</#if>
		<#if isNormalActivity>
			void get${pageName}DataSuccess(${pageName} entityData);
		</#if>
		<#if isStartActivity>
			void get${pageName}DataSuccess(${pageName} entityData);
		</#if>
		<#if needFragment>
			void get${pageName}DataSuccess(${pageName} entityData);
		</#if>
    }
    //Model层定义接口,外部只需关心Model返回的数据,无需关心内部细节,即是否使用缓存
    interface Model extends IModel{
		<#if isListActivity>
			Observable<${pageName}> get${pageName}List(Map<String, String> map);
		</#if>
		<#if isNormalActivity>
			Observable<${pageName}> get${pageName}Data(Map<String, String> map);
		</#if>
		<#if isStartActivity>
			Observable<${pageName}> get${pageName}Data(Map<String, String> map);
		</#if>
		<#if needFragment>
			Observable<${pageName}> get${pageName}Data(Map<String, String> map);
		</#if>
    }
}
