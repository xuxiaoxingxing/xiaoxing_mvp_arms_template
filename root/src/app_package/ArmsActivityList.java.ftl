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

import me.jessyan.armscomponent.commonsdk.core.RouterHub;

import static com.jess.arms.utils.Preconditions.checkNotNull;

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

@Route(path = RouterHub.${activityToLayout(pageName)})
public class ${pageName}Activity extends BaseActivity<${pageName}Presenter> implements ${pageName}Contract.View  <#if isListActivity>, OnRefreshListener</#if>{


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


    <#if isListActivity>
  
        private ${pageName}Adapter mAdapter;

        @BindView(R.id.empty_text)
        TextView empty_text;
        @BindView(R.id.empty_image)
        ImageView empty_image;

        @BindView(R.id.empty)
        View mEmptyLayout;
        @BindView(R.id.recyclerView)
        RecyclerView mRecyclerView;
        @BindView(R.id.refreshLayout)
        RefreshLayout mRefreshLayout;
        private static boolean mIsNeedDemo = true;
        private List<${pageName}.DataBean> mDataBeanList = new ArrayList<>();
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

    <#if isListActivity>
        initRefreshLayout();
        initRecyclerView();
        initEmpty();
    </#if>

    }


    <#if isListActivity>
        private void initEmpty() {
            empty_image.setImageResource(R.drawable.ic_empty);
            empty_text.setTextColor(getResources().getColor(R.color.public_white));
            empty_text.setText("暫無數據下拉刷新");
        }

        private List<${pageName}.DataBean> loadModels() {
            List<${pageName}.DataBean> lists = new ArrayList<>();

            for (int i = 0; i < 5; i++) {

                ${pageName}.DataBean dataBean = new ${pageName}.DataBean();
                lists.add(dataBean);
            }

            return lists;
        }

        private void initRecyclerView() {
            mRecyclerView.setLayoutManager(new LinearLayoutManager(${pageName}Activity.this));
            mRecyclerView.addItemDecoration(new RecycleViewDivider(this, LinearLayoutManager.VERTICAL, 10, Color.parseColor("#EEEEEE")));

            <#--mRecyclerView.addItemDecoration(new DividerItemDecoration(${pageName}Activity.this, VERTICAL));-->
            mRecyclerView.setItemAnimator(new DefaultItemAnimator());
            mRecyclerView.setAdapter(mAdapter = new ${pageName}Adapter(${pageName}Activity.this, mDataBeanList = loadModels()));

            mAdapter.setOnItemClickListener(new BaseQuickAdapter.OnItemClickListener() {
                @Override
                public void onItemClick(BaseQuickAdapter adapter, View view, int position) {
                    <#--Utils.navigation(${pageName}Activity.this, RouterHub.SALES_CLIENT_ZUI_XIN_XIAO_XI_XIANG_QING_ACTIVITY);-->
                }
            });
        }

        private void initRefreshLayout() {
            mRefreshLayout.setRefreshHeader(new
        ClassicsHeader(this).setSpinnerStyle(SpinnerStyle.FixedBehind).setPrimaryColorId(R.color.public_colorPrimary).setAccentColorId(android.R.color.white));
            mRefreshLayout.setOnRefreshListener(this);
            mRefreshLayout.autoRefresh();
            mRefreshLayout.setEnableLoadMore(false);
        }

        @Override
        public void onRefresh(@NonNull RefreshLayout refreshLayout) {

            get${pageName}List();
            mRefreshLayout.finishRefresh();
            mEmptyLayout.setVisibility(View.GONE);

        }

        @Override
        public void get${pageName}DataSuccess(${pageName} entityList) {

            if (entityList != null && entityList.getData() != null && entityList.getData().size() > 0) {
                mDataBeanList.clear();
                mDataBeanList.addAll(entityList.getData());
                mAdapter.notifyDataSetChanged();
                mEmptyLayout.setVisibility(View.GONE);
            } else {
                mEmptyLayout.setVisibility(View.VISIBLE);
            }

        }

        private void get${pageName}List() {
            mPresenter.get${pageName}List();
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
