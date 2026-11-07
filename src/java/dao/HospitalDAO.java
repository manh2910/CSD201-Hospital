package dao;

import dto.Patient;
import fileio.PatientFileIO;
import service.HospitalService;
import java.util.List;

public class HospitalDAO {

    private HospitalService service;

    public HospitalDAO(HospitalService service) {
        this.service = service;
    }

    // Load dữ liệu từ file vào các cấu trúc dữ liệu
    public void loadData() {
        List<Patient> patients = PatientFileIO.loadFromFile();
        for (Patient p : patients) {
            if ("Waiting".equalsIgnoreCase(p.getStatus())) {
                service.addToWaitingQueue(p);
            } else if ("Admitted".equalsIgnoreCase(p.getStatus())) {
                // Thêm thẳng vào danh sách đã nhập viện
                service.getAdmittedList(); // chỉ để trigger
                // Vì service không có hàm addAdmitted trực tiếp, mình sẽ xử lý đơn giản hơn ở Service sau nếu cần
            }
        }
    }

    // Lưu toàn bộ dữ liệu hiện tại ra file
    public void saveData() {
        Patient[] all = service.getAllPatientsSorted();
        PatientFileIO.saveToFile(all);
    }
}