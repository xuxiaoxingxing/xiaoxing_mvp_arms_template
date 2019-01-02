package ${modelPackageName};

import android.app.Application;
import com.google.gson.Gson;
import com.jess.arms.integration.IRepositoryManager;
import com.jess.arms.mvp.BaseModel;

<#if isNormalActivity && needFragment>
import com.jess.arms.di.scope.ActivityScope;
<#elseif isNormalActivity>
import com.jess.arms.di.scope.ActivityScope;
<#elseif needFragment>
import com.jess.arms.di.scope.FragmentScope;
</#if>
import javax.inject.Inject;

import ${contractPackageName}.${pageName}Contract;


<#if isNormalActivity && needFragment>
@ActivityScope
<#elseif isNormalActivity>
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

    @Override
    public void onDestroy() {
        super.onDestroy();
        this.mGson = null;
        this.mApplication = null;
    }
}