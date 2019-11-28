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



@Route(path = RouterHub.${activityToLayout(pageName)})
public class ${pageName}Activity extends BaseActivity<${pageName}Presenter> implements ${pageName}Contract.View {

    private ViewPager viewPager;

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
        PageNavigationView tab = (PageNavigationView) findViewById(R.id.tab);

        NavigationController navigationController = tab.custom()
        .addItem(newItem(R.drawable.tab_001_normal, R.drawable.tab_001_selected, "首頁"))
        .addItem(newItem(R.drawable.tab_002_normal, R.drawable.tab_002_selected, "活動訊息"))
        .addItem(newItem(R.drawable.tab_004_normal, R.drawable.tab_004_selected, "好友"))
        .addItem(newItem(R.drawable.tab_003_normal, R.drawable.tab_003_selected, "收藏"))
        .addItem(newItem(R.drawable.tab_005_normal, R.drawable.tab_005_selected, "我的"))
        .build();

        viewPager = (ViewPager) findViewById(R.id.viewPager);
        viewPager.setAdapter(new MyViewPagerAdapter(getSupportFragmentManager(), navigationController.getItemCount()));
        viewPager.setOffscreenPageLimit(5);

        navigationController.setupWithViewPager(viewPager);
        navigationController.addTabItemSelectedListener(new OnTabItemSelectedListener() {
        @Override
        public void onSelected(int index, int old) {
        //
        //                if (index == 3) {
        //
        //                    Intent intent = new Intent(MainActivity.this, LoginActivity.class);
        //                    startActivity(intent);
        //                }
        }

        @Override
        public void onRepeat(int index) {
        //                if (index == 3) {
        //
        //                    Intent intent = new Intent(MainActivity.this, LoginActivity.class);
        //                    startActivity(intent);
        //                }
        }
        });
    }

    private BaseTabItem newItem(int drawable, int checkedDrawable, String text) {
        SpecialTab mainTab = new SpecialTab(this);
        mainTab.initialize(drawable, checkedDrawable, text);
        mainTab.setTextDefaultColor(getResources().getColor(R.color.public_black));
        mainTab.setTextCheckedColor(Color.parseColor("#BD1123"));
        return mainTab;
    }


    private BaseTabItem newRoundItem(int drawable, int checkedDrawable, String text) {
        SpecialTabRound mainTab = new SpecialTabRound(this);
        mainTab.initialize(drawable, checkedDrawable, text);
        mainTab.setTextDefaultColor(getResources().getColor(R.color.public_white));
        mainTab.setTextCheckedColor(getResources().getColor(R.color.public_white));
        return mainTab;
    }

    @Override
    public void showLoading() {
        LoadingDialogUtil.showGifdialog2(getSupportFragmentManager(), R.drawable.public_loading);
    }

    @Override
    public void hideLoading() {
        LoadingDialogUtil.dismissDialog();
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
