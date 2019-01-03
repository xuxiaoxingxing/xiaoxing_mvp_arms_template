package com.xiaoxing.maji.mvp.ui.viewpager;


import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;

import com.xiaoxing.maji.mvp.ui.fragment.Tab1Fragment;
import com.xiaoxing.maji.mvp.ui.fragment.Tab2Fragment;
import com.xiaoxing.maji.mvp.ui.fragment.Tab3Fragment;
import com.xiaoxing.maji.mvp.ui.fragment.Tab4Fragment;
import com.xiaoxing.maji.mvp.ui.fragment.Tab5Fragment;

public class MyViewPagerAdapter extends FragmentPagerAdapter {

    private int size;

    public MyViewPagerAdapter(FragmentManager fm, int size) {
        super(fm);
        this.size = size;
    }

    @Override
    public Fragment getItem(int position) {
        Fragment fragment = null;
        switch (position) {
            case 0:
                fragment = Tab1Fragment.newInstance();
                break;
            case 1:
                fragment = Tab2Fragment.newInstance();
                break;
            case 2:
                fragment = Tab3Fragment.newInstance();
                break;
            case 3:
                fragment = Tab4Fragment.newInstance();
                break;
            case 4:
                fragment = Tab5Fragment.newInstance();
                break;
        }

        return fragment;
    }

    @Override
    public int getCount() {
        return size;
    }
}
