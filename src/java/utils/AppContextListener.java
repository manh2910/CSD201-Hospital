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

        // Khởi tạo HospitalService (bên trong sẽ tự load dữ liệu từ Database)
        HospitalService service = new HospitalService();
        context.setAttribute("hospitalService", service);

        System.out.println(">>> HospitalService đã khởi tạo và load dữ liệu từ Database");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println(">>> Ứng dụng HospitalManagement đã dừng");
    }
}