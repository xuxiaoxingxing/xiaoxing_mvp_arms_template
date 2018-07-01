package ${adapterPackageName};

import android.support.annotation.Nullable;

import com.chad.library.adapter.base.BaseQuickAdapter;
import com.chad.library.adapter.base.BaseViewHolder;
import ${packageName}.mvp.ui.entity.${pageName};

import java.util.List;

import ${packageName}.R;


public class ${pageName}Adapter extends BaseQuickAdapter<${pageName}, BaseViewHolder> {
    public ${pageName}Adapter(@Nullable List<${pageName}> data) {
        super(R.layout.${adapterLayoutName}, data);
    }

    @Override
    protected void convert(BaseViewHolder helper, ${pageName} item) {

    }

}
