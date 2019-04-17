package ${presenterPackageName};

import android.app.Application;

import com.jess.arms.integration.AppManager;
<#if needActivity && needFragment>
    import com.jess.arms.di.scope.ActivityScope;
<#elseif needActivity>
    import com.jess.arms.di.scope.ActivityScope;
<#elseif needFragment>
    import com.jess.arms.di.scope.FragmentScope;
</#if>
import com.jess.arms.utils.RxLifecycleUtils;
import com.jess.arms.mvp.BasePresenter;
import com.jess.arms.http.imageloader.ImageLoader;
import me.jessyan.rxerrorhandler.core.RxErrorHandler;
import javax.inject.Inject;
import java.util.Map;

import ${contractPackageName}.${pageName}Contract;


<#if isListActivity>

    import ${packageName}.mvp.ui.entity.${pageName};
    import io.reactivex.android.schedulers.AndroidSchedulers;
    import io.reactivex.schedulers.Schedulers;
    import me.jessyan.rxerrorhandler.core.RxErrorHandler;
    import me.jessyan.rxerrorhandler.handler.ErrorHandleSubscriber;

</#if>

<#if isNormalActivity>

    import ${packageName}.mvp.ui.entity.${pageName};
    import io.reactivex.android.schedulers.AndroidSchedulers;
    import io.reactivex.schedulers.Schedulers;
    import me.jessyan.rxerrorhandler.core.RxErrorHandler;
    import me.jessyan.rxerrorhandler.handler.ErrorHandleSubscriber;

</#if>
<#if needFragment>

    import ${packageName}.mvp.ui.entity.${pageName};
    import io.reactivex.android.schedulers.AndroidSchedulers;
    import io.reactivex.schedulers.Schedulers;
    import me.jessyan.rxerrorhandler.core.RxErrorHandler;
    import me.jessyan.rxerrorhandler.handler.ErrorHandleSubscriber;

</#if>



<#if needActivity && needFragment>
    @ActivityScope
<#elseif needActivity>
    @ActivityScope
<#elseif needFragment>
    @FragmentScope
</#if>
public class ${pageName}Presenter extends BasePresenter<${pageName}Contract.Model, ${pageName}Contract.View> {
    @Inject
    RxErrorHandler mErrorHandler;
    @Inject
    Application mApplication;
    @Inject
    ImageLoader mImageLoader;
    @Inject
    AppManager mAppManager;

    @Inject
    public ${pageName}Presenter (${pageName}Contract.Model model, ${pageName}Contract.View rootView) {
        super(model, rootView);
    }
    <#if isListActivity>

        public void get${pageName}List(Map<String, String> map) {

            mModel.get${pageName}List(map).subscribeOn(Schedulers.io())
                    //                .retryWhen(new RetryWithDelay(3, 2))//遇到错误时重试,第一个参数为重试几次,第二个参数为重试的间隔
                    .doOnSubscribe(disposable -> {
                        mRootView.showLoading();
                    }).subscribeOn(AndroidSchedulers.mainThread())
                    .observeOn(AndroidSchedulers.mainThread())
                    .doFinally(() -> {
                        mRootView.hideLoading();
                    })
                    .compose(RxLifecycleUtils.bindToLifecycle(mRootView))//使用 Rxlifecycle,使 Disposable 和 Activity 一起销毁
                    .subscribe(new ErrorHandleSubscriber<${pageName}>(mErrorHandler) {
                        @Override
                        public void onNext(${pageName} entityList) {
                            mRootView.get${pageName}DataSuccess(entityList);
                        }
                    });
        }

    </#if>
    <#if isNormalActivity>

        public void get${pageName}Data(Map<String, String> map) {

            mModel.get${pageName}Data(map).subscribeOn(Schedulers.io())
                    //                .retryWhen(new RetryWithDelay(3, 2))//遇到错误时重试,第一个参数为重试几次,第二个参数为重试的间隔
                    .doOnSubscribe(disposable -> {
                        mRootView.showLoading();
                    }).subscribeOn(AndroidSchedulers.mainThread())
                    .observeOn(AndroidSchedulers.mainThread())
                    .doFinally(() -> {
                        mRootView.hideLoading();
                    })
                    .compose(RxLifecycleUtils.bindToLifecycle(mRootView))//使用 Rxlifecycle,使 Disposable 和 Activity 一起销毁
                    .subscribe(new ErrorHandleSubscriber<${pageName}>(mErrorHandler) {
                        @Override
                        public void onNext(${pageName} entityData) {
                            mRootView.get${pageName}DataSuccess(entityData);
                        }
                    });
        }

    </#if>
    <#if needFragment>

        public void get${pageName}Data(Map<String, String> map) {

            mModel.get${pageName}Data(map).subscribeOn(Schedulers.io())
                    //                .retryWhen(new RetryWithDelay(3, 2))//遇到错误时重试,第一个参数为重试几次,第二个参数为重试的间隔
                    .doOnSubscribe(disposable -> {
                        mRootView.showLoading();
                    }).subscribeOn(AndroidSchedulers.mainThread())
                    .observeOn(AndroidSchedulers.mainThread())
                    .doFinally(() -> {
                        mRootView.hideLoading();
                    })
                    .compose(RxLifecycleUtils.bindToLifecycle(mRootView))//使用 Rxlifecycle,使 Disposable 和 Activity 一起销毁
                    .subscribe(new ErrorHandleSubscriber<${pageName}>(mErrorHandler) {
                        @Override
                        public void onNext(${pageName} entityData) {
                            mRootView.get${pageName}DataSuccess(entityData);
                        }
                    });
        }

    </#if>

    @Override
    public void onDestroy() {
        super.onDestroy();
        this.mErrorHandler = null;
        this.mAppManager = null;
        this.mImageLoader = null;
        this.mApplication = null;
    }
}
