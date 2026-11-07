package controller;

import dto.Patient;
import service.HospitalService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "SearchPatientController", urlPatterns = {"/SearchPatientController"})
public class SearchPatientController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HospitalService service = (HospitalService) getServletContext().getAttribute("hospitalService");

        String id = request.getParameter("id");
        Patient patient = service.searchById(id);

        request.setAttribute("patient", patient);
        request.setAttribute("searchedId", id);

        request.getRequestDispatcher("search.jsp").forward(request, response);
    }
}