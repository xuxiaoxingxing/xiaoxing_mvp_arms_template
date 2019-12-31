package ${ativityPackageName};

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import com.jess.arms.base.BaseActivity;
import com.jess.arms.di.component.AppComponent;
import com.jess.arms.utils.ArmsUtils;

import ${componentPackageName}.Dagger${pageName}Component;
import ${moudlePackageName}.${pageName}Module;
import ${contractPackageName}.${pageName}Contract;
import ${presenterPackageName}.${pageName}Presenter;

import ${packageName}.R;

import me.jessyan.armscomponent.commonres.utils.ToolbarUtils;
import me.jessyan.armscomponent.commonres.utils.CProgressDialogUtils;
import me.jessyan.armscomponent.commonsdk.core.RouterHub;

import static com.jess.arms.utils.Preconditions.checkNotNull;



@Route(path = RouterHub.${activityToLayout(pageName)})
public class ${pageName}Activity extends BaseActivity<${pageName}Presenter> implements ${pageName}Contract.View {


        <#if needHeadRightButton>
            @BindView(R.id.btnRight)
            TextView mBtnRight;
            private View.OnClickListener mRightListener = new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    ToastUtils.showToast(${pageName}Activity.this, "保存成功");
                    finish();

                }
            };

        </#if>


    @Override
    public void setupActivityComponent(@NonNull AppComponent appComponent) {
        Dagger${pageName}Component //如找不到该类,请编译一下项目
        .builder()
        .appComponent(appComponent)
        .${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Module(new ${pageName}Module(this))
        .build()
        .inject(this);
    }

    @Override
    public int initView(@Nullable Bundle savedInstanceState) {
        return R.layout.${activityLayoutName}; //如果你不需要框架帮你设置 setContentView(id) 需要自行设置,请返回 0
    }

    @Override
    public void initData(@Nullable Bundle savedInstanceState) {

    <#if needHeadRightButton>
        ToolbarUtils.initToolbarTitleBackWithRightButton(this, getString(R.string.${activityToLayout(pageName)}), mRightListener);
        mBtnRight.setText(${activityRightButtonName});
    <#else>
        ToolbarUtils.initToolbarTitleBack(this, getString(R.string.${activityToLayout(pageName)}));
    </#if>
        //get${pageName}Data();
    }

    @Override
    public void get${pageName}DataSuccess(${pageName} entityData) {


    }

    private void get${pageName}Data() {
        HashMap<String, String> map = new HashMap<>();

        mPresenter.get${pageName}Data(map);
    }



    @Override
    public void showLoading() {
        CProgressDialogUtils.showProgressDialog(this);
    }

    @Override
    public void hideLoading() {
        CProgressDialogUtils.cancelProgressDialog(this);
    }

    @Override
    public void showMessage(@NonNull String message) {
        checkNotNull(message);
        ArmsUtils.makeText(this, message);
    }

    @Override
    public void launchActivity(@NonNull Intent intent) {
        checkNotNull(intent);
        ArmsUtils.startActivity(intent);
    }

    @Override
    public void killMyself() {
        finish();
    }
    }
