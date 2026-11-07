package controller;

import dto.Patient;
import service.HospitalService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "CallNextController", urlPatterns = {"/CallNextController"})
public class CallNextController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HospitalService service = (HospitalService) getServletContext().getAttribute("hospitalService");

        Patient patient = service.callNextPatient();

        if (patient != null) {
            request.setAttribute("message", "Đã gọi bệnh nhân: " + patient.getName() + " (ID: " + patient.getId() + ")");
            request.setAttribute("patient", patient);
        } else {
            request.setAttribute("message", "Hàng chờ đang trống!");
        }

        request.getRequestDispatcher("waitingQueue.jsp").forward(request, response);
    }
}