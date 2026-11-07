package controller;

import dto.Patient;
import service.HospitalService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "ListPatientController", urlPatterns = {"/ListPatientController"})
public class ListPatientController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HospitalService service = (HospitalService) getServletContext().getAttribute("hospitalService");

        String type = request.getParameter("type"); // waiting | admitted | all

        Patient[] list = null;
        String title = "";

        if ("waiting".equals(type)) {
            list = service.getWaitingList();
            title = "Danh sách hàng chờ";
        } else if ("admitted".equals(type)) {
            list = service.getAdmittedList();
            title = "Danh sách bệnh nhân đang điều trị";
        } else {
            list = service.getAllPatientsSorted();
            title = "Toàn bộ bệnh nhân (sắp xếp theo ID - BST)";
        }

        request.setAttribute("list", list);
        request.setAttribute("title", title);

        request.getRequestDispatcher("patientList.jsp").forward(request, response);
    }
}