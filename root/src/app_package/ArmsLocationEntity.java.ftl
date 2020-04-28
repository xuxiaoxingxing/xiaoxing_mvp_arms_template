package ${adapterEntityName};
import java.util.List;

public class ${pageName}Entity {

	/**
     * code : 200
     * msg : success
     * data : 
     */

    private String code;
    private String msg;
    private List<DataBean> data;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public List<DataBean> getData() {
        return data;
    }

    public void setData(List<DataBean> data) {
        this.data = data;
    }

    public static class DataBean {
        private int img;

        public int getImg() {
        return img;
        }

        public void setImg(int img) {
        this.img = img;
        }
    }

}
