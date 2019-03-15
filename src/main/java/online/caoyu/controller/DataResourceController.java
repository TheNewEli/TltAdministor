package online.caoyu.controller;


import online.caoyu.model.DataResource;
import online.caoyu.service.DataResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/dataResource")
public class DataResourceController {
    @Autowired
    private DataResourceService dataResourceService;


    /**
     * 停用数据源
     *
     * @param dataResourceId 数据源ID
     * @return
     */
    @RequestMapping("/disableDataResource")
    public String disableDataResource(int dataResourceId) {
        DataResource dataResource = new DataResource();
        dataResource.setDataResourceId(dataResourceId);
        dataResource.setDataResourceStatus("未生效");
        try {
            dataResourceService.updateDataResource(dataResource);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/dataResource/selectAll";
    }

    /**
     * 启用数据源
     *
     * @param dataResourceId 数据源ID
     * @return
     */
    @RequestMapping("/enableDataResource")
    public String enableDataResource(int dataResourceId) {
        DataResource dataResource = new DataResource();
        dataResource.setDataResourceId(dataResourceId);
        dataResource.setDataResourceStatus("生效中");
        try {
            dataResourceService.updateDataResource(dataResource);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/dataResource/selectAll";
    }

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
     * @param file
     * @param dataResource
     * @return
     */
    @RequestMapping("/addDataResource")
    public String addDataResource(MultipartFile file, DataResource dataResource, HttpServletRequest request) throws IOException {
        dataResource.setDataResourceFileName(file.getOriginalFilename());
        dataResourceService.insertDataResource(dataResource);

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