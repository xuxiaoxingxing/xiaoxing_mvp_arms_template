package ${fragmentPackageName};

import android.content.Intent;
import android.os.Bundle;
import android.os.Message;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.jess.arms.base.BaseFragment;
import com.jess.arms.di.component.AppComponent;
import com.jess.arms.utils.ArmsUtils;

import ${componentPackageName}.Dagger${pageName}Component;
import ${moudlePackageName}.${pageName}Module;
import ${contractPackageName}.${pageName}Contract;
import ${presenterPackageName}.${pageName}Presenter;

import ${packageName}.R;

import static com.jess.arms.utils.Preconditions.checkNotNull;

<#if isListFragment>
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

public class ${pageName}Fragment extends BaseFragment<${pageName}Presenter> implements ${pageName}Contract.View <#if isListFragment>, OnRefreshListener</#if>{

    <#if isListFragment>
  
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

    public static ${pageName}Fragment newInstance() {
${pageName}Fragment fragment = new ${pageName}Fragment();
    return fragment;
    }

    @Override
    public void setupFragmentComponent(@NonNull AppComponent appComponent) {
    Dagger${pageName}Component //如找不到该类,请编译一下项目
    .builder()
    .appComponent(appComponent)
    .${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Module(new ${pageName}Module(this))
    .build()
    .inject(this);
    }

    @Override
    public View initView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle
    savedInstanceState) {
    return inflater.inflate(R.layout.${fragmentLayoutName}, container, false);
    }

    @Override
    public void initData(@Nullable Bundle savedInstanceState) {

        <#if isListFragment>
            initRefreshLayout();
            initRecyclerView();
            initEmpty();
        </#if>
        get${pageName}Data();
    }


    @Override
    public void get${pageName}DataSuccess(${pageName} entityList) {
        <#if isListFragment>
            if (entityList != null && entityList.getData() != null && entityList.getData().size() > 0) {
                    mDataBeanList.clear();
                    mDataBeanList.addAll(entityList.getData());
                    mAdapter.notifyDataSetChanged();
                    mEmptyLayout.setVisibility(View.GONE);
                    mRecyclerView.setVisibility(View.VISIBLE);
                } else {
                    mEmptyLayout.setVisibility(View.VISIBLE);
                    mRecyclerView.setVisibility(View.GONE);

                }
         </#if>
    }

    private void get${pageName}Data() {
    HashMap<String, String> map = new HashMap<>();
    mPresenter.get${pageName}Data(map);
    }

    <#if isListFragment>
        private void initEmpty() {
            empty_image.setImageResource(R.drawable.default_img);
            empty_text.setTextColor(Color.parseColor("#D8D8D8"));
            empty_text.setText("暫無數據");
        }

        private void initRecyclerView() {
            mRecyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));
            mRecyclerView.addItemDecoration(new DividerItemDecoration(getActivity(), VERTICAL));
            mRecyclerView.setItemAnimator(new DefaultItemAnimator());
            mRecyclerView.setAdapter(mAdapter = new ${pageName}Adapter(getActivity(), mDataBeanList));

            mAdapter.setOnItemClickListener(new BaseQuickAdapter.OnItemClickListener() {
                @Override
                public void onItemClick(BaseQuickAdapter adapter, View view, int position) {
                    //Utils.navigation(getActivity(), RouterHub.SALES_CLIENT_ZUI_XIN_XIAO_XI_XIANG_QING_ACTIVITY);
                }
            });
        }

        private void initRefreshLayout() {
            mRefreshLayout.setRefreshHeader(new
        ClassicsHeader(getActivity()).setSpinnerStyle(SpinnerStyle.FixedBehind).setPrimaryColorId(R.color.public_colorPrimary).setAccentColorId(android.R.color.white));
            mRefreshLayout.setOnRefreshListener(this);
            mRefreshLayout.setEnableRefresh(false);
            mRefreshLayout.autoRefresh();
            mRefreshLayout.setEnableLoadMore(false);
        }

        @Override
        public void onRefresh(@NonNull RefreshLayout refreshLayout) {

            mRefreshLayout.finishRefresh();
            mEmptyLayout.setVisibility(View.GONE);

        }

    </#if>
    /**
    * 通过此方法可以使 Fragment 能够与外界做一些交互和通信, 比如说外部的 Activity 想让自己持有的某个 Fragment 对象执行一些方法,
    * 建议在有多个需要与外界交互的方法时, 统一传 {@link Message}, 通过 what 字段来区分不同的方法, 在 {@link #setData(Object)}
    * 方法中就可以 {@code switch} 做不同的操作, 这样就可以用统一的入口方法做多个不同的操作, 可以起到分发的作用
    * <p>
        * 调用此方法时请注意调用时 Fragment 的生命周期, 如果调用 {@link #setData(Object)} 方法时 {@link Fragment#onCreate(Bundle)} 还没执行
        * 但在 {@link #setData(Object)} 里却调用了 Presenter 的方法, 是会报空的, 因为 Dagger 注入是在 {@link Fragment#onCreate(Bundle)}
        方法中执行的
        * 然后才创建的 Presenter, 如果要做一些初始化操作,可以不必让外部调用 {@link #setData(Object)}, 在 {@link #initData(Bundle)} 中初始化就可以了
        *
    <p>
        * Example usage:
        *
    <pre>
     * public void setData(@Nullable Object data) {
     *     if (data != null && data instanceof Message) {
     *         switch (((Message) data).what) {
     *             case 0:
     *                 loadData(((Message) data).arg1);
     *                 break;
     *             case 1:
     *                 refreshUI();
     *                 break;
     *             default:
     *                 //do something
     *                 break;
     *         }
     *     }
     * }
     *
     * // call setData(Object):
     * Message data = new Message();
     * data.what = 0;
     * data.arg1 = 1;
     * fragment.setData(data);
     * </pre>
    *
    * @param data 当不需要参数时 {@code data} 可以为 {@code null}
    */
    @Override
    public void setData(@Nullable Object data) {

    }

    @Override
    public void showLoading() {

    }

    @Override
    public void hideLoading() {

    }

    @Override
    public void showMessage(@NonNull String message) {
    checkNotNull(message);
    ArmsUtils.makeText(getActivity(), message);
    }

    @Override
    public void launchActivity(@NonNull Intent intent) {
    checkNotNull(intent);
    ArmsUtils.startActivity(intent);
    }

    @Override
    public void killMyself() {

    }
    }
