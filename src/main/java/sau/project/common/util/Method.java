package sau.project.common.util;

import java.util.ArrayList;
import java.util.List;

public class Method {

    public static List<Integer> transformation(String value){
        List<Integer> val = new ArrayList<Integer>();
        for (String index:
            value.substring(0,value.length()-1).split(",")) {
                val.add(Integer.valueOf(index));
            }
        return val;
    }
    public static String removeValue(String value,Integer jobId){
        List<Integer> val = new ArrayList<Integer>();
        List<Integer> va = new ArrayList<Integer>();
        for (String index:
            value.substring(0,value.length()-1).split(",")) {
            val.add(Integer.valueOf(index));
        }
        for (Integer index:
             val) {
            if(index!=jobId){
                va.add(index);
            }
        }
        String string ="";
        for (Integer index:
             va) {
            string = string+index+",";

        }
        return string;
    }
}
