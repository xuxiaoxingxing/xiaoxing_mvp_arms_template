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


import static com.jess.arms.utils.Preconditions.checkNotNull;

import me.jessyan.armscomponent.commonres.utils.ToolbarUtils;
import me.jessyan.armscomponent.commonsdk.core.RouterHub;

<#if isListActivity>
    import static android.support.v7.widget.DividerItemDecoration.VERTICAL;

    import com.scwang.smartrefresh.layout.api.RefreshLayout;
    import com.scwang.smartrefresh.layout.constant.RefreshState;
    import com.scwang.smartrefresh.layout.constant.SpinnerStyle;
    import com.scwang.smartrefresh.layout.header.ClassicsHeader;
    import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
    import com.scwang.smartrefresh.layout.listener.OnRefreshListener;
    import com.scwang.smartrefresh.layout.listener.SimpleMultiPurposeListener;
    import android.support.v7.widget.DefaultItemAnimator;
    import android.support.v7.widget.DividerItemDecoration;
    import android.support.v7.widget.GridLayoutManager;
    import android.support.v7.widget.LinearLayoutManager;
    import android.support.v7.widget.RecyclerView;

    import ${adapterPackageName}.${pageName}Adapter;

</#if>

@Route(path = RouterHub.${pageName}_ACTIVITY)
public class ${pageName}Activity extends BaseActivity<${pageName}Presenter> implements ${pageName}Contract.View  <#if isListActivity>, OnRefreshListener</#if>{

    <#if needHeadRightButton>
        @BindView(R2.id.btnRight)
        TextView mBtnRight;
        private View.OnClickListener mRightListener = new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ToastUtils.showToast(XiuGaiIDActivity.this, "保存成功");
                finish();

            }
        };

    </#if>


    <#if isListActivity>
  
    private ${pageName}Adapter mAdapter;

    @BindView(R2.id.empty_text)
    TextView empty_text;
    @BindView(R2.id.empty_image)
    ImageView empty_image;

    @BindView(R2.id.empty)
    View mEmptyLayout;
    @BindView(R2.id.recyclerView)
    RecyclerView mRecyclerView;
    @BindView(R2.id.refreshLayout)
    RefreshLayout mRefreshLayout;
    private static boolean mIsNeedDemo = true;
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
        ToolbarUtils.initToolbarTitleBackWithRightButton(this, "${activityName}", mRightListener);
        mBtnRight.setText(${activityRightButtonName});
    <#elseif needActivity>
        ToolbarUtils.initToolbarTitleBack(this, "${activityName}");
    </#if>

    <#if isListActivity>
        initRefreshLayout();
        initRecyclerView();
        initEmpty();
    </#if>


    }
    <#if isListActivity>
        private void initEmpty() {
            empty_image.setImageResource(R.drawable.ic_empty);
            empty_text.setText("暫無數據下拉刷新");
        }

        private void initRecyclerView() {
            mRecyclerView.setLayoutManager(new LinearLayoutManager(HuoDongHuaXuActivity.this));
            mRecyclerView.addItemDecoration(new DividerItemDecoration(HuoDongHuaXuActivity.this, VERTICAL));
            mRecyclerView.setItemAnimator(new DefaultItemAnimator());
            mRecyclerView.setAdapter(mAdapter = new HuoDongHuaXuAdapter(HuoDongHuaXuActivity.this, loadModels()));

            mAdapter.setOnItemClickListener(new BaseQuickAdapter.OnItemClickListener() {
                @Override
                public void onItemClick(BaseQuickAdapter adapter, View view, int position) {
                    Utils.navigation(HuoDongHuaXuActivity.this, RouterHub.SALES_CLIENT_ZUI_XIN_XIAO_XI_XIANG_QING_ACTIVITY);
                }
            });
        }

        private void initRefreshLayout() {
            mRefreshLayout.setRefreshHeader(new ClassicsHeader(this).setSpinnerStyle(SpinnerStyle.FixedBehind).setPrimaryColorId(R.color.public_colorPrimary).setAccentColorId(android.R.color.white));
            mRefreshLayout.setOnRefreshListener(this);
            mRefreshLayout.autoRefresh();
            mRefreshLayout.setEnableLoadMore(false);
        }

        @Override
        public void onRefresh(@NonNull RefreshLayout refreshLayout) {

            mRefreshLayout.finishRefresh();
            mEmptyLayout.setVisibility(View.GONE);

        }

        /**
         * 模拟数据
         */
        private List<${pageName}> loadModels() {
            List<${pageName}> addressLists = new ArrayList<>();

            for (int i = 0; i < 5; i++) {

                ${pageName} addressList = new ${pageName}();
                addressLists.add(addressList);
            }


            return addressLists;
        }

    </#if>

    @Override
    public void showLoading() {

    }

    @Override
    public void hideLoading() {

    }

    @Override
    public void showMessage(@NonNull String message) {
        checkNotNull(message);
        ArmsUtils.snackbarText(message);
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
