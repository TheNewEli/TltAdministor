package online.caoyu.controller;

import online.caoyu.model.AdminInfo;
import online.caoyu.service.AdminInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
public class AdminInfoController {
    @Autowired
    private AdminInfoService adminInfoService;

    /**
     * 用户登入
     *
     * @param adminInfo
     * @return
     */
    @RequestMapping("/login")
    public String login(AdminInfo adminInfo, HttpServletRequest request, Model model) {
        String msg = "";
        //根据登入账号判断该用户是否存在
        AdminInfo admin = adminInfoService.selectAdminByLoginName(adminInfo.getAdminAccount());
        if (admin == null) {
            msg = "该用户不存在！"+adminInfo.getAdminAccount()+adminInfo.getAdminPassword()+adminInfo.getAdminId();
        } else {
            if (admin.getAdminPassword().equals(adminInfo.getAdminPassword())) {
                /*将用户信息放入session*/
                request.getSession().setAttribute("adminInfo", admin);
                //获取sessionid
                String sessionId = request.getSession().getId();
                model.addAttribute("sessionId", sessionId);
                //进入主界面
                return "/main";
            } else {
                msg = "密码错误！";
            }
        }
        model.addAttribute("msg", msg);
        return "/login";
    }

    /**
     * 退出系统
     *
     * @return
     */
    @RequestMapping("/loginOut")
    public String loginOut(HttpServletRequest request) {
        //清空session
        request.getSession().invalidate();
        return "login";
    }


}