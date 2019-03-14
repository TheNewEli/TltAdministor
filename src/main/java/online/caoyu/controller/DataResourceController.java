package online.caoyu.controller;

import javafx.scene.chart.PieChart;
import online.caoyu.model.DataResource;
import online.caoyu.model.PageUtil;
import online.caoyu.model.RoleInfo;
import online.caoyu.service.DataResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/dataResource")
public class DataResourceController {
    @Autowired
    private DataResourceService dataResourceService;


    /**
     * 删除数据源
     *
     * @param dataResourceId 数据源ID
     * @return
     */
    @RequestMapping("/del")
    @ResponseBody
    public String del(int dataResourceId) {
        try {
            dataResourceService.deleteDataResource(dataResourceId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 新增或编辑数据源信息
     *
     * @param dataResource
     * @param model
     * @return
     */
    @RequestMapping("/addDataResource")
    public String addDataResource(DataResource dataResource, Model model, String myid) {
        try {
            DataResource dataResource1 = dataResourceService.selectDataResourceById(dataResource.getDataResourceId());
            if (dataResource1 != null) {
                model.addAttribute("msg", "插入操作失败,该登入名已存在！");
            }

            if (myid != null && !"".equals(myid)) {//myid存在表示编辑操作
                dataResource.setDataResourceId(Integer.parseInt(myid));
                dataResourceService.updateDataResource(dataResource);
                model.addAttribute("msg", "更新操作成功！");
            } else {
                dataResourceService.insertDataResource(dataResource);
                model.addAttribute("msg", "插入操作成功！");
            }


        } catch (Exception e) {
            model.addAttribute("msg", "操作失败！");
            e.printStackTrace();
        }
        return "redirect:/dataResource/selectAll";
    }


    /**
     * 根据ID获取数据源
     *
     * @param dataResourceId
     * @param model
     * @return
     */
    @RequestMapping("selectDataResourceById")
    @ResponseBody
    public DataResource selectDataResourceById(int dataResourceId, Model model) {
        DataResource dataResource = dataResourceService.selectDataResourceById(dataResourceId);
        return dataResource;
    }

    /**
     * 获取所有数据源
     *
     * @return
     */
    @RequestMapping("/selectAll")
    public String selectAll(Model model) {
        //查询数据
        List<DataResource> dataResourceList = dataResourceService.selectAll();

        //设置所有数据源数量
        model.addAttribute("dataResourceList", dataResourceList);
        return "/dataResourceManager";
    }

    /**
     * 停用数据源
     *
     * @return
     */
    @RequestMapping("/disable")
    public String disable(Model model) {
        //查询数据
        List<DataResource> dataResourceList = dataResourceService.selectAll();

        //设置所有数据源数量
        model.addAttribute("dataResourceList", dataResourceList);
        return "/dataResourceManager";
    }
}