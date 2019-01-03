package ${modelPackageName};

import android.app.Application;
import com.google.gson.Gson;
import com.jess.arms.integration.IRepositoryManager;
import com.jess.arms.mvp.BaseModel;

<#if needActivity && needFragment>
    import com.jess.arms.di.scope.ActivityScope;
<#elseif needActivity>
    import com.jess.arms.di.scope.ActivityScope;
<#elseif needFragment>
    import com.jess.arms.di.scope.FragmentScope;
</#if>

import javax.inject.Inject;

import ${contractPackageName}.${pageName}Contract;


<#if isListActivity>
    import com.xiaoxing.maji.mvp.api.ApiService;
    import ${packageName}.mvp.ui.entity.${pageName};
    import io.reactivex.Observable;
</#if>
<#if isNormalActivity>
    import com.xiaoxing.maji.mvp.api.ApiService;
    import ${packageName}.mvp.ui.entity.${pageName};
    import io.reactivex.Observable;
</#if>
<#if needFragment>
    import com.xiaoxing.maji.mvp.api.ApiService;
    import ${packageName}.mvp.ui.entity.${pageName};
    import io.reactivex.Observable;
</#if>



<#if needActivity && needFragment>
    @ActivityScope
<#elseif needActivity>
    @ActivityScope
<#elseif needFragment>
    @FragmentScope
</#if>
public class ${pageName}Model extends BaseModel implements ${pageName}Contract.Model{
    @Inject
    Gson mGson;
    @Inject
    Application mApplication;

    @Inject
    public ${pageName}Model(IRepositoryManager repositoryManager) {
        super(repositoryManager);
    }

    <#if isListActivity>
        @Override
        public Observable<${pageName}> get${pageName}List() {
            return mRepositoryManager.obtainRetrofitService(ApiService.class).get${pageName}List();

        }
    </#if>
    <#if isNormalActivity>
        @Override
        public Observable<${pageName}> get${pageName}Data() {
            return mRepositoryManager.obtainRetrofitService(ApiService.class).get${pageName}Data();

        }
    </#if>
    <#if needFragment>
        @Override
        public Observable<${pageName}> get${pageName}Data() {
            return mRepositoryManager.obtainRetrofitService(ApiService.class).get${pageName}Data();

        }
    </#if>

    @Override
    public void onDestroy() {
        super.onDestroy();
        this.mGson = null;
        this.mApplication = null;
    }
}