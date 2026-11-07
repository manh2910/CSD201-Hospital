package controller;

import dto.Patient;
import service.HospitalService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "AddPatientController", urlPatterns = {"/AddPatientController"})
public class AddPatientController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HospitalService service = (HospitalService) getServletContext().getAttribute("hospitalService");

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String disease = request.getParameter("disease");
        String phone = request.getParameter("phone");

        Patient patient = new Patient(id, name, age, gender, disease, "Waiting", phone);

        boolean success = service.addToWaitingQueue(patient);

        if (success) {
            request.setAttribute("message", "Thêm bệnh nhân vào hàng chờ thành công!");
        } else {
            request.setAttribute("message", "Thêm thất bại! ID đã tồn tại hoặc dữ liệu không hợp lệ.");
        }

        request.getRequestDispatcher("addPatient.jsp").forward(request, response);
    }
}