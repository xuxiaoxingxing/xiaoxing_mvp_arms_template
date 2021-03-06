package ${adapterPackageName};

import android.support.annotation.Nullable;
import android.content.Context;
import com.chad.library.adapter.base.BaseQuickAdapter;
import com.chad.library.adapter.base.BaseViewHolder;
import ${packageName}.mvp.ui.entity.${pageName};
//import me.jessyan.armscomponent.commonres.utils.GlideUtil;

import java.util.List;

import ${packageName}.R;


public class ${pageName}Adapter extends BaseQuickAdapter<${pageName}.DataBean, BaseViewHolder> {
	
	private Context mContext;

    public ${pageName}Adapter(Context context,@Nullable List<${pageName}.DataBean> data) {
        super(R.layout.${adapterLayoutName}, data);
        this.mContext = context;
    }

    @Override
    protected void convert(BaseViewHolder helper, ${pageName}.DataBean item) {
        //GlideUtil.loadImage(mContext,item.getImg(),helper.getView(R.id.img_head));
        //helper.setText(R.id.tv_dian_jia, item.getType_name());
    }

}
