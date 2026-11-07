package utils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import service.HospitalService;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        HospitalService service = new HospitalService();
        context.setAttribute("hospitalService", service);
        System.out.println(">>> HospitalService đã được khởi tạo và đưa vào ServletContext");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println(">>> Ứng dụng đã dừng");
    }
}