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

@Route(path = RouterHub.XIAO_XING_SETTING_GONG_NENG_SHEN_QING_ACTIVITY_ACTIVITY)
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
        private RecyclerView mRecyclerView;
        private RefreshLayout mRefreshLayout;
        private ${pageName}Adapter mAdapter;

        private View mEmptyLayout;
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
        ToolbarUtils.initToolbarTitleBackWithRightButton(this, "修改ID", mRightListener);
        mBtnRight.setText(R.string.xiaoxing_setting_wan_cheng);
    <#elseif needActivity>
        ToolbarUtils.initToolbarTitleBack(this, "");
    </#if>

    <#if isListActivity>
     mRefreshLayout = findViewById(R.id.refreshLayout);
            mRefreshLayout.setRefreshHeader(new ClassicsHeader(this).setSpinnerStyle(SpinnerStyle.FixedBehind).setPrimaryColorId(R.color.public_colorPrimary).setAccentColorId(android.R.color.white));
            mRefreshLayout.setOnRefreshListener(this);

            mRecyclerView = (RecyclerView) findViewById(R.id.recyclerView);
            mRecyclerView.setItemAnimator(new DefaultItemAnimator());
            mRecyclerView.setLayoutManager(new GridLayoutManager(this, 3));
            mRecyclerView.addItemDecoration(new DividerItemDecoration(this, VERTICAL));

            mEmptyLayout = findViewById(R.id.empty);

            ImageView image = (ImageView) findViewById(R.id.empty_image);
            image.setImageResource(R.drawable.ic_empty);

            TextView empty = (TextView) findViewById(R.id.empty_text);
            empty.setText("暂无数据下拉刷新");

            /*主动演示刷新*/
            if (mIsNeedDemo) {
                mRefreshLayout.getLayout().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        if (mIsNeedDemo) {
                            mRefreshLayout.autoRefresh();
                        }
                    }
                }, 3000);
                mRefreshLayout.setOnMultiPurposeListener(new SimpleMultiPurposeListener() {
                    @Override
                    public void onStateChanged(@NonNull RefreshLayout refreshLayout, @NonNull RefreshState oldState, @NonNull RefreshState newState) {
                        mIsNeedDemo = false;
                    }
                });
            }
            mRefreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {
                @Override
                public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                    mRefreshLayout.finishLoadMore();
                }
            });
    </#if>


    }
    <#if isListActivity>
      @Override
        public void onRefresh(@NonNull RefreshLayout refreshLayout) {
            mRefreshLayout.getLayout().postDelayed(new Runnable() {
                @Override
                public void run() {

    //                mRecyclerView.setLayoutManager(new LinearLayoutManager(${pageName}Activity.this));
                    mRecyclerView.addItemDecoration(new DividerItemDecoration(${pageName}Activity.this, VERTICAL));
                    mRecyclerView.setItemAnimator(new DefaultItemAnimator());
                    mRecyclerView.setAdapter(mAdapter = new ${pageName}Adapter(loadModels()));
                    //                mRecyclerView.setAdapter(new BaseRecyclerAdapter<Item>(Arrays.asList(Item.values()), simple_list_item_2, FragmentOrderList.this) {
                    //                    @Override
                    //                    protected void onBindViewHolder(SmartViewHolder holder, Item model, int position) {
                    //                        holder.text(android.R.id.text1, model.name());
                    ////                        holder.text(android.R.id.text2, model.name);
                    ////                        holder.textColorId(android.R.id.text2, R.color.colorTextAssistant);
                    //                    }
                    //                });
                    mRefreshLayout.finishRefresh();
                    mEmptyLayout.setVisibility(View.GONE);
                }
            }, 2000);
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
